package object.environment {
	import flash.display.Sprite;
	
	import object.GameObject

	public class RainEffect extends GameObject {
		private var intensity:int;
		private var dropCount:int;
		private var angle:Number;
		private var rainParticles:Array = new Array();
		private var rainRandomness:Array = new Array();
	
		public function RainEffect(intensity:int, dropCount:int, angle:int) {
			this.movementMultiplier = 15;
			
			this.intensity = intensity;
			this.dropCount = dropCount;
			this.angle = angle * (Math.PI / 180);
		
			for (var i:int = 0; i < dropCount; i++) {
				var particle:Sprite = new Sprite();
				
				particle.graphics.lineStyle(1, 0x3333FF);
				var xPos:int = Math.cos(this.angle) * intensity;
				var yPos:int = Math.sin(this.angle) * intensity;
				particle.graphics.lineTo(xPos, -yPos);
				
				this.addChild(particle);
				particle.x = Math.random() * 800;
				particle.y = Math.random() * 600;
				
				this.rainParticles = rainParticles.concat(particle);
				this.rainRandomness = rainRandomness.concat(Math.max(Math.random() * 1.5, 1));
			}
		}
		
		public override function step():void {
			super.step();
			
			for (var i:int = 0; i < this.dropCount; i++) {
				var particle:Sprite = Sprite(this.rainParticles[i]);
				var randomness:Number = Number(this.rainRandomness[i]);
			
				particle.x += -this.horizontalMovement + 2 * Math.cos(this.angle) * this.intensity * randomness;
				particle.y -= -this.verticalMovement + 2 * Math.sin(this.angle) * this.intensity * randomness;
				
				
				// Make rain wrap around
				if (particle.x <= 0)
					particle.x = Math.random() * 800;
				else if (particle.x >= 800)
					particle.x = 0;
				if (particle.y >= 600)
					particle.y = 0;
				else if (particle.y <= 0)
					particle.y = 600;
			}
		}
	
	}

}