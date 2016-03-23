package extendscript.system.io;
import system.io.SearchOption;
using Lambda;
using StringTools;
using haxe.io.Path;

class Directory {
	
	/**
	 * Returns the names of the subdirectories (including their paths) that match the specified search pattern in the specified directory, and optionally searches subdirectories.
	 * @param path The relative or absolute path to the directory to search. This string is not case-sensitive.
	 * @param searchPattern The search string to match against the names of subdirectories in path. This parameter can contain a combination of valid literal and wildcard characters (see Remarks), but doesn't support regular expressions.
	 * @param searchOption One of the enumeration values that specifies whether the search operation should include all subdirectories or only the current directory.
	 * @return An array of the full names (including paths) of the subdirectories that match the specified criteria, or an empty array if no directories are found.
	 */
	public static inline function getFiles(path:String, searchPattern:String, searchOption:SearchOption):Array<File> {
		return _getFiles(path.addTrailingSlash(), searchPattern, searchOption, []);
	}
	
	static function _getFiles(path:String, pattern:String, option:SearchOption, result:Array<File>):Array<File> {
		if(result == null) result = [];
		if(pattern == null) pattern = "*.*";
		path = path.normalize();
		var folder = new Folder(path);
		if(folder.exists) result = result.concat(folder.getFiles(pattern));
		if(option == SearchOption.AllDirectories) {
			for(it in new Folder(path.addTrailingSlash()).getFiles()) {
				if(new Folder(it.fullName).exists) {
					result = result.concat(_getFiles(it.fullName, pattern, option, []));
				}
			}
		}
		return result;
	}
}
