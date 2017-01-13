package utils 
{
	//import com.junkbyte.console.Cc;
	//import dio.components.utils.WeakReference;
	//import dio.serialization.json.JSON;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author someone
	 */
	public class LoaderUtils 
	{
		
		public function LoaderUtils(param:Private) 
		{
		}
		public static function loadText(url:String,onLoaded:Function,onError:Function=null):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
			{
				trace("File '" + url + "' not found");

				if (onError != null)
					onError();
				else
					onLoaded(null);
			});
			loader.addEventListener(Event.COMPLETE, function completeHandler(event:Event):void
			{
				var loader:URLLoader = URLLoader(event.target);
				
				var s:String = loader.data;
				onLoaded(s);
			}
				);
			loader.load(new URLRequest(url));			
		}
		public static function loadJson(url:String,onLoaded:Function,onError:Function=null):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
			{
				//Cc.ch("load", "File '" + url + "' not found");						
				trace("File '" + url + "' not found");
				if (onError != null)
					onError();
				else
					onLoaded(null);
			});
			loader.addEventListener(Event.COMPLETE, function completeHandler(event:Event):void
			{
				var loader:URLLoader = URLLoader(event.target);
				var s:String = loader.data;
				//Cc.ch("load complete", loader.data);						
				var o:Object = JSON.parse(loader.data) ;
				onLoaded(o);
			}
				);
			loader.load(new URLRequest(url));			
		}
		public static function swfLoadInCurrentContext(url:String,onComplete:Function=null,onError:Function=null):void
		{
			var ldr:Loader = new Loader();
			var lc:LoaderContext = Enveroment.loaderContext;
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void
			{
				trace("File '" + url + "' not found");
				if (onError != null)
					onError();
				else if (onComplete != null) 
					onComplete();
			});
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void
			{
				if (onComplete != null) onComplete();
			});			
			ldr.load(new URLRequest(url), lc);
		}
		
		
		
		protected static var _images:Dictionary = new Dictionary();
		protected static var _loading:Dictionary = new Dictionary();
		protected static var _weak:Boolean = false;
		public static function getImage(url:String, loaded:Function):void
		{
			
			var bitmapData:BitmapData;
			if (_weak)
			{
				var weak:WeakReference=_images[url];
				bitmapData = weak?weak.object as BitmapData:null;
			}
			else
				bitmapData = _images[url];
			if (bitmapData)
			{
				loaded(bitmapData);
				return;
			}
			
			var loader:Loader = _loading[url];
			if (!loader)
			{
				loader = new Loader();
				
				loader.name = url;
				var request:URLRequest = new URLRequest( url);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImage);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void
				{
					trace("File '" + url + "' not found");
					
					_images[loader.name] = null;
					_loading[loader.name] = null;
					loader.dispatchEvent(new Event("ImageLoaded"));
				});
				loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(event:*):void { } );
				
				loader.load(request,Enveroment.loaderContext);
				_loading[url] = loader;
			}
			loader.addEventListener("ImageLoaded", function(e:Event):void { loaded(_weak?_images[url].object:_images[url]) } );
			
		}
		
		static private function displayImage(e:Event):void 
		{
			var li:LoaderInfo = e.target as LoaderInfo;
			
			var loader:Loader = li.loader;
			var data:BitmapData = (li.content as Bitmap).bitmapData;
			//new BitmapData(loader.width, loader.height, true, 0x00000000);
			///data.draw(loader);
			if(_weak)
				_images[loader.name] = new WeakReference(data);
			else
				_images[loader.name] = data;
			_loading[loader.name] = null;
			loader.dispatchEvent(new Event("ImageLoaded"));
			
		}
		
		
		
	}

}
class Private
{
	
}