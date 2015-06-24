package entities 
{
	import misc.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Coin extends Entity 
	{
		private var pickUpSound:Sfx = null;
		
		public function Coin(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Image(Assets.COIN);
			mask = new Pixelmask(Assets.COIN);
			pickUpSound = new Sfx(Assets.PICK);
			type = "coin";
			super(x, y, graphic, mask);
		}
		
		
		override public function update():void 
		{
			super.update();
			
			var p:Player = collide("player", x, y) as Player;
			
			if (p)
			{
				pickUpSound.play() ;
				FP.world.remove(this);
			}
		}
	}
}