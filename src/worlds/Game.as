package worlds 
{
	import entities.*;
	import flash.system.Capabilities;
	import misc.Assets;
	import misc.Constants;
	import misc.LevelHolder;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Game extends World	{
	
		private var _currentLevel:int = 0;
		
		protected var levelList:Vector.<LevelMenuItem>;
		
		private var _level:Level = null;
		
		public function Game() 
		{
			//FP.screen.color = 0xCC99FF;
			levelList = new Vector.<LevelMenuItem>();
			
			// Iterate through our L class, grabbing levels until there are no more.
			var i:int = 1;
			
			while (LevelHolder[getLevelString(i)] != null)
			{
				//var itemAngle:Number = (i - 1) * 15;
				levelList.push(new LevelMenuItem(0,0,0, LevelHolder[getLevelString(i)]));
				i++;
			}
		}
		
		override public function begin():void 
		{
			super.begin();
			//add(new Level(_currentLevel));
			load(_currentLevel);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.ESCAPE))
				FP.world = new Sorry();
			
//			trace("coins in game: " + classCount(Coin));
//
			//if (Input.pressed(Key.C))
			//{
				//var coinsArray:Array = new Array()
				//getType("coin", coinsArray);
				//
				//for each (var coin:Coin in coinsArray) 
				//{
					//remove(coin);
				//}
			//}
		}
		
		public function loadNextLevel():void
		{
			_currentLevel++
			
			if (_currentLevel >= levelList.length)				
			{
				FP.world = new Sorry();
				return;
			}
			
			load(_currentLevel);
		}
		
		/**
		 * Generate the string name of a level based on a provided index.
		 * @param	index The index of the level to generate a string name.
		 * @return The string name of a level.
		 */
		protected function getLevelString(index:int):String
		{
			// This assumes all levels follow the naming structure "OD_xx".
			var s:String = "LEVEL_";
			if (index < 10) { s += "0"; }
			s += index.toString();
			return s;
		}
		
		/**
		 * Creates a GameWorld based on a provided level index.
		 * @param	index The index of the world to load.
		 */
		protected function load(index:int):void
		{

			//V.CurrentLevel = index;
			//FP.world = new GameWorld(levelList[index].data);
			_currentLevel = index;
			
			//delete all the entity 
			removeAll();
			_level = new Level(levelList[_currentLevel].data);
			//add a new level
			add(_level);
		}

	}

}