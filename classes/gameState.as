/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldType;
	import flash.text.Font;
	import Web.Web;
	
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	import flash.events.IOErrorEvent
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	
	import JSONLib.JSON;

	public class gameState {
		
		public var game:gameLogic;
		public var mainSprite:Sprite;
		
		public var titleSprite:Sprite;
		public var title:DisplayObject;
		public var titleGoButton:evadeButton;
		public var highscoreSprite:HighscoreLoader;
		public var central:Sprite;
		
		public var gameoverSprite:Sprite;
		public var gameover:DisplayObject;
		public var gameoverGoButton:evadeButton;
		public var score_txt:flash.text.TextField;
		
		public var highscore:DisplayObject;
		public var highscoreGoButton:evadeButton;
		public var highscoreTxtBox:TextField;
		public var highscoreTxtFormat:TextFormat;
		
		
		public function gameState(g:gameLogic , m:Sprite) {
			game = g;
			mainSprite = m;
			
			game.setGameOverCB(gameOver);
			
			var s:skin = skin.getInstance();
			
			//title sprite layout
			titleSprite = new Sprite();
			title = new s.UI_Title();
			titleSprite.addChild(title);
			titleGoButton = new evadeButton("GO");
			titleGoButton.x = 210; titleGoButton.y = 215;
			titleSprite.addChild(titleGoButton);
			titleGoButton.setFunction(play);
			highscoreSprite = new HighscoreLoader();
			mainSprite.addChild(titleSprite);
			titleSprite.addChild(highscoreSprite);
			titleSprite.visible = false;
			central = new s.UI_Central;
			central.x = 320;
			central.buttonMode = true;
			central.addEventListener(MouseEvent.MOUSE_DOWN, goToEvadeCentral);
			titleSprite.addChild(central);
			
			//gameover sprite layout
			gameoverSprite = new Sprite();
			gameover = new s.UI_Gameover();
			gameoverSprite.addChild(gameover);
			gameoverGoButton = new evadeButton("OK");
			gameoverGoButton.x = 210; gameoverGoButton.y = 195;
			gameoverSprite.addChild(gameoverGoButton);
			gameoverGoButton.setFunction(splash);
			
			//highscore gameover
			highscore = new s.UI_Highscore();
			gameoverSprite.addChild(highscore);
			highscoreGoButton = new evadeButton("OK");
			highscoreGoButton.x = 210; highscoreGoButton.y = 310;
			gameoverSprite.addChild(highscoreGoButton);
			gameoverSprite.visible = false;
			mainSprite.addChild(gameoverSprite);
			highscoreGoButton.setFunction(sendHighscore);
			
			//gameover time score
			highscoreTxtBox = new TextField();
			highscoreTxtBox.autoSize = TextFieldAutoSize.LEFT;
			highscoreTxtBox.selectable = true;
			highscoreTxtBox.type = TextFieldType.INPUT;
			highscoreTxtBox.text = "Fancypants McGee";
			highscoreTxtBox.autoSize = TextFieldAutoSize.NONE;
			highscoreTxtBox.width = 450;
			highscoreTxtBox.height = 50;
			highscoreTxtFormat = highscoreTxtBox.getTextFormat();
			Font.registerFont(gameLogic.Arial);
			highscoreTxtFormat.font = "Arial";
			highscoreTxtBox.background = true;
			highscoreTxtBox.backgroundColor = 0xffffff;
			highscoreTxtBox.border = true;
			highscoreTxtBox.borderColor = 0x000000;
			highscoreTxtFormat.color = 0x000000;
			highscoreTxtFormat.align = TextFormatAlign.CENTER;
			highscoreTxtFormat.size = 40;
			highscoreTxtFormat.bold = true;
			highscoreTxtBox.y = 250;
			highscoreTxtBox.x = 25;
			gameoverSprite.addChild(highscoreTxtBox);
			
			highscoreTxtBox.setTextFormat(highscoreTxtFormat);
			
			highscoreSprite.y = 275;
			highscoreSprite.x = 20;
			
			splash();
			//gameOver();
		}
		
		public function goToEvadeCentral(e:MouseEvent):void
		{
			Web.Web.getURL("workshop.blabberize.com/evade/", "new_window");
		}
		
		public function splash(e:MouseEvent = null):void
		{
			titleSprite.visible = true;
			gameoverSprite.visible = false;
			
			game.startGame();
			game.reset();
			game.startGame();
			game.player.setAlive(false);
			game.player.visible = false;
		}
		
		public function play(e:MouseEvent = null):void
		{
			titleSprite.visible = false;
			gameoverSprite.visible = false;
			
			game.player.x = mainSprite.mouseX;
			game.player.y = mainSprite.mouseY;
			
			game.player.setAlive(true);
			game.reset();
			
			game.startGame();
			game.player.visible = true;
		}
		
		public var host:String = "http://workshop.blabberize.com/evade/view/";
		public var latestScore:Number = 0;
		public function gameOver(score:Number):void
		{
			game.player.setAlive(false);
			titleSprite.visible = false;
			gameoverSprite.visible = true;
			gameover.visible = true;
			highscore.visible = false;
			highscoreGoButton.visible = false;
			gameoverGoButton.visible = false;
			highscoreTxtBox.visible = false;
			
			latestScore = score;
			
			var datavars:URLVariables = new URLVariables();
			datavars.score = score;
			
			
			var request:URLRequest = new URLRequest(host + "ishighscore.php");
			var loader:URLLoader = new URLLoader();
			//loader.dataFormat = URLLoaderDataFormat.TEXT;
			request.data = datavars;
			request.method = URLRequestMethod.POST;
			loader.addEventListener(Event.COMPLETE, highScoreCheck);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);			
		}
		
		public function highScoreCheck(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.target);
            trace("highScoreCheck completeHandler: " + loader.data);
			var data:Object = JSON.decode(loader.data);
			
			
			if (data.result == true)
			{
				if (data.rank)
				{	
					trace("Ranked!");
					//gameover scene highscore
					highscore.visible = true;
					highscoreGoButton.visible = true;
					gameoverGoButton.visible = false;
					highscoreTxtBox.visible = true;
				}
				else
				{
					trace("No Rank!");
					//gameover scene No Highscore
					highscore.visible = false;
					highscoreGoButton.visible = false;
					gameoverGoButton.visible = true;
				}
			}
		}
		
		public function sendHighscore(e:MouseEvent):void
		{
			var datavars:URLVariables = new URLVariables();
			datavars.score = latestScore;
			datavars.name = highscoreTxtBox.text;
			trace("SendingHighScore: score-" + datavars.score + " name-" + datavars.name);
			
			var request:URLRequest = new URLRequest(host + "addscore.php");
			var loader:URLLoader = new URLLoader();
			//loader.dataFormat = URLLoaderDataFormat.TEXT;
			request.data = datavars;
			request.method = URLRequestMethod.POST;
			loader.addEventListener(Event.COMPLETE, sendHighscoreComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
			
		}
		
		public function sendHighscoreComplete(event:Event):void
		{
			trace("gameState Highscore Complte");
			highscoreSprite.drawScore();
			splash();
		}
		
		
		private function loginHandleComplete(event:Event):void 
		{
			var loader:URLLoader = URLLoader(event.target);
            trace("login completeHandler: " + loader.data);
			var data:Object = JSON.decode(loader.data);
		}
		
		private function onIOError(event:IOErrorEvent):void 
		{
			trace("Error IO." + event.text);
		}
		
	}
	
}
