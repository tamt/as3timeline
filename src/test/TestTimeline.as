package test
{
	import timeline.core.elements.Element;
	import timeline.core.Layer;
	import timeline.core.Timeline;
	import timeline.view.SkinLibrary;
	import timeline.view.TimelineMediator;
	import timeline.view.TimelineView;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author tamt
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="1000", height="480")]
	public class TestTimeline extends Sprite
	{
		private var timeline : Timeline;
		private var view : TimelineView;
		private var skinLib : SkinLibrary;
		private var mediator : TimelineMediator;

		public function TestTimeline()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;

			skinLib = new SkinLibrary();
			skinLib.load(new URLRequest('ui/timeline.swf'));
			skinLib.addEventListener(Event.COMPLETE, onSkinloaded);
		}

		private function onSkinloaded(event : Event) : void
		{
			timeline = new Timeline();
			timeline.addNewLayer();
			var layer : Layer = timeline.layers[0];
			layer.appendsToFrameIndex(10);
			layer.insertKeyframe(3);
			layer.insertKeyframe(8);
			layer.addElement(3, new Element());

			mediator = new TimelineMediator(timeline);
			mediator.skin = skinLib;
			view = new TimelineView(mediator);

			addChild(view.ui);
		}
	}
}
