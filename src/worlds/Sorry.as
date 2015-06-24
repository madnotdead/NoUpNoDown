package worlds 
{
	import misc.Assets;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Sorry extends World 
	{
		private var pressText:Text = null;
		private var thanksText:Text = null;
		public function Sorry() 
		{
			super();
			FP.screen.color = 0x00CCCC;
			pressText = new Text("press any key to restart");
			pressText.scale = 2	;
			pressText.x = (FP.screen.width - pressText.scaledWidth) / 2;
			pressText.y = FP.screen.height - 75;
			
			thanksText = new Text("thanks for playing!");
			thanksText.scale = 2	;
			thanksText.x = (FP.screen.width - thanksText.scaledWidth) / 2;
			thanksText.y = 150;

		}
		
		override public function begin():void 
		{
			super.begin();
			//addGraphic(new Image(Assets.NO_MORE_LEVELS));
			addGraphic(pressText);
			addGraphic(thanksText);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.ANY))
				FP.world = new Intro;
		}
	}

}