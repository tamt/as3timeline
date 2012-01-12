package timeline.view
{
	import timeline.core.Layer;
	import timeline.util.Util;
	import timeline.view.interfaces.ITimelineView;

	import flash.display.Sprite;

	/**
	 * 渲染元素
	 * @author tamt
	 */
	public class Desktop extends Sprite implements ITimelineView
	{
		private var mediator : TimelineMediator;
		private var canvas : Sprite;

		public function Desktop(mediator : TimelineMediator)
		{
			this.mediator = mediator;
			this.mediator.registerView(this);

			// 創建ui
			this.buildUI();

			// 渲染
			this.render();
		}

		private function buildUI() : void
		{
			canvas = new Sprite();
			addChild(canvas);
		}

		private function render() : void
		{
			// 清除Canvas
			this.clearCanvas();

			// 繪製
			var layer : Layer;
			var currentFrameIndex : int = this.mediator.timeline.currentFrame;
			for (var i : int = 0; i < this.mediator.timeline.layers.length; i++)
			{
				layer = this.mediator.timeline.layers[i];
				canvas.addChild(layer.getPresentData(currentFrameIndex));
			}
		}

		private function clearCanvas() : void
		{
			this.canvas.graphics.clear();
			Util.removeAllChildren(this.canvas);
		}

		public function onCurrentFrame(currentFrame : int) : void
		{
			this.render();
		}

		public function onCurrentLayer(currentLayer : int) : void
		{
		}

		public function onAddNewLayer(layer : int) : void
		{
			this.render();
		}

		public function onDeleteLayer(layer : Layer) : void
		{
			this.render();
		}

		public function onSelectLayers(selectedLayers : Vector.<int>) : void
		{
		}

		public function onSelectedFrames(selectedFrames : Vector.<int>) : void
		{
		}

		public function onInsertSelectionFrames() : void
		{
		}

		public function onConvertSelectionKeyframes() : void
		{
			this.render();
		}

		public function onDeleteSelectionFrames() : void
		{
			this.render();
		}

		public function onAddElement(layerIndex : int, frameIndex : int, element : *) : void
		{
			this.render();
		}

		public function onCreateMotionTween() : void
		{
			this.render();
		}

		public function onRemoveMotionTween() : void
		{
			this.render();
		}
	}
}
