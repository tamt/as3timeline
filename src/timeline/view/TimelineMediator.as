package timeline.view
{
	import timeline.view.mediator.Mediator;
	import timeline.core.Layer;
	import timeline.core.Timeline;
	import timeline.enums.EnumLayerType;

	/**
	 * 时间轴Mediator
	 * @author tamt
	 */
	public class TimelineMediator extends Mediator
	{
		private var _timeline : Timeline;
		private var view : TimelineView;
		public var skin : SkinLibrary;

		public function TimelineMediator(timeline : Timeline)
		{
			this._timeline = timeline;
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
			view.onAddNewLayer(i);

			this.selectLayer(i);
		}

		/**
		 * 选择一个层
		 */
		public function selectLayer(index : int) : void
		{
			trace("[TimelineMediator.selectLayer(index)]:" + index);
			this._timeline.setSelectedLayers(index);
			this._timeline.currentLayer = index;
			view.onSelectLayers(this._timeline.getSelectedLayers());
		}

		/**
		 * 删除一个Layer
		 */
		public function deleteLayer(index : int) : void
		{
			var layer : Layer = this._timeline.deleteLayer(index);
			view.onDeleteLayer(layer);
		}

		/**
		 * 注册视图
		 */
		public function registerView(timelineView : TimelineView) : void
		{
			this.view = timelineView;

			// 初始化view, 如:显示currentLayer,currentFrame
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
			this.view.onSelectedFrames(this._timeline.getSelectedFrames());
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

			this.view.onInsertSelectionFrames();
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
			}

			this.view.onConvertSelectionKeyframes();
		}

		/**
		 * 设置当前帧
		 */
		public function setCurrentFrame(frameIndex : int) : void
		{
			if (frameIndex < 0) frameIndex = 0;
			if (frameIndex >= this._timeline.frameCount) frameIndex = this._timeline.frameCount - 1;
			this._timeline.currentFrame = frameIndex;
			this.view.onCurrentFrame(frameIndex);
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
			
			this.view.onDeleteSelectionFrames();
		}
	}
}
