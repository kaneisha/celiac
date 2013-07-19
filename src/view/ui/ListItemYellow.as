package view.ui
{
	import interfaces.IListItem;
	
	import model.vo.FoodVO;
	
	public class ListItemYellow extends ListItemYellowBase implements IListItem
	{
		private var _vo:FoodVO;
		
		public function ListItemYellow()
		{
			super();
			mouseChildren = false;
			buttonMode = true;
		}
		
		public function set vo(value:FoodVO):void
		{
			_vo = value;
			updateUI();
		}
		
		public function get vo():FoodVO
		{
			return _vo;
		}
		
		private function updateUI():void
		{
			tfItem.text = _vo.item;
		}
	}
}