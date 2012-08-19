package object {
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	import flash.utils.Timer;
	
	import control.Logger;
	
	public class CharacterObject extends TangibleObject {
		protected var JUMP_TIME:int = 10;
		
		private var impactTimer:Timer;
		private var isInvulnerable:Boolean;
		protected var MAX_HITPOINTS:int;
		protected var hitpoints:int;
		
		protected var jumpTimer:int;
		
		/**
		 * Create a new CharacterObject		 */
		public function CharacterObject() {
			super();
			super.isAnimated = true;
			this.impactTimer = new Timer(2000);
			impactTimer.addEventListener(TimerEvent.TIMER, damageFinish);
		}
		
		/**
		 * Finish the "damage" state (return the character back to vulnerable state)
		 */
		private function damageFinish(event:Event):void {
			this.isInvulnerable = false;
			this.impactTimer.reset();
			Logger.log("Character is vulnerable again.");
		}
		
		/**
		 * Get the hitpoint percentage for display on the HealthBar		 */
		public function getHPpercent():Number {
			return Number(this.hitpoints / this.MAX_HITPOINTS);
		}
		
		/**
		 * Jump		 */
		public function jump(isJumping:Boolean):void {
			if (this.jumpTimer == 0 && this.verticalMovement == 0 && isJumping) {
				this.jumpTimer = JUMP_TIME;
				Logger.log("Character jumped!");
			} else if (this.jumpTimer > 0 && this.verticalMovement < 0 && !isJumping) {
				this.jumpTimer /= 2;
				this.verticalMovement /= 2;
			}
		}
		
		/**
		 * Make the character take some damage		 */
		public function takeDamage(damage:int):void {
			if (this.isInvulnerable)
				return;
			
			this.hitpoints -= damage;
			this.isInvulnerable = true;
			this.impactTimer.start();
			Logger.log("Character suffers " + damage + " damage! (Character is now invulnerable)");
		}
		
	}
	
}