package object.player {
	import flash.display.GradientType;
	
	import flash.events.Event;

	import control.Logger;
	import object.CharacterObject;

	public class MainCharacter extends CharacterObject {
		
		
		/**
		 * Create a new MainCharacter
		 */
		public function MainCharacter() {
			super();
			super.JUMP_TIME = 31;
			super.movementMultiplier = 15;
			super.MAX_HITPOINTS = 6;
			super.hitpoints = 6;
			
			var colors:Array = [0xFF0000, 0x0000FF];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];	
				
			this.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, null, null);
			this.graphics.drawCircle(25, 25, 50);
			this.graphics.endFill();
		}
		
		/**
		 * Move some direction
		 */
		public override function move(horizontalMovementVector:int, verticalMovementVector:int):void {
			this.horizontalMovement = movementMultiplier * horizontalMovementVector;
			// ignore vertical movement
		}
		
		/**
		 * Step forward one frame
		 */
		public override function step(event:Event):void {
			super.step(event);
			
			if (this.hitpoints <= 0 || this.hitpoints >= 6)
				this.hitpoints = 6;
			
			if (this.jumpTimer > 0) {
				// Jump, if we can
				this.verticalMovement = -jumpTimer;
				this.jumpTimer -= 2;
				this.jumpTimer = Math.max(0, this.jumpTimer);
			}
			
			this.parent.x = -this.x + 375;
			this.parent.y = -this.y + 275;
		}
	
	}

}