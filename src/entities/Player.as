package entities
{
	import flash.geom.Point;
	import misc.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import worlds.Game;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Player extends Entity
	{
		public var jumpTag:String;
		public var leftTag:String;
		public var rightTag:String;
		public var shootTag:String;
		
		// Movement constants. 
		public const MAXX:Number = 300;
		public const MAXY:Number = 800;
		public var GRAV:Number = 1500;
		public var FLOAT:Number = 3000;
		public const ACCEL:Number = 1200;
		public const DRAG:Number = 800;
		public var JUMP:Number = -500;
		public const LEAP:Number = 1.5;
		public var onSolid:Boolean;
		public var spdX:Number = 0;
		public var spdY:Number = 0;
		public var image:Image = null;
		private const SPEED:int = 100;
		private var OnGround:Boolean = false;
		private var goRight:Boolean = true;
		
		
		private var jumpSound:Sfx = null;
		private var gravitySound:Sfx = null;
		
		private var initialPosition:Point = new Point();
		private var stayOverExit:Number = 0;
		
		public function Player(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null)
		{
			image = new Image(Assets.PLAYER_IMAGE);
			mask = new Pixelmask(Assets.PLAYER_IMAGE);
			graphic = image;
			 
			type = "player";
			initialPosition.x = x;
			initialPosition.y = y;
			super(x, y, graphic, mask);
		}
		
		
		override public function added():void 
		{
			super.added();
			jumpSound = new Sfx(Assets.JUMP);
			gravitySound = new Sfx(Assets.GRAVITY);
		}
		override public function update():void
		{
			super.update();
			
			checkFloor();
			gravity();
			acceleration();
			jumping();
			moveBy(spdX * FP.elapsed, spdY * FP.elapsed, "level");
			animation();
			handleItemCollision();
			checkPlayerAvailablePosition();
			
			if (Input.pressed(Key.G) && !onSolid)
			{
				GRAV = -GRAV;
				FLOAT = -FLOAT;
				JUMP = -JUMP;
				gravitySound.play();
			}
			
			//if (Input.pressed(Key.R))
			//{
				//restartPlayerPosition();
			//}
		}
		
		private function checkFloor():void
		{
			var offSetY:Number = JUMP < 0 ? 16 : -16;
			if (collide("level", x, y + offSetY))
				onSolid = true;
			else
				onSolid = false;
		}
		
		/** Applies gravity to the player. */
		private function gravity():void
		{
			if (onSolid)
				return;
			var g:Number = GRAV;
			if (spdY < 0 && !Input.check(Key.SPACE))
				g += FLOAT;
			spdY += g * FP.elapsed;
			
			if (GRAV > 0)
			{
				if (spdY > MAXY)
					spdY = MAXY;
			}
			else
			{
				if (spdY < -MAXY)
					spdY = -MAXY;
			}
			
		}
		
		/** Accelerates the player based on input. */
		private function acceleration():void
		{
			// evaluate input
			var accel:Number = 0;
			if (Input.check(Key.D))
			{
				accel += ACCEL;
				goRight = true;
			}
			if (Input.check(Key.A))
			{
				accel -= ACCEL;
				goRight = false;
			}
			
			// handle acceleration
			if (accel != 0)
			{
				if (accel > 0)
				{
					// accelerate right
					if (spdX < MAXX)
					{
						spdX += accel * FP.elapsed;
						if (spdX > MAXX)
							spdX = MAXX;
					}
					else
						accel = 0;
				}
				else
				{
					// accelerate left
					if (spdX > -MAXX)
					{
						spdX += accel * FP.elapsed;
						if (spdX < -MAXX)
							spdX = -MAXX;
					}
					else
						accel = 0;
				}
			}
			
			// handle decelleration
			if (accel == 0)
			{
				if (spdX > 0)
				{
					spdX -= DRAG * FP.elapsed;
					if (spdX < 0)
						spdX = 0;
				}
				else
				{
					spdX += DRAG * FP.elapsed;
					if (spdX > 0)
						spdX = 0;
				}
			}
		}
		
		/** Makes the player jump on input. */
		private function jumping():void
		{
			if (onSolid && Input.pressed(Key.SPACE))
			{
 				jumpSound.play();
				spdY = JUMP;
				onSolid = false;
				if (spdX < 0 && image.flipped)
					spdX *= LEAP;
				else if (spdX > 0 && !image.flipped)
					spdX *= LEAP;
			}
		}
		
			
		/** Handles animation. */
		private function animation():void
		{
			// control facing direction
			if (spdX != 0)
				image.flipped =spdX < 0;
		}
		
		private function handleItemCollision():void
		{
			var exit:Exit = collide("exit", x, y) as Exit;
			
			if (exit)
			{
				stayOverExit += FP.elapsed;
				
				if (stayOverExit > 1.5)
				{
					Game(world).loadNextLevel();
				}
			}
			//var item:Item = collide("item", x, y) as Item;
			//
			//if (item)
			//{
				//if (item.itemName == Constants.ITEM_HEALTH_TYPE)
					//addHealth(10);
				//
				//if (item.itemName == Constants.ITEM_GOD_TYPE)
				//{
					//isGod = true;
					//graphic = godImage;
				//}
				//
				//item.collected();
			//}
		}
		
		private function restartPlayerPosition():void
		{
			x = initialPosition.x;
			y = initialPosition.y;
		}
		/*
			public var GRAV:Number = 1500;
			public var FLOAT:Number = 3000;
			public const ACCEL:Number = 1200;
			public const DRAG:Number = 800;
			public var JUMP:Number = -500;
		*/
		private function checkPlayerAvailablePosition():void
		{
			if (x < 0 || x > FP.screen.width || y < 0 || y > FP.screen.height)
			{
				
				
				if (GRAV < 0)
				{
					GRAV = -GRAV;
					FLOAT = -FLOAT;
					JUMP = -JUMP;
				}
				
				restartPlayerPosition();
			}
		}
	}

}