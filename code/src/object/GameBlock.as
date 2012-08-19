package object {
	public class GameBlock extends GameObject {
	
		public function GameBlock(color:int) {
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, 200, 200);
			this.graphics.endFill();
		}
	}
}