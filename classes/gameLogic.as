/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.ui.Mouse;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.Font;
	
	public class gameLogic {
		
		public var bordersBlocks:Array;
		
		public var enemyBlocks:Array;
		
		public var player:playerBlock;
		
		public var updateTimer:Timer;
		public var updateSpeedTimer:sinceTimer;
		
		public var mainSprite:Sprite;
		
		public var gameWidth:Number = 500;
		public var gameHeight:Number = 500;
		public var wallWidth:Number = 50;
		
		public var startTime:Date;
		public var endTime:Date;
		
		public var score_txt:TextField;
		public var score_format:TextFormat;
		[Embed(source = "C:/windows/fonts/arial.ttf", fontFamily = "Arial")] public static var Arial:Class;
		
		public var gameoverCB:Function;
		
		
		public function gameLogic(m:Sprite) 
		{
			mainSprite = m;
			
			updateTimer = new Timer(10);
			updateTimer.addEventListener(TimerEvent.TIMER, update);
			updateSpeedTimer = new sinceTimer();
			
			bordersBlocks = new Array();
			
			//define the border blocks
			var b1:block = new block(0, 0, gameWidth, wallWidth); // top bar
			var b2:block = new block(0, 0, wallWidth, gameHeight); // left bar 
			var b3:block = new block(0, gameWidth - wallWidth, gameWidth, wallWidth); //bottom bar
			var b4:block = new block(gameWidth - wallWidth, 0, wallWidth, gameHeight); //right bar
			
			//add the border blocks to the borderArray
			bordersBlocks.push(b1);
			bordersBlocks.push(b2);
			bordersBlocks.push(b3);
			bordersBlocks.push(b4);
			
			//display the border blocks
			mainSprite.addChild(b1);
			mainSprite.addChild(b2);
			mainSprite.addChild(b3);
			mainSprite.addChild(b4);
			
			enemyBlocks = new Array();
			
			//define the enemy blocks
			var e1:enemy = new enemy(20, 50, 150, 50, 1, 1.5);
			var e2:enemy = new enemy(400, 50, 50, 100, -1.3, 1.5);
			var e3:enemy = new enemy(20, 400, 100, 80, 1, -1.5);
			var e4:enemy = new enemy(400, 380, 80, 110, -1, -1.5);
			
			enemyBlocks.push(e1);
			enemyBlocks.push(e2);
			enemyBlocks.push(e3);
			enemyBlocks.push(e4);
			
			mainSprite.addChild(e1);		
			mainSprite.addChild(e2);
			mainSprite.addChild(e3);
			mainSprite.addChild(e4);
			
			player = new playerBlock(gameWidth / 2, gameHeight / 2, 50, 50);
			player.setAlive(true);
			mainSprite.addChild(player);
			
			//gameover time score
			score_txt = new TextField();
			score_txt.autoSize = TextFieldAutoSize.LEFT;
			score_txt.selectable = false;
			score_txt.text = "TIME: 1234567890.0 Sec";
			score_format = score_txt.getTextFormat();
			Font.registerFont(gameLogic.Arial);
			score_format.font = "Arial";
			score_format.color = 0xFFFFFF;
			score_format.align = TextFormatAlign.CENTER;
			score_format.size = 40;
			score_format.bold = true;
			
			score_txt.setTextFormat(score_format);
			
			score_txt.x = score_txt.y = 0;
			mainSprite.addChild(score_txt);
			
			reset();
			startGame();
			
		}
		
		public function setGameOverCB(cb:Function):void
		{
			gameoverCB = cb;
		}
		
		public function reset():void
		{
			player.x = mainSprite.mouseX;
			player.y = mainSprite.mouseY;
			
			//reset the border blocks
			bordersBlocks[0].setParams(0, 0, gameWidth, wallWidth); // top bar
			bordersBlocks[1].setParams(0, 0, wallWidth, gameHeight); // left bar 
			bordersBlocks[2].setParams(0, gameWidth - wallWidth, gameWidth, wallWidth); //bottom bar
			bordersBlocks[3].setParams(gameWidth - wallWidth, 0, wallWidth, gameHeight); //right bar
			
			//reset the enemy blocks
			enemyBlocks[0].setEnemyParams(20, 50, 150, 50, 3, 4.5);
			enemyBlocks[1].setEnemyParams(400, 50, 50, 100, -3.9, 4.5);
			enemyBlocks[2].setEnemyParams(20, 400, 100, 80, 3, -4.5);
			enemyBlocks[3].setEnemyParams(400, 380, 80, 110, -3, -4.5);
			
			updateSpeedTimer.getUpdateSince();
		}
		
		public function update(e:TimerEvent):void
		{
			//trace("pos x:" + mainSprite.mouseX + " y:" + mainSprite.mouseY);
			//player.playerMove();
			
			var speedMultiplier:Number = (int(getPlayTime() / 6) * 0.5) + 1;
			if (speedMultiplier > 4)
				speedMultiplier = 4;
			var speed:Number = (updateSpeedTimer.getUpdateSince() / 33.333);
			
			//check collision with border block
			for (var bx:int = 0; bx < bordersBlocks.length; bx++  )
			{
				
				var bb:block = bordersBlocks[bx];
				if (bb.collisionPoint(mainSprite.mouseX, mainSprite.mouseY))
				{
					//trace("bb collision:" + bx);
				}
			}
			
			//update enemy positions
			for (var ex:int = 0; ex < enemyBlocks.length; ex++  )
			{
				
				var eb:enemy = enemyBlocks[ex];
				eb.update(gameWidth, gameHeight, speed * speedMultiplier);
			}
			
			score_txt.text = "TIME: " + getPlayTime();
			score_txt.setTextFormat(score_format);
			
			if (isGameOver())
			{
				//trace("GameOver");
				if (gameoverCB != null)
					gameoverCB(getPlayTime());
				stopGame();
			}
			
			
		}
		
		public function isGameOver():Boolean
		{
			if (player.alive == false)
			{
				return false;
			}
			
			var collision:int = 0;
			for (var bx:int = 0; bx < bordersBlocks.length; bx++  )
			{
				
				var bb:block = bordersBlocks[bx];
				if (bb.collisionBlock(player))
				{
					return true;
				}
			}
			
			//update enemy positions
			for (var ex:int = 0; ex < enemyBlocks.length; ex++  )
			{
				
				var eb:enemy = enemyBlocks[ex];
				if (eb.collisionBlock(player))
				{
					return true;
				}
			}
			
			return false;
			
		}
		
		public function draw():void
		{
			for (var bx:int = 0; bx < bordersBlocks.length; bx++  )
			{
				var bb:block = bordersBlocks[bx];
				bb.draw();
			}
			
			for (var ex:int = 0; ex < enemyBlocks.length; ex++  )
			{
				var eb:enemy = enemyBlocks[ex];
				eb.draw(0xff2200);
			}
			
			player.draw(0xfff00f);
		}
		
		public function getPlayTime():Number
		{
			endTime = new Date();
			var diffTime:Date = new Date();
			diffTime.setTime(endTime.valueOf() - startTime.valueOf());
			
			return(diffTime.valueOf() / 1000);
		}
		
		public function stopGame():Number
		{
			player.setAlive(false);
			updateTimer.stop();
			
			return getPlayTime();
		}
		
		public function startGame():void
		{
			//player.setAlive(true);
			updateTimer.start();
			startTime = new Date();
		}
		
		
	}
	
}
