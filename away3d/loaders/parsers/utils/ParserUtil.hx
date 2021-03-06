package away3d.loaders.parsers.utils;

import openfl.utils.ByteArray;

class ParserUtil
{
	
	/**
	 * Returns a object as ByteArray, if possible.
	 * 
	 * @param data The object to return as ByteArray
	 * 
	 * @return The ByteArray or null
	 *
	 */
	public static function toByteArray(data:Dynamic):ByteArray
	{
		if (Std.is(data, Class))
			data = Type.createInstance(data, []);
		
		if (Std.is(data, ByteArrayData))
			return data;
		
		return null;
	}
	
	/**
	 * Returns a object as String, if possible.
	 * 
	 * @param data The object to return as String
	 * @param length The length of the returned String
	 * 
	 * @return The String or null
	 *
	 */
	public static function toString(data:Dynamic, length:UInt = 0):String
	{
		var ba:ByteArray;
		
		if (length == 0) length = 0xffffffff;
		
		if (Std.is(data, String)) {
			return cast(data, String).substr(0, length);
		}
		
		ba = toByteArray(data);
		if (ba != null) {
			try {
				ba.position = 0;
				return ba.readUTFBytes(Std.int(Math.min(ba.bytesAvailable, length)));
			} catch (e:Dynamic) {
				// e.g. invalid code point (> 0x10ffffu)
				#if (haxe < version("4.1.0-rc.1"))
				@:privateAccess haxe.CallStack.lastException = null;
				#end
			}
		}
		
		return null;
	}
}