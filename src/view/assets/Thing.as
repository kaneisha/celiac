package view.assets
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import model.vo.FoodVO;

	public class Thing extends Sprite
	{
		public function Thing(num:uint = 0)
		{
			graphics.beginFill(0xff0000);
			graphics.drawCircle(50,50,50);
			graphics.endFill();
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("Helvetica",30,0xffffff);
			tf.width = 50;
			tf.height = 50;
			tf.text = num.toString();
			addChild(tf);
			
			tf.x = 25;
			tf.y = 25;
		}
	}
}