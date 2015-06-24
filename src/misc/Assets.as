package misc 
{
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Assets 
	{
		
		[Embed(source = "../../assets/image/player.png")]
		public static const PLAYER_IMAGE:Class;
		
		[Embed(source="../../assets/image/lofi_environment.png")]
		public static const TILES:Class;
			
		[Embed(source = "../../assets/image/coin.png")]
		public static const COIN:Class;
		
		[Embed(source = "../../assets/image/exit.png")]
		public static const EXIT:Class;
		[Embed(source="../../assets/audio/jump.mp3")]
		public static const JUMP:Class;
		[Embed(source="../../assets/audio/pickup.mp3")]
		public static const PICK:Class;
		[Embed(source="../../assets/audio/gravity.mp3")]
		public static const GRAVITY:Class;
	}

}