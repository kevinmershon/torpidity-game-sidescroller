package control {

	import flash.display.Loader;
	import flash.display.Sprite;
	
	import flash.net.URLRequest;
	
	public class Animation extends Sprite {
		private var basePath:String;
		private var animationType:AnimationType;
		private var frameCount:int;
		
		private var frames:Array;
		private var currentFrame:int;
		
		/**
		 * Create a new Animation with the specified base path and frame count		 */
		public function Animation(basePath:String, animationType:AnimationType, frameCount:int) {
			this.basePath = basePath;
			this.animationType = animationType;
			this.frameCount = frameCount;
		}
		
		/**
		 * Get the animation type		 */
		public function getAnimationType():AnimationType {
			return this.animationType;
		}
		
		/**
		 * Load the animation frames		 */
		public function load():void {
			this.currentFrame = Math.random() * this.frameCount;
			this.frames = new Array(this.frameCount);
		
			var frame:Loader = null;
			for (var i:int = 0; i < frameCount; i++) {
				frame = new Loader();
				
				// GOTCHA -- Assume files formatted as "basePathXXXX.png"
				var frameNumber:String = (("0000" + i) as String).slice(-4);
				var filename:String = basePath + frameNumber + ".png";
				
				//Logger.log("Loading frame " + filename + "\n");
				
				frame.load(new URLRequest(filename));
				frame.visible = false;
				this.frames[i] = frame;
				this.addChild(frame);
			}
		}
		
		/**
		 * Show the next frame		 */
		public function nextFrame():void {
			this.frames[currentFrame].visible = false;
			currentFrame++;
			if (currentFrame == frameCount)
				currentFrame = 0;
			this.frames[currentFrame].visible = true;
		}
		
		/**
		 * Restart the animation back at frame 0		 */
		public function restart():void {
			this.frames[currentFrame].visible = false;
			currentFrame = 0;
			this.frames[currentFrame].visible = true;
		}
	}
}