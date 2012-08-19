package control {

	public class AnimationType {
		public static const WALK:AnimationType				= new AnimationType("WALK");
		public static const RUN:AnimationType					= new AnimationType("RUN");
		public static const JUMP:AnimationType				= new AnimationType("JUMP");
		public static const SNEAK:AnimationType				= new AnimationType("SNEAK");
		public static const FLY:AnimationType					= new AnimationType("FLY");
		public static const FALL:AnimationType				= new AnimationType("FALL");
		public static const KNOCK_FORWARD:AnimationType		= new AnimationType("KNOCK_FORWARD");
		public static const KNOCK_BACKWARD:AnimationType		= new AnimationType("KNOCK_BACKWARD");
	
		private var name:String;
		
		/**
		 * Create a new AnimationType		 */
		public function AnimationType(name:String) {
			this.name = name;
		}
		
		/**
		 * Get this animation type as a String		 */
		public function toString():String {
			return this.name;
		}
	}
}