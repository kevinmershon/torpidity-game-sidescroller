package object.environment {
	import flash.display.Loader;
	
	import flash.net.URLRequest;
	
	import object.GameObject;
	
	public class StarField extends GameObject {
		private var starArray:Array;
		
		public function StarField() {
			this.movementMultiplier = 14.5;
			
			this.starArray = new Array();
			
			for (var s:int = 0; s < 150; s++) {
				var starLoader:Loader = new Loader();
				var starNumber:int = Math.random() * 3;
				switch (starNumber) {
					case 0:
						starLoader.load(new URLRequest("../images/star_small.png"));
						break;
					case 1:
						starLoader.load(new URLRequest("../images/star_medium.png"));
						break;
					starLoader.load(new URLRequest("../images/star_large.png"));
						break;
				}
				starLoader.x = Math.random() * 800;
				starLoader.y = Math.random() * 600;
				this.addChild(starLoader);
			}
		}
	}	
}