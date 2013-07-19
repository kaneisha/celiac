package view.assets
{
	import flash.display.Sprite;

	public class Track extends Sprite
	{
		public function Track()
		{
			this.graphics.beginFill(0xa9e1b1);
			this.graphics.drawRoundRect(0,-8,310,16,8);
			this.graphics.endFill();
		}
	}
}