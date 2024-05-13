package dotenv;

import haxe.Exception;
import sys.io.File;

using StringTools;

class Parser {
	public var file:String;

	var content:String;

	public function new(file:String, ?onError:(Exception) -> Void) {
		this.file = file;
		try {
			content = File.getContent(file);
		} catch (e:Exception) {
			if (onError != null)
				onError(e);
		}
	}

	public function parse() {
		for (line in content.split('\n')) {
			if (line.charAt(0) == '#' || line.charAt(0) == '') {
				continue;
			}
			var i = -1, pass = '';
			while (++i <= line.length) {
				var char = line.charAt(i);
				if (char == '=') {
					Sys.putEnv(pass, getValue(line, i));
					break;
				}
				pass += char;
			}
		}
	}

	private function getValue(line:String, pos:Int):String {
		var daValue = '', i = pos, inString = false;
		while (++i <= line.length) {
			var char = line.charAt(i);
			if (easystring(line, i)) {
				inString = !inString;
				continue;
			}
			if (line.charAt(i) == '#' && !inString) {
				break;
			}
			daValue += char;
		}
		return daValue.trim();
	}

	private function easystring(str, pos) {
		return str.charAt(pos) == '"' || str.charAt(pos) == "'";
	}
}
