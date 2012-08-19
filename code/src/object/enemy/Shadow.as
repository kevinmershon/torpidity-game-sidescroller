package object.enemy {
	import flash.events.Event;
	
	import control.Animation;
	import control.AnimationType;
	
	public class Shadow extends EnemyObject {
		private var animation:Animation;
		
		private var frameCount:int = 24;
		
		private var hasLoaded:Boolean = false;
		
		/**
		 * Create a new Shadow
		 */
		public function Shadow() {
			//super.BASE_HEIGHT = 100;
			super.alpha = 0.5;
			
			this.animation = new Animation("../images/shadow_walking_frames/shadow_walking.", AnimationType.WALK, frameCount);		
			this.animation.load();
			this.addChild(animation);
			
			this.horizontalMovement = -2;
		}
		
		/**
		 * Step forward one frame
		 */
		public override function step(event:Event):void {
			super.step(event);
			this.animation.nextFrame();
			
			if (this.x < -60) {
				this.x = Math.random() * 800;
				this.y = 0;
			}
		}
	}
	
}