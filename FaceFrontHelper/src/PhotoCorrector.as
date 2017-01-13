package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public class PhotoCorrector extends Sprite
	{
		//protected var _left:Sprite;
		//protected var _right:Sprite;
		protected var _imageLeft:Image;
		protected var _imageRight:Image;
		protected var _w:Number;
		protected var _h:Number;
		//protected var _sprRightMask:Sprite;
		public function PhotoCorrector() 
		{
			graphics.beginFill(0);
			graphics.drawCircle(0, 0, 10);
			scaleX = scaleY = 1;
			_imageLeft = new Image(false);
			_imageRight = new Image(true);
			addChild(_imageLeft);
			addChild(_imageRight);
			//_sprRight.mask = _sprRightMask;
			//_imageRight.scaleX = -1;
			
		}
		//var _bitmapData:BitmapData;
		public function setImage(bitmapData:BitmapData):void
		{
			/*_bitmapData = bitmapData;
			if (_sprLeft.numChildren)
				_sprLeft.removeChildAt(0);
			if (_sprRight.numChildren)
				_sprRight.removeChildAt(0);
			_sprLeft.addChild(new Bitmap(bitmapData));
			var bmp:Bitmap = new Bitmap(bitmapData);
			bmp.scaleX = -1;
			bmp.x = bmp.width;
			_sprRight.addChild(bmp);*/
			_imageLeft.setBitmapData(bitmapData, false);
			_imageRight.setBitmapData(bitmapData,true);
			//_imageRight.bitmapData = bitmapData;
			
			_w = bitmapData.width;
			_h = bitmapData.height;
			
			//_sprRight.scrollRect = new Rectangle(_w / 2, 0, _w / 2, _h);
			//_sprRight.scaleX = -1;
			
			update();
		}
		protected var _offsetX:Number = 0;
		protected var _offsetXMask:Number = 0;
		public function setOffsetX(object:Number):void 
		{
			_offsetX = object;
			update();
		}
		public function setOffsetXMask(object:Number):void 
		{
			_offsetXMask = object;
			//_imageRight.updateMask(object);
			update();
		}
		protected var _rotate:Number = 0;
		public function setRotate(value:Number):void 
		{
			_rotate = value;
			update();
		}
		protected function update():void
		{
			_imageLeft.rotation = _rotate;
			_imageRight.rotation = -_rotate;
			_imageRight.x = -_offsetX;
			_imageRight.updateMask(_offsetXMask);
			return;
			var w:Number = _w;
			_sprRight.x =  _offsetX;// * w;
			_sprRightMask.x = _offsetX;// * w;
			//_sprRight.x = _offsetX * w;
			createMasks();
		}
		
		private function createMasks():void 
		{
			/*_sprRightMask.graphics.clear();
			var w:Number = _w;
			var h:Number = _h;
			_sprRightMask.graphics.beginFill(0);
			var px:Number = w / 2 + _offsetXMask;// * w / 2;
			_sprRightMask.graphics.drawRect(px, 0, w-px, h);*/
		}
		
		
	}

}