/**
* ...
* @author Default
* @version 0.1
*/

package  {

	public class sinceTimer {
		
		public var time:Date;
		
		public function sinceTimer() {
				time = new Date();
		}
		
		public function getUpdateSince():Number
		{
			var currTime:Date  = new Date();
			var timeSince:Number = (currTime.valueOf() - time.valueOf());
			time = currTime;
			
			return timeSince;
		}
		
	}
	
}
