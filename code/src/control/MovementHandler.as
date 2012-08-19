package control {
	import flash.events.KeyboardEvent;	

	import object.CharacterObject;
	import object.GameObject;

	public class MovementHandler {
		private var movableObjects:Array;
	
		/**
		 * Create a new movement handler
		 */
		public function MovementHandler(movableObjects:Array) {
			this.movableObjects = movableObjects;
		}
		
		/**
		 * Start the specified key event
		 */
		public function keyDownHandler(event:KeyboardEvent):void {
			for each (var gameObject:GameObject in this.movableObjects) {
				switch(event.keyCode) {
					case 65:				// A key
					case 37:				// left arrow
						gameObject.move(-1, 0);
						break;
					case 68:				// D key
					case 39:				// right arrow
						gameObject.move(1, 0);
						break;
					case 83:				// S key
					case 40:				// down arrow
						break;
					case 87:				// W key
					case 38:				// up arrow
					case 32:				// spacebar
						if (gameObject is CharacterObject)
							CharacterObject(gameObject).jump(true);
						break;
			}
			}
		}
		
		/**
		 * Stop doing the specified key event
		 */
		public function keyUpHandler(event:KeyboardEvent):void {
			for each (var gameObject:GameObject in this.movableObjects) {
				switch(event.keyCode) {
					case 65:				// A key
					case 68:				// D key
					case 37:				// left arrow
					case 39:				// right arrow
						gameObject.move(0, 0);
						break;
					case 87:				// W key
					case 38:				// up arrow
					case 32:				// spacebar
						if (gameObject is CharacterObject)
							CharacterObject(gameObject).jump(false);
						break;
			}
			}
		}
	
	}

}