package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Instructions extends World
	{
		private var pressText:Text = null;
		private var howToplayText:Text = null;
		private var movementText:Text = null;
		private var jumpText:Text = null;
		private var gravityText:Text = null;
		private var gravityText2:Text = null;
		private var titleColorTween:ColorTween = null;
		
		public function Instructions() 
		{
			FP.screen.color = 0x99CCFF;
		}
		
		override public function begin():void 
		{
			super.begin();
			
			howToplayText = new Text("HOW TO PLAY");
			howToplayText.scale = 4	;
			howToplayText.x = (FP.screen.width - howToplayText.scaledWidth) / 2;
			howToplayText.y = 50;
			
			movementText = new Text("'a' and 'd' to move");
			movementText.scale = 2	;
			movementText.x = (FP.screen.width - movementText.scaledWidth) / 2;
			movementText.y = 200;
			
			jumpText = new Text("space to jump");
			jumpText.scale = 2	;
			jumpText.x = (FP.screen.width - jumpText.scaledWidth) / 2;
			jumpText.y = 250;
			
			gravityText = new Text("'g' to change gravity");
			gravityText.scale = 2	;
			gravityText.x = (FP.screen.width - gravityText.scaledWidth) / 2;
			gravityText.y = 300;	
			
			gravityText2 = new Text("[works only if jumping]");
			gravityText2.scale = 2	;
			gravityText2.x = (FP.screen.width - gravityText.scaledWidth) / 2;
			gravityText2.y = 350;
			
			pressText = new Text("press space to play");
			pressText.scale = 2	;
			pressText.x = (FP.screen.width - pressText.scaledWidth) / 2;
			pressText.y = FP.screen.height - 75;
			
			titleColorTween = new ColorTween(null,LOOPING);
			titleColorTween.tween(2, 0xFFFFFF, 0x0066FF, 1, 0);
			
			addTween(titleColorTween, true);
			addGraphic(pressText);
			addGraphic(howToplayText);
			addGraphic(movementText);
			addGraphic(jumpText);
			addGraphic(gravityText);
			addGraphic(gravityText2);
			
		}
		
		
		override public function update():void 
		{
			super.update();
			
			pressText.color = titleColorTween.color;
			
			if (Input.pressed(Key.SPACE))
				FP.world = new Game();
		}
	}

}