package view.assets
{
	import flash.display.Sprite;
	
	public class Handle extends Sprite
	{
		public function Handle()
		{
			super();
			this.graphics.beginFill(0xf9fcca);
			this.graphics.drawRoundRect(0,-8,16,16,5);
			this.graphics.endFill();
		}
	}
}