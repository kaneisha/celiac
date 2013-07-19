package view.ui
{
	public class ProgressBar extends LoadingBar
	{
		private var _percent:Number;
		
		public function ProgressBar()
		{
			super();
		}
		
		public function get percent():Number
		{
			return _percent;
		}
		
		public function set percent(value:Number):void
		{
			_percent = value;
			
			bar.scaleX = value;
			
			tfLoadText.text = uint(value*100) + "% Loaded";
		}
	}
}