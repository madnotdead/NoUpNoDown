package entities 
{
	import misc.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Exit extends Entity 
	{
		
		public function Exit(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Image(Assets.EXIT);
			
			type = "exit";
			
			//collidable = false;
			//visible = false;
			
			graphic.visible = false;
			super(x, y, graphic, mask);
		}
		
		override public function update():void 
		{
			super.update();
			
			
		}
		
		public function appear():void
		{
			collidable = true;
			visible = true;
			graphic.visible = true;
			mask = new Pixelmask(Assets.EXIT);
		}
		
	}

}