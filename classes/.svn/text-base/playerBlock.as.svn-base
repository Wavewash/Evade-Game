/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	public class playerBlock extends block {
		
		public var alive:Boolean = true;
		
		public function playerBlock(ix:Number = 0 , iy:Number = 0, iwidth:Number = 50, iheight:Number = 50) 
		{
			this.x = ix;
			this.y = iy;
			this.blockHeight = iheight;
			this.blockWidth = iwidth;
			
			//this.addEventListener(MouseEvent.MOUSE_MOVE, playerMove);
		}
		
		public function playerMove(e:MouseEvent):void
		{
			if ((alive))
			{
				this.x = mouseX - (this.blockWidth / 2);
				this.y = mouseY - (this.blockHeight / 2);
			}
		}
		
		public function setAlive(s:Boolean):void
		{
			alive = s;
			if (alive)
			{
				this.startDrag(false);
				Mouse.hide();
				//this.visible = true;
			}
			else
			{
				Mouse.show();
				this.stopDrag();
				//this.visible = false;
			}
		}
		
	}
	
}
