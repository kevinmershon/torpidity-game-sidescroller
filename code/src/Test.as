package {
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	import flash.external.ExternalInterface;
	
	import flash.geom.Point;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.utils.Timer;
	
	import control.Logger;
	import control.MovementHandler;
	import object.GameBlock;
	import object.GameObject;
	import object.TangibleObject;
	
	import object.enemy.EnemyObject;
	import object.enemy.Enemy1;
	import object.enemy.Shadow;
	
	import object.environment.Platform;
	import object.environment.RainEffect;
	import object.environment.StarField;
	import object.player.HealthBar;
	import object.player.MainCharacter;
	
	public class Test extends Sprite {
		private var logText:TextField;
		
		private var scrollLayer:Sprite;
		private var mainCharacter:MainCharacter;
		private var gameObjects:Array = new Array();
		
		public static var collisionSprite:Sprite;
		
		public function Test() {
			// Set the background color to dark blue
			this.graphics.beginFill(0x000040);
			this.graphics.drawRect(0, 0, 800, 600);
			this.graphics.endFill();
			
			// Create an 800x600 drawing mask which reduces drawing overhead
			var mask:Sprite = new Sprite();
			mask.graphics.beginFill(0xFFFFFF);
			mask.graphics.drawRect(0,0,800,600);
			this.addChild(mask);
			this.mask = mask;
			
		
			// Create a scrolling layer into which all visible game objects will be drawn
			scrollLayer = new Sprite();
			this.addChild(scrollLayer);
			
			// Create some background elements
			var starField:StarField = new StarField();
			scrollLayer.addChild(starField);
			this.gameObjects = this.gameObjects.concat(starField);
			
			var x:int = 0, y:int = 0;
			for (var n:int = 0; n < 12; n++) {
				var gameBlock:GameBlock = new GameBlock(0x151515 * n);
				gameBlock.x = x * 200;
				gameBlock.y = y * 200;
				scrollLayer.addChild(gameBlock);
				this.gameObjects = this.gameObjects.concat(gameBlock);
				
				x++;
				if (n > 0 && n % 4 == 3) {
					x = 0;
					y++;
				}
			}
		
			var nextPlatformIndex:int = 0;
			var platformLocations:Array = new Array();
			for (var currentX:int = 0; currentX < 4000; currentX += 240) {
				platformLocations[nextPlatformIndex++] = new Point(currentX, 600);
			}
		
			// Add platforms to the game
			platformLocations[nextPlatformIndex++] = new Point(450, 450);
			platformLocations[nextPlatformIndex++] = new Point(50, 350);
			platformLocations[nextPlatformIndex++] = new Point(600, 260);
			platformLocations[nextPlatformIndex++] = new Point(150, 130);
			
			for (var i:int = 0; i<platformLocations.length; i++) {
				var platform:Platform = new Platform();
				platform.x = platformLocations[i].x;
				platform.y = platformLocations[i].y;
				scrollLayer.addChild(platform);
				this.gameObjects = this.gameObjects.concat(platform);
			}

			
			// Add 10 Shadows to the game
			for (var j:int = 0; j < 10; j++) {
				var enemy:EnemyObject = new Shadow();
				enemy.x = Math.random() * 800;
				enemy.y = 0;
				scrollLayer.addChild(enemy);
				this.gameObjects = this.gameObjects.concat(enemy);
			}


			// Create the main character and position it centered on the screen
			mainCharacter = new MainCharacter();
			mainCharacter.x = 400;
			mainCharacter.y = -1000;
			this.gameObjects = this.gameObjects.concat(mainCharacter);
			scrollLayer.addChild(mainCharacter);
			
			var healthBar:HealthBar = new HealthBar(mainCharacter);
			this.gameObjects = this.gameObjects.concat(healthBar);
			this.addChild(healthBar);
			
			collisionSprite = new Sprite();
			collisionSprite.alpha = .5;
			collisionSprite.x = 300;
			collisionSprite.y = 300;
			this.addChild(collisionSprite);
			
			
			/*
			// Add the rain effect
			var rain:RainEffect = new RainEffect(5, 150, 235);
			this.gameObjects = this.gameObjects.concat(rain);
			scrollLayer.addChild(rain);
			*/
			
			// Initialize the movement handler
			var movementHandler:MovementHandler = new MovementHandler([mainCharacter, starField]);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, movementHandler.keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, movementHandler.keyUpHandler);
			
			
			
			// Add a text field for displaying logged messages for debugging
			logText = new TextField();
			logText.width = 800;
			logText.height = 80;
			logText.x = 0;
			logText.y = 60;
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.color = 0xFFFFFF;
			format.size = 10;
			logText.defaultTextFormat = format;
			this.addChild(logText);
			
			Logger.log("[No errors]");
			
			var gameTimer:Timer = new Timer(15);
			gameTimer.addEventListener(TimerEvent.TIMER, handleCollisions);
			gameTimer.start();
		}
		
		/**
		 * Called once per frame
		 */
		private function handleCollisions(event:Event):void {
			try {
				for each (var object1:GameObject in gameObjects) {
					
					// Perform collision-testing
					if (object1 is TangibleObject) {
						var tangibleObject1:TangibleObject = object1 as TangibleObject;
						var collisionObject:TangibleObject = null;
						
						for each (var object2:GameObject in gameObjects) {
							if (object1 == object2 || !(object2 is TangibleObject))
								continue;
							
							// Test for collision
							var tangibleObject2:TangibleObject = object2 as TangibleObject;
							if (tangibleObject1.collisionTest(tangibleObject2)) {
								collisionObject = tangibleObject2;
								break;
							}
						}
						
						// No collision, allow free movement
						if (collisionObject == null)
							tangibleObject1.clearCollision();
					}
				}	
			} catch (e:Error) {
				Logger.log(e.message + "\n" + e.getStackTrace());
			}
		}
	
	}
}