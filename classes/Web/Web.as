/**
* ...
* @author Default
* @version 0.1
*/

package Web {

	import flash.net.navigateToURL;
    import flash.net.URLRequest;

    public class Web
    {
        public static function getURL(url:String, window:String = "_self"):void
        {
            var req:URLRequest = new URLRequest(url);
            trace("getURL", url);
            try
            {
                navigateToURL(req, window);
            }
            catch (e:Error)
            {
                trace("Navigate to URL failed", e.message);
            }
        }
    }
	
}
