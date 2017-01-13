package utils 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Denis 'Jack' Vinogradsky
	 */
	public class WeakReference 
	{
		
		private var dictionary:Dictionary;
		
		public function WeakReference(p_object:Object) {
			dictionary = new Dictionary(true); // weakKeys = true
			dictionary[p_object] = null; // За счет возможности использования weakKeys, получаем weakReference
		}
		
		public function get object():Object 
		{
			// Пробегаемся по ключам словаря, позвращаем первый попавшийся
			for (var n:Object in dictionary) { return n; } 
			return null;
		}
		
	}

}