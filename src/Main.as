package
{
	import test.TestLayer;

	import flash.display.Sprite;

	public class Main extends Sprite
	{
		public function Main()
		{
			var test : TestLayer = new TestLayer();
			addChild(test);
		}
	}
}
