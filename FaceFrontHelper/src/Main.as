package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import uk.co.soulwire.gui.SimpleGUI;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public var backgroundColour:int = 0;
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			/*var _gui:SimpleGUI = new SimpleGUI(this, "Example GUI", "C");
			
				_gui.addGroup("General Settings");
				_gui.addColour("backgroundColour");
				//_gui.addButton("Randomise Circle Position", {callback:positionCircle, width:160});
				//_gui.addSaveButton();			
			_gui.show();*/
			addChild(new Window());
		}
		
		
	}
	
}