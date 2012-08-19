package object.enemy {
	import flash.display.Loader;
	
	import flash.events.Event;
	
	import flash.net.URLRequest;

	public class Enemy1 extends EnemyObject {
		private var loader:Loader;
		
		
		/**
		 * Create a new Enemy1
		 */
		public function Enemy1() {
			super.BASE_HEIGHT = 600 - 64;
			super.JUMP_TIME = 10;
		
			loader = new Loader();
			loader.load(new URLRequest("../images/enemy1.png"));
			this.addChild(loader);
		}
		
		/**
		 * Step forward one frame
		 */
		public override function step():void {
			if (super.jumpTimer == 0) {
				this.horizontalMovement = 0;
				
			 	if (Math.random() < .05)		// 5 percent chance to jump
					super.jumpTimer = JUMP_TIME;
			} else if (this.jumpTimer > 0) {
				// Jump, if we can
				this.verticalMovement = -jumpTimer;
				this.jumpTimer--;
				this.jumpTimer = Math.max(0, this.jumpTimer);
				this.horizontalMovement = -5;
			}
			
			// Apply gravity
			if (this.jumpTimer == 0 && this.verticalMovement < gravity) {
				this.verticalMovement += 2;
			}
			
			// Stop vertical movement if we're hitting something
			var radius:Number = 64;
			if (this.collisionObject != null) {
				var horizontallyContained:Boolean = (this.x + radius > collisionObject.x
						&& this.x - radius < (collisionObject.x + collisionObject.width));
				var aboveObject:Boolean = (this.y < collisionObject.y);
				var belowObject:Boolean = (this.y > (collisionObject.y + collisionObject.height));
				
				if (horizontallyContained && aboveObject && verticalMovement > 0) {
					this.verticalMovement = 0;
					this.y = collisionObject.y - radius;
				} else if (horizontallyContained && this.verticalMovement < 0
						&& belowObject && !collisionObject.isBottomTransparent()) {
					this.jumpTimer = 0;
					this.verticalMovement = 0;
					this.y = collisionObject.y + collisionObject.height + radius;
				}
				
				// Reset the collision detection
				this.collisionObject = null;
			}
			
			if (this.y >= BASE_HEIGHT) {
				// We can only jump from a surface
				if (this.verticalMovement > 0)
					this.verticalMovement = 0;
				this.y = BASE_HEIGHT;
			}
			if (this.x <= -64) {
				this.y = 0;
				this.x = Math.random() * 800;
			}
			
			this.x += this.horizontalMovement;			
			this.y += this.verticalMovement;
		}
	
	}

}