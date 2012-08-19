package object {
	import flash.display.Sprite;
	import flash.events.Event;

	public class GameObject extends Sprite {
		protected var isAnimated:Boolean = false;
		
		protected var canMoveDown:Boolean = true;
		protected var canMoveUp:Boolean = true;
		protected var canMoveLeft:Boolean = true;
		protected var canMoveRight:Boolean = true;
		
		
		protected var horizontalMovement:Number = 0;
		protected var verticalMovement:Number = 0;
		
		protected var movementMultiplier:Number;
		
		/**
		 * Create a new GameObject		 */
		public function GameObject() {
			this.addEventListener(Event.ENTER_FRAME, this.step);
		}
		
		/**
		 * Move some direction		 */
		public function move(horizontalMovementVector:int, verticalMovementVector:int):void {
			this.horizontalMovement = movementMultiplier * horizontalMovementVector;
			this.verticalMovement = movementMultiplier * verticalMovementVector;
		}
		
		/**
		 * Step forward one frame 
		 */
		public function step(event:Event):void {
			this.x += this.horizontalMovement;
			this.y += this.verticalMovement;
			
			if (!this.canMoveLeft && this.horizontalMovement <= 0)
				this.horizontalMovement = 0;
			if (!this.canMoveRight && this.horizontalMovement >= 0)
				this.horizontalMovement = 0;
			if (!this.canMoveDown && this.verticalMovement >= 0)
				this.verticalMovement = 0;
			if (!this.canMoveUp && this.verticalMovement <= 0)
				this.verticalMovement = 0;
		}
	
	}

}