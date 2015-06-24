package  
{
	import entities.Coin;
	import entities.Exit;
	import entities.Player;
	import net.flashpunk.Entity;
	import worlds.Game;
	//import entities.Turret;
	import misc.Assets;
	import misc.Constants;3
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Level extends Entity 
	{
		private var xml:XML;
		private var tile_layer1:Tilemap;
		private var tile_layer2:Tilemap;
		private var grid:Grid;
		private var player:Player;
		private var exit:Exit;
		
		/** Camera following information. */
		public const FOLLOW_TRAIL:Number = 50;
		public const FOLLOW_RATE:Number = .9;
		
		public function Level(rawData:Class) 
		{
			super(0, 0);
			
			// to check for level collisions
			type = "level";
			
			// FlashPunk function makes get all that data super easy!
			this.xml = FP.getXML(rawData);
		}
		
		override public function added():void 
		{
			super.added();
			
			// load tiles
			// bottom tile layer
			
			tile_layer1 = new Tilemap(Assets.TILES, xml.@width, xml.@height, 16, 16);
			tile_layer1.loadFromString(xml.background);
			trace(xml.tile_layer1);
			
			// top tile layer (details)
			tile_layer2 = new Tilemap(Assets.TILES, xml.@width, xml.@height, 16, 16);
			tile_layer2.loadFromString(xml.tileset);
			
			// set graphic to graphiclist of tilesets, order matters!
			graphic = new Graphiclist(tile_layer1, tile_layer2);
			//graphic = tile_layer2;
			// load the collision grid
			grid = new Grid(xml.@width, xml.@height, 16, 16);
			grid.loadFromString(xml.grid, "");
			
			// set the grid to the mask of this entity
			mask = grid;
			
			// load entities
			var list:XMLList; // holds an xmllist
			var element:XML; // a specific xml element
			

			
			// for each player in the xml list
			list = xml.entities.coin;
			for each (element in list) {

				world.add(new Coin(element.@x,element.@y));
			}
			
			list = xml.entities.exit;
			//only one exit can exist
			for each( element in list)
			{
				exit = new Exit(element.@x, element.@y)
				world.add(exit);
			}
			
						// for each player in the xml list
			list = xml.entities.player;
			for each (element in list) {
				// add it
				world.add(new Player(element.@x, element.@y));
			}
		}
		
		override public function update():void 
		{
			super.update();
			//FP.camera.x = player.x - 200;// - FP.halfWidth) * FP.screen.scale;
			//FP.camera.y = player.y - 130;// - FP.halfHeight) * FP.screen.scale;
			
			trace("coins count in level: " + world.classCount(Coin));
			
			if (Game(world).classCount(Coin) == 0)
			{
				exit.appear();
			}
		}
		
		public function showExit():void
		{
			if(exit)
				exit.appear();
		}
	}

}