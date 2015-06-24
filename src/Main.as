package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.Intro;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Main extends Engine 
	{
		
		public function Main() 
		{
			super(640, 480);
		}
		
		override public function init():void 
		{
			super.init();
			trace("Game initialized");
			
			FP.world = new Intro();
		}
		
	}
	
}