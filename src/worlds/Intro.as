package worlds 
{
	import misc.Assets;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Intro extends World 
	{
		private var pressText:Text = null;
		private var titleText:Text = null;
		
		private var titleColorTween:ColorTween = null;
		public function Intro() 
		{
			super();
			FP.screen.color = 0x66CCCC;
			//addGraphic(new Image(Assets.INTRO));
			
			pressText = new Text("press any key to start");
			pressText.scale = 2	;
			pressText.x = (FP.screen.width - pressText.scaledWidth) / 2;
			pressText.y = FP.screen.height - 75;

			titleText = new Text("no up, no down");
			titleText.scale = 4;
			titleText.x = (FP.screen.width - titleText.scaledWidth) / 2;
			titleText.y = 75;
			
			addGraphic(pressText);
			addGraphic(titleText);
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			titleColorTween = new ColorTween(null,LOOPING);
			titleColorTween.tween(3, 0xFFFF00, 0xFF33FF, 1, 0);
			addTween(titleColorTween, true);
		}
		
		override public function update():void 
		{
			super.update();
			pressText.color = titleColorTween.color;
			if (Input.pressed(Key.ANY))
				FP.world = new Instructions();
		}
	}

}