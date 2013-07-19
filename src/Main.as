package
{
	import com.whipple.reusable.ui.LayoutBox;
	
	import event.FoodEvent;
	
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import model.FoodModel;
	import model.vo.FoodVO;
	
	import view.HomeView;
	import view.IngredientsView;
	import view.SearchView;
	
	[SWF(width="308", height="398", backgroundColor="0x666666")]
	
	public class Main extends Sprite
	{
		private var _foodModel:FoodModel;
		
		private var _searchView:SearchView;
		private var _ingredientsView:IngredientsView;
		private var _homeView:HomeView;
		private var _loadingWheel:wheel = new wheel();
		
		public function Main()
		{
			// Live URL
			// kaneisha.github.io/dfp/beta/index.html
			_foodModel = new FoodModel();
			_foodModel.addEventListener(FoodEvent.ARRAY_COMPLETE, onSearchComplete);
			_foodModel.addEventListener(FoodEvent.VO_COMPLETE, onItemComplete);
			
			_homeView = new HomeView();
			addChild(_homeView);
			_homeView.homebtn.addEventListener(MouseEvent.CLICK, onSearchClick);
			
			_searchView = new SearchView();
			//addChild(_searchView);
			_searchView.addEventListener(FoodEvent.ITEM_CLICK, onItemClick);
			_searchView.go.addEventListener(MouseEvent.CLICK, onSearchSeachClick);
			
			_ingredientsView = new IngredientsView();
			_ingredientsView.search_icon.addEventListener(MouseEvent.CLICK, onSearchIndredientsClick);
			_ingredientsView.escapeHatch.addEventListener(MouseEvent.CLICK, onPreviouspage);
			
			setupCopyright();
		}
		
		protected function onPreviouspage(event:MouseEvent):void
		{
			addChild(_ingredientsView);
			removeChild(_ingredientsView);
			
			addChild(_searchView);
			
			// For if you have to have a function to go back and reset the same data results
			//_searchView.list = _foodModel.list;
		}
		
		protected function onSearchSeachClick(event:MouseEvent):void
		{
			addChild(_ingredientsView)
			removeChild(_ingredientsView);
			
			addChild(_searchView);
			
			_foodModel.search(_searchView.tfsearch.text);
			
			_searchView.tfsearch.text = "";
			_ingredientsView.tfReSearch.text = "";
		}
		
		protected function onSearchIndredientsClick(event:MouseEvent):void
		{
			addChild(_ingredientsView)
			removeChild(_ingredientsView);
			
			addChild(_searchView);
			
			_foodModel.search(_ingredientsView.tfReSearch.text);
			
			_searchView.tfsearch.text = "";
			_ingredientsView.tfReSearch.text = "";
		}
		
		protected function onSearchClick(event:MouseEvent):void
		{
			_foodModel.search(_homeView.tfHomeSearch.text);
			removeChild(_homeView);
			addChild(_searchView);
			addChild(_loadingWheel);
			_loadingWheel.x = 30;
			_loadingWheel.y = 170;
		}
		
		protected function onSearchComplete(event:Event):void
		{
			_searchView.list = _foodModel.list;
			addChild(_loadingWheel);
			removeChild(_loadingWheel);
		}
		
		private function onItemClick(event:FoodEvent):void
		{
			//addChild(_searchView);
			_foodModel.item(FoodEvent(event).id);
			
		}
		
		protected function onItemComplete(event:Event):void
		{
			// bit of a hack to remove the search view
			addChild(_searchView);
			removeChild(_searchView);
			
			_ingredientsView.vo = _foodModel.vo;
			addChild(_ingredientsView);
			
		}
		
		
		private function setupCopyright():void
		{
			var cxtMenu:ContextMenu = new ContextMenu();
			cxtMenu.hideBuiltInItems();
			
			var myItem:ContextMenuItem = new ContextMenuItem("Copyright ©2013 Kaneisha Whipple", true);
			myItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onCopyClick);
			cxtMenu.customItems.push(myItem);
			
			this.contextMenu = cxtMenu;
			
		}
		
		protected function onCopyClick(event:Event):void
		{
			var uRequest:URLRequest = new URLRequest("http://kaneisha.github.io/dfp/index.html");
			navigateToURL(uRequest, "_blank");
			
		}
		
				
	}
}