package dotenv;

import dotenv.Parser;

class DotEnv {
	public static function load(?path:String = '.env') {
		return new Parser(path, function(e) {
			trace('file not found: $e');
		}).parse();
	}
}
