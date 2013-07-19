package model
{
	import event.FoodEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import model.vo.FoodVO;
	
	public class FoodModel extends EventDispatcher
	{ 
		private var _list:Array;
		private var _vo:FoodVO;
//		public static const URL:String = "http://wddbs.com/~dfp/proxy.php?url=";
		public static const URL:String = "http://proxy.alanjames1987.com/?";
		
		public function FoodModel()
		{
			super();
			// For if you have to have a function to go back and reset the same data results
			_list = [];
		}
		
		public function search(search:String):void
		{
			trace(search);
			
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest (URL + "http://api.nutritionix.com/v1/search/" + search + "?appId=58e7409d&appKey=ea55d470d93bafbab65a666b2541abcf"));
			ul.addEventListener(Event.COMPLETE, onSearchComplete);
			
			trace(URL +"http://api.nutritionix.com/v1/search/" + search + "?appId=58e7409d&appKey=ea55d470d93bafbab65a666b2541abcf");
		}
		
		private function onSearchComplete(event:Event):void
		{
			_list = [];
			
			var jsonData:Object = JSON.parse(Event(event).currentTarget.data);
			
			for each(var result:Object in jsonData.hits)
			{
				var vo:FoodVO = new FoodVO();
				vo.item = result.fields.item_name;
				vo.id = result._id;
				
				_list.push(vo);
			}
			
			dispatchEvent(new FoodEvent(FoodEvent.ARRAY_COMPLETE));
			
		}
		
		public function item(id:String):void
		{
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest(URL + "http://api.nutritionix.com/v1/item/" + id + "?appId=58e7409d&appKey=ea55d470d93bafbab65a666b2541abcf"));
			ul.addEventListener(Event.COMPLETE, onItemComplete);
		}
		
		protected function onItemComplete(event:Event):void
		{
			_vo = new FoodVO();
			
			var jsonData:Object = JSON.parse(Event(event).currentTarget.data);
			
			if(jsonData.nf_ingredient_statement == null || jsonData.status_code == 400)
			{
				_vo.ingredients = "Not Available";
				_vo.name = jsonData.item_name;
			}
			else
			{
				_vo.ingredients = jsonData.nf_ingredient_statement;
				_vo.name = jsonData.item_name;
			}
			
			dispatchEvent(new FoodEvent(FoodEvent.VO_COMPLETE));
		}
		
		public function get list():Array
		{
			return _list;
		}

		public function get vo():FoodVO
		{
			return _vo;
		}

		public function set list(value:Array):void
		{
			_list = value;
		}


	}
}