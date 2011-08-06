/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequestMethod;
	import flash.utils.Timer;
	
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.Font;
	
	import Math;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import flash.text.TextField;
	import flash.text.StyleSheet;
	import flash.events.TimerEvent;
	
	import JSONLib.JSON;
	
	public class HighscoreLoader extends Sprite {
		private var external_onSuccess:Function;
		private var external_onFailure:Function;
		private var loader:URLLoader;
		private var urlReq:URLRequest;
		
		public var scoreTxtSprite:Sprite;
		public var scoreMask:Sprite;
		public var scoreTxtField:TextField;
		public var nameTxtField:TextField;
		public var dateTxtField:TextField;
		public var host:String = "http://workshop.blabberize.com/evade/view/";
		
		public var scrollTimer:Timer;
		
		public function HighscoreLoader()
		{
			scoreTxtSprite = new Sprite();
			scoreTxtField = createLabel();
			nameTxtField = createLabel();
			dateTxtField = createLabel();
			
			scoreTxtSprite.addChild(scoreTxtField);
			scoreTxtSprite.addChild(nameTxtField);
			scoreTxtSprite.addChild(dateTxtField);
			this.addChild(scoreTxtSprite);
			
			scoreMask = new Sprite;
			scoreMask.graphics.beginFill(0);
			scoreMask.graphics.drawRect(0, 0, 500, 275);
			scoreMask.graphics.endFill();
			this.addChild(scoreMask);
			this.mask = scoreMask;
			
			var myCSS:StyleSheet = new StyleSheet();
			myCSS.setStyle("highscore", {fontSize:'40',color:'#000000'});
			myCSS.setStyle("name", { fontSize:'20', color:'#8888ff' , align:'right'} );
			myCSS.setStyle("score", { fontSize:'20', color:'#8888ff' } );
			myCSS.setStyle("date", { fontSize:'20', color:'#8888ff' } );
			
			scoreTxtField.styleSheet = myCSS;
			nameTxtField.styleSheet = myCSS;
			dateTxtField.styleSheet = myCSS;
			
			drawScore();
			
			scrollTimer = new Timer(30);
			scrollTimer.start();
			scrollTimer.addEventListener(TimerEvent.TIMER, scroll);
		}
		
		public var scrollSpeed:Number = -2;
		public function scroll(e:TimerEvent):void
		{
			scoreTxtSprite.y += scrollSpeed;
			if ((scoreTxtSprite.y > scoreMask.y + 100) || (-scoreTxtSprite.height > scoreTxtSprite.y))
			{
				scrollSpeed = -scrollSpeed;
			}
		}
		
		public function drawScore():void
		{
			var request:URLRequest = new URLRequest(host + "highscore.php?" + Math.random());
			var loader:URLLoader = new URLLoader();
			//loader.dataFormat = URLLoaderDataFormat.TEXT;
			request.method = URLRequestMethod.POST;
			loader.addEventListener(Event.COMPLETE, HandleComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}
		
		private function createLabel():TextField {
			var label_txt:TextField = new TextField();
			label_txt.autoSize = TextFieldAutoSize.LEFT;
			label_txt.selectable = false;
			var format:TextFormat = label_txt.getTextFormat();
			Font.registerFont(gameLogic.Arial);
			format.font = "Arial";
			format.color = 0xFFFFFF;
			format.align = TextFormatAlign.LEFT;
			format.size = 40;
			format.bold = true;
			label_txt.setTextFormat(format);
			return label_txt;
		}
		
		private function HandleComplete(event:Event):void 
		{
			var loader:URLLoader = URLLoader(event.target);
            trace("Highscore completeHandler: " + loader.data);
			var data:Object = JSON.decode(loader.data);
			
			nameTxtField.text = "";
			scoreTxtField.text = "";
			dateTxtField.text = "";
			
			trace("LENGTH!:" + data.length);
			for (var s:int = 0; s < data.length; s++ )
			{
				nameTxtField.htmlText += '<name>';
				nameTxtField.htmlText += data[s].name + '<BR>';
				nameTxtField.htmlText += '</name>';
			}
			
			for (s = 0; s < data.length; s++ )
			{
				scoreTxtField.htmlText += '<score>';
				scoreTxtField.htmlText += data[s].score + '<BR>';
				scoreTxtField.htmlText += '</score>';
			}
			
			for (s = 0; s < data.length; s++ )
			{
				dateTxtField.htmlText += '<date>';
				dateTxtField.htmlText += data[s].date + '<BR>';
				dateTxtField.htmlText += '</date>';
			}
			
			scoreTxtField.x = 200;
			dateTxtField.x = 280;
		}
		
		private function onIOError(event:IOErrorEvent):void 
		{
			trace("Error IO.");
		}
		
	}
	
}
