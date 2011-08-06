package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Main extends flash.display.Sprite
	{
		public var game:gameLogic;
		public var state:gameState;
		
		public function Main():void
		{
			
			game = new gameLogic(this);
			game.draw();
			
			state = new gameState(game, this);
		}
	}
}