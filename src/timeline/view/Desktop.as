package timeline.view
{
	import flash.geom.Matrix;

	import timeline.enums.EnumTweenType;

	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;

	import timeline.core.elements.Element;
	import timeline.core.Frame;
	import timeline.util.Util;
	import timeline.core.Layer;
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
			var frame : Frame;
			var nextKeyframe : Frame;
			for (var i : int = 0; i < this.mediator.timeline.layers.length; i++)
			{
				layer = this.mediator.timeline.layers[i];
				frame = layer.getFrame(this.mediator.timeline.currentFrame);

				var container : Sprite = new Sprite();
				canvas.addChild(container);

				if (frame && frame.hasElement())
				{
					nextKeyframe = layer.getFrame(frame.startFrame + frame.duration);
					for (var j : int = 0; j < frame.elements.length; j++)
					{
						var element : Element = frame.elements[j];

						var dp : DisplayObject = element.dp;
						if (frame.tweenType == EnumTweenType.MOTION || frame.tweenType == EnumTweenType.SHAPE)
						{
							if (nextKeyframe && nextKeyframe.hasElement() && Util.compareElements(frame.elements, nextKeyframe.elements))
							{
								var toMatrix : Matrix = nextKeyframe.elements[0].matrix;
								var mx : Matrix = Util.getTweenMatrix(element.matrix, toMatrix, frame.duration, this.mediator.timeline.currentFrame - frame.startFrame);
								dp.transform.matrix = mx;
							}
							else
							{
								dp.transform.matrix = element.matrix;
							}
						}
						else
						{
							dp.transform.matrix = element.matrix;
						}
						container.addChild(dp);
					}
				}
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
