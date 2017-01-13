package utils  
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	/**
	 * ...
	 * @author Denis 'Jack' Vinogradsky
	 */
	public class HTTPLoader extends URLLoader
	{
		
        protected var HTTPRequest:URLRequest;

    protected var BOUND:String = "";

    protected var ENTER:String = "\r\n";

    protected var ADDB:String = "--";
        
    protected var index_file:int = 0;
        
    protected var PostData:ByteArray;
        
    public function HTTPLoader(script_name: String){
            BOUND = getBoundary();

        PostData = new ByteArray();

        PostData.endian = Endian.BIG_ENDIAN;
            
        HTTPRequest = new URLRequest(script_name);

        HTTPRequest.requestHeaders.push(new URLRequestHeader('Content-type','multipart/form-data; boundary=' + BOUND));

        HTTPRequest.method = URLRequestMethod.POST;
    }
        
    public function addVariable(param_name:String, param_value:String):void{
        PostData.writeUTFBytes(ADDB + BOUND);
   	    PostData.writeUTFBytes(ENTER);
        PostData.writeUTFBytes('Content-Disposition: form-data; name="'+param_name+'"');
        PostData.writeUTFBytes(ENTER);
        PostData.writeUTFBytes(ENTER);
        PostData.writeUTFBytes(param_value);
        PostData.writeUTFBytes(ENTER);
    }
        
    public function addFile(filename:String, filedata:ByteArray):void{
        PostData.writeUTFBytes(ADDB + BOUND);
        PostData.writeUTFBytes(ENTER);
        PostData.writeUTFBytes('Content-Disposition: form-data; name="Filedata' + index_file + '"; filename="' + filename + '"');
        PostData.writeUTFBytes(ENTER);
  	    PostData.writeUTFBytes('Content-Type: application/octet-stream');
        PostData.writeUTFBytes(ENTER);
            PostData.writeUTFBytes(ENTER);		
        PostData.writeBytes(filedata,0,filedata.length);
        PostData.writeUTFBytes(ENTER);
            PostData.writeUTFBytes(ENTER);
            
        index_file++;
    }
        
        
    public function send():void{
        PostData.writeUTFBytes(ADDB+BOUND+ADDB);
        HTTPRequest.data = PostData;
        this.load(HTTPRequest);
    }

    public function getBoundary():String {
        var _boundary:String = "";

        for (var i:int = 0; i < 0x20; i++) {

               _boundary += String.fromCharCode( int( 97 + Math.random() * 25 ) );

        }

        return _boundary;
    }		
	}

}