package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author madnotdead
	 */
	public class PlayerOne extends Player 
	{		
		public function PlayerOne(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			
			image = new Image(Assets.PLAYER_ONE);
			graphic = image;
			mask = new Pixelmask(Assets.PLAYER_ONE);
			
			godImage = new Image(Assets.PLAYER_ONE_GOD);
			
			super(x, y, graphic,mask);
			
			setHitbox(image.width, image.height);
			
			leftTag = "L1";
			rightTag = "R1";
			jumpTag = "JUMP1";
			shootTag = "SHOOT1";
			// Define input keys.
			Input.define(rightTag, Key.D);
			Input.define(leftTag, Key.A);
			Input.define(jumpTag, Key.W);
			Input.define(shootTag, Key.F);
			
			name = Constants.PLAYER_ONE_TYPE;
			type = Constants.PLAYER_ONE_TYPE;
			
			FP.world.add(new entities.Health (30, 30, this));
			
			
			shootSound = new Sfx(Assets.PLAYER_ONE_SHOOT);
		}
	}

}