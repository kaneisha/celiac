package event
{
	import flash.events.Event;
	
	public class FoodEvent extends Event
	{
		public static const ARRAY_COMPLETE:String = "food_array_complete";
		public static const VO_COMPLETE:String = "food_vo_complete";
		
		public static const ITEM_CLICK:String = "food_item_click";
		public static const BACK_CLICK:String = "food_back_click";
		
		public var id:String;
		
		public function FoodEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}