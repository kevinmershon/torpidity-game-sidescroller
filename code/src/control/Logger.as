package control {
	import flash.external.ExternalInterface;

	public class Logger {
		
		/**
		 * Log some message to the external logger		 */
		public static function log(message:String):Boolean {
			try {
				ExternalInterface.call("logMessage", message);
			} catch (e:Error) {
				return false;
			}
			return true;
		}
	}

}