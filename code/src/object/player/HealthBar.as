package object.player {
	import flash.display.GradientType;
	import flash.display.Sprite;
	
	import flash.events.Event;
	
	import control.Logger;
	import object.GameObject;
	
	public class HealthBar extends GameObject {
		
		private var mainCharacter:MainCharacter;
		private var lastHPpercent:Number;
		private var maskSprite:Sprite;
		
		/**
		 * Create a new HealthBar for the MainCharacter		 */
		public function HealthBar(mainCharacter:MainCharacter) {
			super();
			this.mainCharacter = mainCharacter;
			this.lastHPpercent = 100;
			
			this.x = 15;
			this.y = 15;
	
			/**
			 * Create two subsprites in which the color gradients from red to green are rendered			 */
	
			var colors:Array = [0xFF0000, 0xFFFF00];
			var alphas:Array = [.8, .8];
			var ratios:Array = [127, 255];	
			var subSprite1:Sprite = new Sprite();
			subSprite1.x = 0;		
			subSprite1.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, null, null);
			subSprite1.graphics.drawRect(0, 0, 90, 20);
			subSprite1.graphics.endFill();
			
			colors = [0xFFFF00, 0x00FF00];
			alphas = [.8, .8];
			ratios = [127, 255];
			var subSprite2:Sprite = new Sprite();
			subSprite2.x = 90;
			subSprite2.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, null, null);
			subSprite2.graphics.drawRect(0, 0, 90, 20);
			subSprite2.graphics.endFill();
			
			this.addChild(subSprite1);
			this.addChild(subSprite2);
			
			/**
			 * Create a mask for adjusting the total amount of health			 */
			maskSprite = new Sprite();
			this.addChild(maskSprite);
			this.mask = maskSprite;
		}
		
		/**
		 * Redraw the overlay mask		 */
		private function redrawMask():void {
			maskSprite.graphics.clear();
			maskSprite.graphics.beginFill(0xFFFFFF);
			var xPos:int = 0;
			while (xPos < (180 * this.lastHPpercent)) {
				maskSprite.graphics.drawRect(xPos, 0, 25, 20);
				xPos += 30;
			}
			maskSprite.graphics.endFill();
		}
		
		/**
		 * Step forward one frame		 */
		public override function step(event:Event):void {
			if (this.mainCharacter.getHPpercent() == this.lastHPpercent)
				return;
			
			this.lastHPpercent = this.mainCharacter.getHPpercent();
			this.redrawMask();
		}
	}
}