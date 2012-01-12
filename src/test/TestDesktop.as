package test
{
	import timeline.view.Desktop;
	import timeline.core.Layer;
	import timeline.core.Timeline;
	import timeline.core.elements.Element;
	import timeline.view.SkinLibrary;
	import timeline.view.TimelineMediator;
	import timeline.view.TimelineView;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;

	/**
	 * @author tamt
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="1000", height="480")]
	public class TestDesktop extends Sprite
	{
		private var timeline : Timeline;
		private var view : TimelineView;
		private var skinLib : SkinLibrary;
		private var mediator : TimelineMediator;
		private var desktop : Desktop;

		public function TestDesktop()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;

			skinLib = new SkinLibrary();
			skinLib.load(new URLRequest('ui/timeline.swf'));
			skinLib.addEventListener(Event.COMPLETE, onSkinloaded);

			//
			var tf : TextField = new TextField();
			tf.mouseEnabled = tf.selectable = tf.mouseWheelEnabled = false;
			tf.autoSize = 'left';
			tf.text = 'F5:插入帧\nF6:关键帧\nF7:空白关键帧\nInsert:在帧放置元素';
			tf.y = stage.stageHeight - tf.height - 10;
			tf.x = 10;
			addChild(tf);
		}

		private function onSkinloaded(event : Event) : void
		{
			timeline = new Timeline();

			this.addTimelineLayer();
			this.addTimelineLayer();
			this.addTimelineLayer();
			this.addTimelineLayer();
			this.addTimelineLayer();
			this.addTimelineLayer();
			this.addTimelineLayer();

			mediator = new TimelineMediator(timeline);
			mediator.skin = skinLib;

			desktop = new Desktop(mediator);
			desktop.y = 276;
			addChild(desktop);

			view = new TimelineView(mediator);
			addChild(view.ui);
		}

		private function addTimelineLayer() : void
		{
			timeline.addNewLayer();
			timeline.currentLayer = timeline.layerCount - 1;
			var layer : Layer = timeline.layers[timeline.layerCount - 1];
			layer.appendsToFrameIndex(10 + Math.random() * 3 * 10);
			layer.insertKeyframe(layer.frameCount * Math.random());
			layer.insertKeyframe(layer.frameCount * Math.random());

			var dp : Sprite = new Sprite();
			dp.graphics.lineStyle(1, Math.random() * 0xffffff, 1);
			dp.graphics.beginFill(Math.random() * 0xffffff);
			dp.graphics.drawCircle(0, 0, Math.random() * 20 + 5);
			dp.graphics.endFill();

			var ele : Element = new Element(dp);
			ele.x = this.stage.stageWidth / 2 + 100 - Math.random() * 200;
			ele.y = (this.stage.stageHeight - 276) / 2;

			layer.addElement(layer.frameCount * Math.random(), ele);
//			layer.addElement(0, ele);
		}
	}
}
