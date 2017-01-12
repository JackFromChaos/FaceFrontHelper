package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class Image extends Sprite
	{
		protected var _bitmap:Bitmap;
		protected var _innerMask:Sprite;
		public function Image(masked:Boolean) 
		{
			if (masked)
			{
				_innerMask = new Sprite();
				_innerMask.cacheAsBitmap = true;
				addChild(_innerMask);
			}
		}
		protected var _bitmapData:BitmapData;
		
		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}
		
		public function setBitmapData(value:BitmapData,invert:Boolean):void 
		{
			if (_bitmap)
				removeChild(_bitmap);
			_bitmapData = value;
			_bitmap = new Bitmap(value);
			_bitmap.x = -_bitmap.width / 2;
			_bitmap.y = -_bitmap.height / 2;
			addChild(_bitmap);
			if (_innerMask)
			{
				_bitmap.mask = _innerMask;
				updateMask(0);
			}
			if (invert)
			{
				_bitmap.scaleX = -1;
				_bitmap.x = -_bitmap.width / 2+_bitmap.width ;
				
			}
		}
		
		public function updateMask(offset:Number):void 
		{
			trace(offset);
			if (!_innerMask)
				return;
			_innerMask.graphics.clear();
			_innerMask.graphics.beginFill(0);
			var w:Number = Math.abs(_bitmap.width);
			var h:Number = Math.abs(_bitmap.height);
			//var ox:Number = w / 2 + offset;
			/*_innerMask.graphics.drawRect(ox, -h/2, w - ox, h);*/
			//_innerMask.graphics.drawRect(0-offset,-h/2,-w,h);
			_innerMask.graphics.drawRect(0+offset,-h/2,w,h);
		}
		
	}

}