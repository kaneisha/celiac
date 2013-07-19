package interfaces
{
	import model.vo.FoodVO;

	public interface IListItem
	{
		function set vo(value:FoodVO):void;
		function get vo():FoodVO;
	}
}