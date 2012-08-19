package object {
	import control.Logger;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	
	import flash.events.Event;
	
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;

	public class TangibleObject extends GameObject {
		private static const DEBUG:Boolean = false;
		protected var GRAVITY:Number = 30;
		
		protected var isAboveObject:Boolean;
		protected var collisionObject:TangibleObject;
		
		/**
		 * Create a new TangibleObject		 */
		public function TangibleObject() {
			super();
		}
		
		/**
		 * Check whether this object is bottom-transparent
		 */
		public function isBottomTransparent():Boolean {
			return false;
		}
		
		/**
		 * Clear the collision object		 */
		public function clearCollision():void {
			if (!this.isAnimated)
				return;
			
			if (this.collisionObject != null)
				//Logger.log("Collision cleared for object " + this.toString());
			this.collisionObject = null;
			this.canMoveLeft = true;
			this.canMoveRight = true;
			this.canMoveDown = true;
			this.canMoveUp = true;
		}
		
		/**
		 * Forecast the next frame using this object, the specified object, and their
		 * respective movement vectors. If a collision occurs, set this object's 
		 * "collisionObject" value to the specified object.
		 */
		public function collisionTest(other:TangibleObject):Boolean {
			if (!(other is TangibleObject) || !this.isAnimated)
				return false;
			
			// First use rectangular intersection (bounding box)
			var thisRectangle:Rectangle = new Rectangle(this.x + this.horizontalMovement,
					this.y + this.verticalMovement + 1, this.width, this.height);
			var thatRectangle:Rectangle = new Rectangle(other.x + other.horizontalMovement,
					other.y + other.verticalMovement, other.width, other.height);
			
			// If there's no intersection between the rectangles, there's definitely no collision.
			var bbIntersection:Rectangle = thisRectangle.intersection(thatRectangle);
			if (bbIntersection.width == 0) {
				return false;
			}
			
			// Next, do a pixel-perfect collision detection
			var ppIntersection:Rectangle = pixelPerfectCollisionTest(this, other);
			if (ppIntersection.width == 0)
				return false;
		
			var aboveObject:Boolean = ppIntersection.y > this.height * .75;
		
			this.collisionObject = other;
			if (this.verticalMovement >= 0 && aboveObject) {
				this.canMoveUp = false;
				this.canMoveDown = false;
				while (ppIntersection.height > 2) {
					this.verticalMovement--;
					// Redo the pixel-perfect collision detection
					ppIntersection = pixelPerfectCollisionTest(this, other);
				}
				return true;
			} else if (/*belowObject && */this.verticalMovement < 0 && !other.isBottomTransparent()) {
				// Hit the bottom of a non-transparent ceiling
				this.canMoveUp = false;
				while (ppIntersection.height > 2) {
					this.verticalMovement++;
					ppIntersection = pixelPerfectCollisionTest(this, other);
				}
				return true;
			} else
				return true;
			
			return true;
		}
		
		/**
		 * Do a pixel-perfect collision-test between the two objects
		 */
		private static function pixelPerfectCollisionTest(object1:TangibleObject, object2:TangibleObject):Rectangle {
			// Pixel-perfect collision detection
			var img:BitmapData = new BitmapData(object1.width * 2, object1.height * 2, false);
			
			// Handle this object
			var matrix:Matrix = object1.transform.concatenatedMatrix;
			matrix.tx = object1.width / 2;
			matrix.ty = object1.height / 2 + 1;
			img.draw(object1, matrix, transform1);
			
			// Handle the other object
			matrix = object2.transform.concatenatedMatrix;
			matrix.tx = (object1.width / 2) + (object2.x + object2.horizontalMovement) - (object1.x + object1.horizontalMovement);
			matrix.ty = (object1.height / 2) + (object2.y + object2.verticalMovement) - (object1.y + object1.verticalMovement);
			img.draw(object2, matrix, transform2, BlendMode.DIFFERENCE);
			
			if (DEBUG) {		
				try {
					Test.collisionSprite.removeChildAt(0);
				} catch (e:Error) {
					// ignore
				}
				Test.collisionSprite.addChild(new Bitmap(img));
			}
		
			// Get the intersection
			return img.getColorBoundsRect(0xFFFFFFFF, 0xFFFFFF00);
		}
		
		public override function step(event:Event):void {
			super.step(event);
			
			if (this.canMoveDown && this.verticalMovement < this.GRAVITY) {
				this.verticalMovement += 2;
			}		
		}
		
		private static var transform1:ColorTransform = new ColorTransform(1, 1, 1, 1, 255, -255, -255, 0);
		private static var transform2:ColorTransform = new ColorTransform(1, 1, 1, 1, -255, 255, -255, 0);
	}

}