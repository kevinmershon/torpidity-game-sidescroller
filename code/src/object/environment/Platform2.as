package object.environment {
	import flash.display.Loader;
	
	import flash.net.URLRequest;

	import object.TangibleObject;

	public class Platform2 extends TangibleObject {
		private var loader:Loader;
		
		/**
		 * Create a new Platform
		 */
		public function Platform(width:int, height:int) {
			super.gravity = 0;
			
			loader = new Loader();
			loader.load(new URLRequest("../images/platform2.png"));
			this.addChild(loader);
		}
		
		/**
		 * Platforms are bottom-transparent
		 */
		public override function isBottomTransparent():Boolean {
			return true;
		}
	
	}

}