package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import uk.co.soulwire.gui.SimpleGUI;
	/**
	 * ...
	 * @author 
	 */
	public class Window extends Sprite
	{
		
		protected var _backgroundColour:int = 0;
		protected var _corrector:PhotoCorrector;
		//[Embed(source = "Josh-Holloway-18.jpg")]
		//[Embed(source = "josh-holloway-18 (1).jpg")]
		[Embed(source="melamory.png")]
		protected var imgClass:Class;
		protected var _offsetX:Number = 0;
		protected var _offsetXMask:Number = 0;
		protected var _crotate:Number = 0;
		public function Window() 
		{

			addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			_corrector = new PhotoCorrector();
			_corrector.x = stage.stageWidth / 2;
			_corrector.y = stage.stageHeight / 2;
			addChild(_corrector);
			var bmp:Bitmap = new imgClass() as Bitmap;
			_corrector.setImage(bmp.bitmapData);
			var _gui:SimpleGUI = new SimpleGUI(this, "Example GUI", "C");
			_gui.addSlider("offsetX", -200, 200);
			_gui.addSlider("offsetXMask", -200, 200);
			_gui.addSlider("crotate", -100, 100);
				/*_gui.addGroup("General Settings");
				_gui.addColour("backgroundColour");
				_gui.addButton("Randomise Circle Position", {callback:positionCircle, width:160});
				_gui.addSaveButton();			*/
			_gui.show();		}
		private function positionCircle():void 
		{
			
		}
		
		public function get backgroundColour():int 
		{
			return _backgroundColour;
		}
		
		public function set backgroundColour(value:int):void 
		{
			_backgroundColour = value;
		}
		
		public function get offsetX():Number 
		{
			return _offsetX;
		}
		
		public function set offsetX(value:Number):void 
		{
			_offsetX = value;
			_corrector.setOffsetX(value);
		}
		
		public function get offsetXMask():Number 
		{
			return _offsetXMask;
		}
		
		public function set offsetXMask(value:Number):void 
		{
			_offsetXMask = value;
			_corrector.setOffsetXMask(value);
		}
		
		public function get crotate():Number 
		{
			return _crotate;
		}
		
		public function set crotate(value:Number):void 
		{
			_crotate = value;
			_corrector.setRotate(value/10);
		}
		
	}

}