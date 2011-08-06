/**
* ...
* @author Default
* @version 0.1
*/

package  {
	import flash.display.Sprite;

	public class block extends Sprite implements Iblock{
		
		public var blockWidth:Number = 100;
		public var blockHeight:Number = 100;
		
		public var xStep:Number = 0;
		public var yStep:Number = 0;
		
		public function block(ix:Number = 0 , iy:Number = 0, iwidth:Number = 50, iheight:Number = 50) 
		{
			this.x = ix;
			this.y = iy;
			this.blockHeight = iheight;
			this.blockWidth = iwidth;
		}
		
		public function setParams(ix:Number = 0 , iy:Number = 0, iwidth:Number = 50, iheight:Number = 50):void
		{
			this.x = ix;
			this.y = iy;
			this.blockHeight = iheight;
			this.blockWidth = iwidth;
		}
		
		public function update(playWidth:Number = 100, playHeight:Number = 100, speed:Number = 1):void
		{
			this.x += xStep * speed;
			this.y += yStep * speed;
			
			if ((this.x + this.blockWidth > playWidth) || (this.x < 0))
			{
				if(xStep > 0)
					this.x = playWidth - this.blockWidth;
				else
					this.x = 0;
					
				xStep = -xStep;
			}
			
			if ((this.y + this.blockHeight > playHeight) || (this.y < 0))
			{
				if(yStep > 0)
					this.y = playHeight - this.blockHeight;
				else
					this.y = 0;
					
				yStep = -yStep;
			}
		}
		
		public function draw(color:uint = 0x0000ff):void
		{
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, this.blockWidth, this.blockHeight);
			this.graphics.endFill();
		}
		
		public function collisionPoint(xP:Number, yP:Number):Boolean
		{
			if ((xP > this.x) && (xP < this.x + this.blockWidth))
			{
				if ((yP > this.y) && (yP < this.y + this.blockHeight))
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function collisionBlock(b:block):Boolean
		{
			if (collisionPoint(b.x, b.y))
			{
				return true;
			}
			if (collisionPoint(b.x+b.blockWidth,b.y+b.blockHeight))
			{
				return true;
			}
			
			return false;
		}
		
	}
	
}
