package utils  
{
	//import dio.components.utils.LoaderUtils;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Denis 'Jack' Vinogradsky
	 */
	public class BitmapLoader extends Sprite
	{
		protected var shape:Shape;
		protected var _bitmap:Bitmap;
		public var url:String;
		protected var w:int;
		protected var h:int;
		public function BitmapLoader(url:String,w:int,h:int,color:int=0) 
		{
			this.w = w;
			this.h = h;
			cacheAsBitmap = true;
			shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(0, 0, w, h);
			addChild(shape);
			this.url = url;
			LoaderUtils.getImage(url, function(data:BitmapData):void { bitmap = new Bitmap(data, "auto", true) } );
		}
		
		public function get bitmap():Bitmap 
		{
			return _bitmap;
		}
		
		public function set bitmap(value:Bitmap):void 
		{
			if (_bitmap)
				removeChild(_bitmap);
			_bitmap = value;
			if (value)
			{
				_bitmap.width = w;
				_bitmap.height = h;
				addChild(_bitmap);
				if (shape)
				{
					removeChild(shape);
					shape = null;
				}
				
			}
		}
		
	}

}