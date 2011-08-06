/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.events.MouseEvent;

	public class evadeButton extends SimpleButton {
		private var label_str:String;
		
		public function evadeButton(labelText:String = "Submit"){
			label_str = labelText;
			useHandCursor = true;
			upState = createUpState();
			overState = createOverState();
			downState = createDownState();
			hitTestState = createUpState();
			
			this.addEventListener(MouseEvent.CLICK, NoFuncSet, false, 0, true);
		}
		
		public function setFunction(onClick:Function):void
		{
			this.removeEventListener(MouseEvent.CLICK, NoFuncSet);
			this.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		public function NoFuncSet(e:MouseEvent):void
		{
			trace("No Function Set x:" + mouseX + " y:" + mouseY);
		}
			
		private function createUpState():Sprite {
			var state:Sprite = new Sprite();
			var upShape:Shape = new Shape();
			upShape.graphics.lineStyle(2, 0x000000);
			upShape.graphics.beginFill(0x550000);
			upShape.graphics.drawRect(0,0, 100,50);
			var label_txt:TextField = createLabel();
			positionLabel(label_txt, upShape);
			state.addChild(upShape);
			state.addChild(label_txt);
			return state;
		}
		private function createOverState():Sprite {
			var overShape:Shape = new Shape();
			overShape.graphics.lineStyle(2, 0x000000);
			overShape.graphics.beginFill(0xaa3333);
			overShape.graphics.drawRect(0,0, 100,50);
			var label_txt:TextField = createLabel();
			positionLabel(label_txt, overShape);
			var state:Sprite = new Sprite();
			state.addChild(overShape);
			state.addChild(label_txt);
			return state;
		}
		private function createDownState():Sprite {
			var downShape:Shape = new Shape();
			downShape.graphics.lineStyle(2, 0x000000);
			downShape.graphics.beginFill(0x000000);
			downShape.graphics.drawRect(0,0, 100,50);
			var label_txt:TextField = createLabel();
			positionLabel(label_txt, downShape);
			var state:Sprite = new Sprite();
			state.addChild(downShape);
			state.addChild(label_txt);
			return state;
		}
		
		private function createLabel():TextField {
			var label_txt:TextField = new TextField();
			label_txt.autoSize = TextFieldAutoSize.CENTER;
			label_txt.selectable = false;
			label_txt.text = label_str;
			var format:TextFormat = label_txt.getTextFormat();
			format.font = "_sans";
			format.color = 0xFFFFFF;
			format.align = TextFormatAlign.CENTER;
			format.size = 40;
			format.bold = true;
			label_txt.setTextFormat(format);
			return label_txt;
		}
		private function positionLabel(label:TextField, state:DisplayObject):void {
			label.x = state.width/2 - label.width/2;
			label.y = state.height/2 - label.height/2;
		}
	}
	
}
