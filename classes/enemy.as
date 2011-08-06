/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import flash.display.Sprite;

	public class enemy extends block{
		
		public function enemy(ix:Number = 0 , iy:Number = 0, iwidth:Number = 50, iheight:Number = 50, ixStep:Number = 10, iyStep:Number = 10 ) 
		{
			this.x = ix;
			this.y = iy;
			this.blockHeight = iheight;
			this.blockWidth = iwidth;
			this.xStep = ixStep;
			this.yStep = iyStep;
		}
		
		public function setEnemyParams(ix:Number = 0 , iy:Number = 0, iwidth:Number = 50, iheight:Number = 50, ixStep:Number = 10, iyStep:Number = 10 ):void
		{
			this.x = ix;
			this.y = iy;
			this.blockHeight = iheight;
			this.blockWidth = iwidth;
			this.xStep = ixStep;
			this.yStep = iyStep;
		}
		
	}
	
}
