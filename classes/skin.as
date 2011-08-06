/**
* ...
* @author Default
* @version 0.1
*/

package  {

	public class skin {
		
		[Embed(source = "../library/title.svg")] 			public var UI_Title:Class;
		[Embed(source = "../library/highscore.svg")] 		public var UI_Highscore:Class;
		[Embed(source = "../library/gameover.svg")] 		public var UI_Gameover:Class;
		[Embed(source = "../library/central.svg")] 			public var UI_Central:Class;
		
		
		
		static public var instance:skin;
		
		public function skin()
		{
			if(instance != null)
			{	trace("class Skin is a singleton - use Skin::getInstance instead of new Skin()");
				return;
			}
		}
		
		public static function getInstance():skin
		{
			if(instance == null)
				instance = new skin();
			return instance;
		}
		
	}
	
}