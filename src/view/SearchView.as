package view
{
	import com.whipple.reusable.ui.LayoutBox;
	import com.whipple.reusable.ui.SliderManager;
	
	import event.FoodEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import interfaces.IListItem;
	
	import model.vo.FoodVO;
	
	import view.assets.Handle;
	import view.assets.Track;
	import view.ui.ListItemGreen;
	import view.ui.ListItemYellow;
	
	public class SearchView extends SearchViewBase
	{
		private var _list:Array;
		
		private var _layout:LayoutBox;
		private var _scrollHolder:Sprite;
		private var _masker:Sprite;
		
		
		public function SearchView()
		{
			super();
			go.buttonMode = true;
			go.mouseChildren = true;
			
			
			_layout = new LayoutBox(-2, false);
			addChild(_layout);
			_layout.x = 155;
			_layout.y = 215;
			
			
		}
		
		public function set list(value:Array):void
		{
			_list = value;
			createList();
			//			setupScrolling();
		}
		
		private function createList():void
		{
			
			while(_layout.numChildren > 0)
			{
				_layout.removeChildAt(0);
			}
			
			var i:int = 0
			
			for each (var vo:FoodVO in _list) 
			{
				var item:IListItem;
				
				if(i % 2 != 0)
				{
					item = new ListItemYellow();
				}
				else{
					item = new ListItemGreen();
				}
				
				MovieClip(item).addEventListener(MouseEvent.CLICK, onItemClick);
				item.vo = vo;
				_layout.addChild(MovieClip(item));
				
				i++;
			}
			
			setupScrolling();
			//stage.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheel);
			
			
		}
		
		private function onItemClick(event:MouseEvent):void
		{
			var clickedItem:IListItem = IListItem(MouseEvent(event).currentTarget);
			
			var foodEvent:FoodEvent = new FoodEvent(FoodEvent.ITEM_CLICK)
			foodEvent.id = clickedItem.vo.id;
			dispatchEvent(foodEvent);
		}
		
		private function setupScrolling():void
		{
			//			// Need a sprite to hold all of the Things
			_scrollHolder = new Sprite();
			//_scrollHolder.y = 275;
			addChild(_scrollHolder);
			//			
			//			// We will mask the holder to only display what we want.
			_masker = new Sprite();
			_masker.graphics.beginFill(0xff0000);
			_masker.graphics.drawRect(0,0,307,207);
			_masker.graphics.endFill();
			_masker.y = 175;
			addChild(_masker);
					
			_scrollHolder.mask = _masker;
			
			// Adding the things to the holder
	
			_scrollHolder.addChild(_layout);
			//				
			trace(_scrollHolder);
			//}
			
			// Creating and setting up our slider & manager
			var track:Track = new Track();
			var handle:Handle = new Handle();
			addChild(track);
			track.addChild(handle);
			
			addChild(track);
			var sMan:SliderManager = new SliderManager();
			sMan.setUpAssets(track,handle);
			sMan.addEventListener(Event.CHANGE,onScroll);
		}
		
		private function onScroll(event:Event):void
		{
			// Grab the percent from the slider manager.
			var pct:Number = SliderManager(Event(event).currentTarget).pct;
			
			// Math : percent * range of motion
			_scrollHolder.y = - pct * (_scrollHolder.height - _masker.height);
			
		}
		
//		private function handleMouseWheel(event:MouseEvent):void 
//		{
//			if ((MouseEvent(event).delta > 0 && _layout.y < 270) || (MouseEvent(event).delta < 0 && _layout.y > 0)) 
//			{
//				
//				_layout.y = _layout.y + (MouseEvent(event).delta * 4);
//				trace(MouseEvent(event).delta);
//			}
//			
//		}
		
		
	}
}