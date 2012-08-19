package object.environment {
	import flash.display.Loader;

	import flash.events.Event;
	
	import flash.net.URLRequest;

	import object.TangibleObject;

	public class Platform extends TangibleObject {
		private var loader:Loader;
		
		/**
		 * Create a new Platform
		 */
		public function Platform() {		
			super();
			this.GRAVITY = 0;
				
			loader = new Loader();
			loader.load(new URLRequest("../images/platform1.png"));
			this.addChild(loader);
		}
		
		/**
		 * Platforms are bottom-transparent
		 */
		public override function isBottomTransparent():Boolean {
			return false;
		}
		
		public override function step(event:Event):void {
			super.step(event);
		}
	
	}

}