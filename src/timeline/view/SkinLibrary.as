package timeline.view
{
	import flash.events.Event;
	import flash.display.Loader;

	/**
	 * 皮肤库加载完成事件
	 */
	[Event(name="complete", type="flash.events.Event")]
	/**
	 * @author tamt
	 */
	public class SkinLibrary extends Loader
	{
		public function SkinLibrary()
		{
			super();

			this.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}

		private function onComplete(event : Event) : void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * 返回一个Skin实例
		 */
		public function getSkinInstance(skinName : String) : *
		{
			var skinClass : Class = this.contentLoaderInfo.applicationDomain.getDefinition(skinName) as Class;
			return new skinClass;
		}
	}
}
