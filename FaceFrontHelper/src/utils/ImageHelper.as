package utils  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Denis 'Jack' Vinogradsky
	 */
	public class ImageHelper 
	{
		
		public function ImageHelper() 
		{
			
		}
		static public function getBitmap(displayObject:DisplayObject):Bitmap
		{
			if (displayObject is Bitmap)
				return new Bitmap(Bitmap(displayObject).bitmapData, "auto", true);
			var bmpData:BitmapData = new BitmapData(displayObject.width, displayObject.height, true, 0);
			bmpData.draw(displayObject);
			var bmp:Bitmap = new Bitmap(bmpData, "auto", true);
			return bmp;
		}
		
	}

}