package timeline.view
{
	import timeline.core.Frame;
	import timeline.core.Layer;
	import timeline.core.Timeline;
	import timeline.core.elements.Element;
	import timeline.enums.EnumLayerType;
	import timeline.view.interfaces.ITimelineView;
	import timeline.view.mediator.Mediator;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 时间轴Mediator
	 * @author tamt
	 */
	public class TimelineMediator extends Mediator
	{
		private var _timeline : Timeline;
		public var skin : SkinLibrary;
		private var views : Vector.<ITimelineView>;

		public function TimelineMediator(timeline : Timeline)
		{
			this._timeline = timeline;
			this._timeline.addEventListener(Event.ENTER_FRAME, onTimelinePlaying);

			views = new Vector.<ITimelineView>();
		}

		private function callViews(funName : String, ...funParams) : void
		{
			var view : ITimelineView;
			for (var i : int = 0; i < this.views.length; i++)
			{
				view = this.views[i];
				if ((view as Object).hasOwnProperty(funName))
				{
					if (view[funName] is Function)
					{
						(view[funName] as Function).apply(null, funParams);
					}
				}
			}
		}

		/**
		 * 时间轴在播放
		 */
		private function onTimelinePlaying(event : Event) : void
		{
			this.callViews("onCurrentFrame", this.timeline.currentFrame);
		}

		/**
		 * 每个Layer的proert之值==value
		 */
		public function getIsEveryLayer(property : String, value : *) : Boolean
		{
			if (this._timeline.layers)
			{
				for each (var layer : Layer in this._timeline.layers)
				{
					if (layer[property] != value) return false;
				}
				return true;
			}
			return false;
		}

		/*
		 * 设置每个Layer的proert之值, 使之=value
		 */
		public function setEveryLayer(property : String, value : *) : void
		{
			if (this._timeline.layers)
			{
				for each (var layer : Layer in this._timeline.layers)
				{
					if (layer[property] != value) layer[property] = value;
				}
			}
		}

		/**
		 * 添加一个layer
		 */
		public function addNewLayer(name : String = null, layerType : String = EnumLayerType.NORMAL, bAddAbove : Boolean = false) : void
		{
			var i : int = this._timeline.addNewLayer(name, layerType, bAddAbove);
			this.callViews("onAddNewLayer", i);

			this.selectLayer(i);
		}

		/**
		 * 在当前层当前帧上添加一个元素
		 */
		public function addElement(layerIndex : int, frameIndex : int, element : * = null) : void
		{
			var layer : Layer = this._timeline.layers[layerIndex];
			var frame : Frame = layer.frames[layer.frames[frameIndex].startFrame];
			var preKeyframe : Frame = layer.getPreKeyframe(frameIndex);
			if (!frame.hasElement() && preKeyframe && preKeyframe.elements)
			{
				var eles : Vector.<Element> = preKeyframe.cloneElements();
				// TEST:
				for each (var ele : Element in eles)
				{
					ele.scaleX = ele.scaleY = 2;
				}
				// ------
				layer.setFrameProperty("elements", eles, frame.startFrame, frame.startFrame + frame.duration);
			}
			else
			{
				// TEST
				var logo : Sprite = this.skin.getSkinInstance("logo_ui");
				element = new Element(logo);
				layer.addElement(frameIndex, element);
				// ----
			}

			this.callViews('onAddElement', layerIndex, frameIndex, element);
		}

		/**
		 * 在当前层当前帧上删除一个元素
		 */
		public function removeElement(layerIndex : int, frameIndex : int, element : *= null) : void
		{
			var layer : Layer = this._timeline.layers[layerIndex];
			var frame : Frame = layer.frames[frameIndex];
		}

		/**
		 * 选择一个层
		 */
		public function selectLayer(index : int) : void
		{
			this._timeline.setSelectedLayers(index);
			this._timeline.currentLayer = index;

			this.callViews('onSelectLayers', this._timeline.getSelectedLayers());
		}

		/**
		 * 删除一个Layer
		 */
		public function deleteLayer(index : int) : void
		{
			var layer : Layer = this._timeline.deleteLayer(index);
			this.callViews('onDeleteLayer', layer);
		}

		/**
		 * 注册视图
		 */
		public function registerView(timelineView : ITimelineView) : void
		{
			if (this.views.indexOf(timelineView) < 0)
			{
				this.views.push(timelineView);
			}

			// TODO:初始化view, 如:显示currentLayer,currentFrame
		}

		/**
		 * 时间轴
		 */
		public function get timeline() : Timeline
		{
			return _timeline;
		}

		/**
		 * 选择帧
		 */
		public function setSelectedFrames(startFrameIndex : int = -1, endFrameIndex : int = -1, bReplaceCurrentSelection : Boolean = true, selectionList : Vector.<int> = null) : void
		{
			this._timeline.setSelectedFrames(startFrameIndex, endFrameIndex, bReplaceCurrentSelection, selectionList);
			this.callViews('onSelectedFrames', this._timeline.getSelectedFrames());
		}

		/**
		 * 
		 */
		public function insertFrames(numFrames : int = -1, bAllLayers : Boolean = true, frameNumIndex : int = -1) : void
		{
			this._timeline.insertFrames(numFrames, bAllLayers, frameNumIndex);
		}

		/**
		 * 所选择范围帧插入帧
		 */
		public function insertSelectionFrames() : void
		{
			var selection : Vector.<int> = this._timeline.getSelectedFrames();
			for (var i : int = 0; i < selection.length; i += 3)
			{
				var layer : Layer = this._timeline.layers[selection[i]];
				var start : int = selection[i + 1];
				var end : int = selection[i + 2];
				if (end == start && end < layer.frameCount)
				{
					layer.insertFrames(1, start);
				}
				else
				{
					layer.insertFrames(end - start, start);
				}
			}

			this.callViews('onInsertSelectionFrames');
		}

		public function convertSelectionKeyFrames() : void
		{
			var selection : Vector.<int> = this._timeline.getSelectedFrames();
			for (var i : int = 0; i < selection.length; i += 3)
			{
				var layer : Layer = this._timeline.layers[selection[i]];
				var start : int = selection[i + 1];
				var end : int = selection[i + 2];
				layer.convertToKeyframes(start, end);
				// TEST
				if (layer.getFrame(start).hasElement())
				{
					var ele : Element = layer.getFrame(start).elements[0];
					ele.scaleX = ele.scaleY = Math.random() * 4 + .5;
				}
				// ----
			}

			this.callViews('onConvertSelectionKeyframes');
		}

		public function convertSelectionBlankKeyframes() : void
		{
			var selection : Vector.<int> = this._timeline.getSelectedFrames();
			for (var i : int = 0; i < selection.length; i += 3)
			{
				var layer : Layer = this._timeline.layers[selection[i]];
				var start : int = selection[i + 1];
				var end : int = selection[i + 2];
				layer.convertToBlankKeyframes(start, end);
			}

			this.callViews('onConvertSelectionKeyframes');
		}

		/**
		 * 设置当前帧
		 */
		public function setCurrentFrame(frameIndex : int) : void
		{
			if (frameIndex < 0) frameIndex = 0;
			if (frameIndex >= this._timeline.frameCount) frameIndex = this._timeline.frameCount - 1;
			this._timeline.currentFrame = frameIndex;

			this.callViews('onCurrentFrame', frameIndex);
		}

		/**
		 * 删除选择帧
		 */
		public function deleteSelectionFrames() : void
		{
			var selection : Vector.<int> = this._timeline.getSelectedFrames();
			for (var i : int = 0; i < selection.length; i += 3)
			{
				var layer : Layer = this._timeline.layers[selection[i]];
				var start : int = selection[i + 1];
				var end : int = selection[i + 2];
				layer.removeFrames(start, end);
			}

			this.callViews('onDeleteSelectionFrames');
		}

		public function startPlay() : void
		{
			this.timeline.startPlayback();
		}

		public function stopPlay() : void
		{
			this.timeline.stopPlayback();
		}

		public function nextFrame() : void
		{
			this.timeline.currentFrame++;
			this.callViews('onCurrentFrame', this.timeline.currentFrame);
		}

		public function prevFrame() : void
		{
			this.timeline.currentFrame--;
			this.callViews('onCurrentFrame', this.timeline.currentFrame);
		}

		public function firstFrame() : void
		{
			this.timeline.currentFrame = 0;
			this.callViews('onCurrentFrame', this.timeline.currentFrame);
		}

		public function lastFrame() : void
		{
			this.timeline.currentFrame = this.timeline.frameCount - 1;
			this.callViews('onCurrentFrame', this.timeline.currentFrame);
		}

		/**
		 * 当前帧位置创建Tween动画
		 */
		public function createMotionTween() : void
		{
			var startFrameIndex : int = this.timeline.currentFrame;
			var endFrameIndex : int = this.timeline.currentFrame + 1;
			this.timeline.createMotionTween(startFrameIndex, endFrameIndex);

			this.callViews('onCreateMotionTween');
		}

		/**
		 * 删除当前帧位置的Tween动画
		 */
		public function removeMotionTween() : void
		{
			var startFrameIndex : int = this.timeline.currentFrame;
			var endFrameIndex : int = this.timeline.currentFrame + 1;
			this.timeline.removeMotionTween(startFrameIndex, endFrameIndex);

			this.callViews('onRemoveMotionTween');
		}
	}
}
