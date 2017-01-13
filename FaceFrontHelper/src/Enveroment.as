package  
{
	import com.junkbyte.console.Cc;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Matrix;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import utils.LoaderUtils;
	/**
	 * ...
	 * @author Denis 'Jack' Vinogradsky
	 */
	public class Enveroment 
	{
		//protected static var _instance:Enveroment=new Enveroment();
		protected static var _main:DisplayObject;
		protected static var _appPath:String;
		protected static var _isContained:Boolean;
		protected static var _isLocal:Boolean;
		//protected static var _social:Social;
		protected static var _totalSize:int=0;
		protected static var _loadedSize:int=0;
		protected static var _loadComplete:Boolean = false;
		public static var version:String = Math.random().toString();
		public static var proxy:String = "http://apps.pixlr.com/proxy/?url=";
		
		public static function get loaderContext():LoaderContext
		{
			if (_isLocal)
			{
				return new LoaderContext(false, ApplicationDomain.currentDomain);
			}
			else
			{
				return new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			}
		}
		public static var appName:String;
		public static function init(main:DisplayObject, securityDomain:Boolean = false,initAppName:String=null):void
		{
			_main = main;
			var s:String = main.loaderInfo.url;
			_isContained = main.loaderInfo.url != main.loaderInfo.loaderURL;
			var k:int = s.lastIndexOf("/");
			_appPath = s.substr(0, k + 1);
			var name:String = s.substr(k + 1);
			name = name.split('.')[0];
			//.fix
			k = _appPath.indexOf("[[IMPORT]]/");
			if (k > 0)
			{
				_appPath = "http://"+_appPath.substr(k+"[[IMPORT]]/".length);
			}
			
			_isLocal = s.indexOf("file") == 0 && !securityDomain;
			
			Cc.add("isLocal:" + _isLocal);
			
			if (initAppName && initAppName != "")
			{
				appName = initAppName;
			}
			else
			{
				appName = name;
			}
			
			
			/*if (!_isContained)
				_social = new DevSocial();
			else
				_social = new StellaSocial();*/
			
		}
		
		/*public function Enveroment() 
		{
			
		}*/
		public static function getUrl(url:String):String
		{
			if (!url)
				return url;
			if (url.toLocaleLowerCase().indexOf("http") == 0)
				return url;
			if (isLocal)
				return url;
			return _appPath + url;
		}
 

		private static function byteArrayToBitmapData(byteArray : ByteArray,f:Function):void
		{
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function getBitmapData(e:Event):void {
				
				var content:* = loader.content;
				var bitmapData:BitmapData = new BitmapData(content.width,content.height,true,0x00000000);
				var matrix:Matrix = new Matrix();
				bitmapData.draw(content, matrix,null,null,null,true);
				f(bitmapData);
		 
		}		
		);
			loader.loadBytes(byteArray);
		}
		static public function loadImage(url:String, loadedImage:Function):void 
		{
			//social.loadImage(url, loadedImage);
			if (!url)
			{
				Cc.add('Enveronment.loadImage: !url');
				loadedImage(null);
				return;
			}
			var arr:Array = url.split("//");
			LoaderUtils.getImage(proxy+arr[1], function(data:Object):void{loadedImage(new Bitmap(data as BitmapData))});
			return;
			
		}
		
		/*static public function getAvatar(url:String, loadImage:Function):void 
		{
			var arr:Array = url.split("//");
			//LoaderUtils.getImage(url, function(data:Object):void{loadImage(data)});
			LoaderUtils.getImage("http://devmuseum.stellagames.biz/proxy.php?url="+arr[1], function(data:Object):void{loadImage(data)});
			return;
			//social.getAvatar(url, loadImage); return;
			social.getAvatar(url, function(data:ByteArray):void
			{
				if (!data)
					loadImage(null);
				else
					byteArrayToBitmapData(data, loadImage);
			}); return;
			
			//LoaderUtils.getImage("http://devmuseum.stellagames.biz/proxy.php?url="+arr[1], function(data:Object):void{loadImage(data)});
			//LoaderUtils.getImage(url, function(data:Object):void{loadImage(data)});
			//LoaderUtils.getImage(url, function(data:Object):void{loadImage(data)});
		}*/
		protected static var _loaderList:Array = new Array();
		protected static var _loadedList:Object = new Object();
		static public function addLoader(loaderInfo:LoaderInfo):void 
		{
			//loaderInfo
			_loaderList.push(loaderInfo);
			_loadedList[loaderInfo] = loaderInfo.bytesLoaded;
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
		}
		
		/*static public function createSocial(stellaSocial:Class, devSocial:Class):void 
		{
			if (!_isContained)
				_social = new devSocial() as Social;
			else
				_social = new stellaSocial() as Social;
			
		}*/
		
		static private function progress(e:ProgressEvent):void 
		{
			
			//_loadedList[e.target.url] = e.bytesLoaded;
			_loadedList[e.target] = e.bytesLoaded;
			trace(e.target.loaderURL, e.bytesLoaded, e.bytesTotal);
		}
		
		public static function get appPath():String 
		{
			return _appPath;
		}
		
		public static function get isContained():Boolean 
		{
			return _isContained;
		}
		
		public static function get isLocal():Boolean 
		{
			return _isLocal;
		}
		
		public static function get main():DisplayObject 
		{
			return _main;
		}
		
		
		static public function get totalSize():int 
		{
			return _totalSize;
		}
		
		static public function set totalSize(value:int):void 
		{
			_totalSize = value;
		}
		
		static public function get loadedSize():Number 
		{
			var size:int = 0;
			for each(var li:LoaderInfo in _loaderList)
			{
				trace("!", li.url, li.bytesLoaded);
				size += li.bytesLoaded;
			}
			var lsize:String = "";
			
			/*for each(var i:int in _loadedList)
			{
				size += i;
				lsize += " " + i;
			}*/
			trace(lsize + " = " + size);
			return size;
		}
		
		
		static public function get loadComplete():Boolean 
		{
			return _loadComplete;
		}
		
		static public function get loadedProgress():Number
		{
			if (!_totalSize)
				return 0;
			var progress:Number = Number(loadedSize) / Number(_totalSize);
			trace(progress);
			if (!_loadComplete)
				progress = Math.min(.99, progress);
				
			Cc.ch("load",loadedSize.toString());				
			return progress;
		}
		static public function set loadComplete(value:Boolean):void 
		{
			_loadComplete = value;
		}
		static public function get fullScreen():Boolean
		{
			return (_main.stage.displayState != StageDisplayState.NORMAL);
		}
		
		static public function set fullScreen(value:Boolean):void
		{
			Cc.add('Enveronment.fullscreen: value=' + value);
			
			if (value)
				_main.stage.displayState = StageDisplayState.FULL_SCREEN;
			else
				_main.stage.displayState = StageDisplayState.NORMAL;
				
			Cc.add('Enveronment.fullscreen: _main.stage.displayState=' + _main.stage.displayState);
		}
		
		
		
	}

}