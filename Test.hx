import sys.io.File;
import dotenv.DotEnv;

class Test {
	static function main() {
		DotEnv.load('.env');

		trace(Sys.getEnv('BY'));
		trace(Sys.getEnv('DISCORD'));
	}
}
