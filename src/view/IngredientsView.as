package view
{
	import event.FoodEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import model.vo.FoodVO;

	public class IngredientsView extends IngredientViewBase
	{
		private var _vo:FoodVO;
		
		public function IngredientsView()
		{
			super();
			search_icon.buttonMode = true;
			search_icon.mouseChildren = false;
			//setupPagination();
		}
		
		public function set vo(value:FoodVO):void
		{
			_vo = value;
			updateTextFields();
		}
		
		private function updateTextFields():void
		{
			tfFoodName.text = _vo.name;
			tfIngredientList.text = _vo.ingredients;
		}
		
//		private function setupPagination():void
//		{
//			
//			var prevBtn:Sprite = Utilities.easyButton("<");
//			prevBtn.x = 10;
//			prevBtn.y = 125;
//			addChild(prevBtn);
//			prevBtn.addEventListener(MouseEvent.CLICK,prevPage);
//			
//		}

	}
}