package timeline.view
{
	import timeline.view.event.TimelineViewEvent;
	import timeline.core.Layer;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;

	/**
	 * 时间轴视图
	 * @author tamt
	 */
	public class TimelineView extends BaseView
	{
		// ui
		private var _ui : MovieClip;
		private var layerContainer : Sprite;
		private var visible_btn : SimpleButton;
		private var lock_btn : SimpleButton;
		private var outline_btn : SimpleButton;
		private var newLayer_btn : SimpleButton;
		private var deleteLayer_btn : SimpleButton;
		private var lastFrame_btn : SimpleButton;
		private var nextFrame_btn : SimpleButton;
		private var play_btn : SimpleButton;
		private var preFrame_btn : SimpleButton;
		private var firstFrame_btn : SimpleButton;
		//
		private var layerViews : Vector.<LayerView>;
		//
		private var mediator : TimelineMediator;
		// "当前帧"的游标
		private var currentFrameMark : DisplayObject;
		// 所选帧区域
		private var selection : Rectangle;
		private var selectionGraph : Sprite;

		public function TimelineView(mediator : TimelineMediator, ui : * = null)
		{
			super();
			this.mediator = mediator;
			this.mediator.registerView(this);

			// ui初始化
			if (!ui) ui = this.mediator.skin.getSkinInstance("timeline_ui");
			this._ui = ui;
			buildUI();

			// 渲染
			this.render();
		}

		private function buildUI() : void
		{
			this.visible_btn = this._ui['visible_btn'];
			this.lock_btn = this._ui['lock_btn'];
			this.outline_btn = this._ui['outline_btn'];
			this.newLayer_btn = this._ui['newLayer_btn'];
			this.deleteLayer_btn = this._ui['deleteLayer_btn'];
			this.layerContainer = this._ui['layerContainer'];
			this.currentFrameMark = this._ui['currentFrameMark'];
			this.lastFrame_btn = this._ui['lastFrame_btn'];
			this.nextFrame_btn = this._ui['nextFrame_btn'];
			this.play_btn = this._ui['play_btn'];
			this.preFrame_btn = this._ui['preFrame_btn'];
			this.firstFrame_btn = this._ui['firstFrame_btn'];
			//
			this.selectionGraph = this.mediator.skin.getSkinInstance("selection_ui");
			// this.selectionGraph = new Sprite();
			this.selectionGraph.mouseEnabled = this.selectionGraph.mouseChildren = false;
			//
			this.visible_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.lock_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.outline_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.newLayer_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.deleteLayer_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.play_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.preFrame_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.firstFrame_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.nextFrame_btn.addEventListener(MouseEvent.CLICK, buttonHandler);
			this.lastFrame_btn.addEventListener(MouseEvent.CLICK, buttonHandler);

			//
			if (this.mediator.timeline)
			{
				if (this.mediator.timeline.layers)
				{
					for (var i : int = 0; i < this.mediator.timeline.layers.length; i++)
					{
						this.onAddNewLayer(i);
					}
				}

				this.onCurrentLayer(this.mediator.timeline.currentLayer);
				this.onCurrentFrame(this.mediator.timeline.currentFrame);
			}

			if (ui.stage)
			{
				buildKeyboardInteraction();
			}
			else
			{
				ui.addEventListener(Event.ADDED_TO_STAGE, buildKeyboardInteraction);
			}
		}

		private function buildKeyboardInteraction(evt : Event = null) : void
		{
			// 键盘交互
			ui.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
		}

		private function keyHandler(event : KeyboardEvent) : void
		{
			switch(event.keyCode)
			{
				case Keyboard.F5:
					this.mediator.insertSelectionFrames();
					break;
				case Keyboard.F6:
					this.mediator.convertSelectionKeyFrames();
					break;
				case Keyboard.DELETE:
					this.mediator.deleteSelectionFrames();
				default:
			}
		}

		public function onCurrentFrame(currentFrame : int) : void
		{
			this.currentFrameMark.x = currentFrame * 8 + 206;
		}

		public function onCurrentLayer(currentLayer : int) : void
		{
		}

		private function buttonHandler(event : MouseEvent) : void
		{
			switch(event.currentTarget)
			{
				case this.visible_btn:
					if (this.mediator.getIsEveryLayer("visible", true))
					{
						this.mediator.setEveryLayer("visible", false);
					}
					else
					{
						this.mediator.setEveryLayer("visible", true);
					}
					break;
				case this.lock_btn:
					if (this.mediator.getIsEveryLayer("locked", true))
					{
						this.mediator.setEveryLayer("locked", false);
					}
					else
					{
						this.mediator.setEveryLayer("locked", true);
					}
					break;
				case this.outline_btn:
					if (this.mediator.getIsEveryLayer("outline", true))
					{
						this.mediator.setEveryLayer("outline", false);
					}
					else
					{
						this.mediator.setEveryLayer("outline", true);
					}
					break;
				case this.newLayer_btn:
					this.mediator.addNewLayer();
					break;
				case this.deleteLayer_btn:
					this.mediator.deleteLayer(this.mediator.timeline.currentLayer);
					// 设置选中层
					if (this.mediator.timeline.currentLayer >= this.mediator.timeline.layerCount)
					{
						this.mediator.selectLayer(this.mediator.timeline.layerCount - 1);
					}
					else if (this.mediator.timeline.currentLayer > 0 )
					{
						this.mediator.selectLayer(this.mediator.timeline.currentLayer - 1);
					}
					else
					{
						this.mediator.selectLayer(this.mediator.timeline.currentLayer);
					}
					break;
				case this.play_btn:
					this.mediator.startPlay();
					break;
				case this.nextFrame_btn:
					this.mediator.nextFrame();
					break;
				case this.preFrame_btn:
					this.mediator.prevFrame();
					break;
				case this.lastFrame_btn:
					this.mediator.lastFrame();
					break;
				case this.firstFrame_btn:
					this.mediator.firstFrame();
					break;
				default:
			}
		}

		private function render() : void
		{
		}

		/**
		 * 当添加了新层时
		 */
		public function onAddNewLayer(layer : int) : void
		{
			if (layerViews == null)
			{
				layerViews = new Vector.<LayerView>();
			}

			var layerUI : MovieClip = this.mediator.skin.getSkinInstance("layer_ui");
			var view : LayerView = new LayerView(this.mediator.timeline.layers[layer], layerUI, mediator);
			layerViews.push(view);
			layerContainer.addChild(layerUI);
			view.addEventListener(TimelineViewEvent.CLICK_LAYER, layerMouseHandler);
			view.addEventListener(TimelineViewEvent.MOUSE_DOWN_FRAME, layerMouseHandler);
			view.addEventListener(TimelineViewEvent.MOUSE_UP_FRAME, layerMouseHandler);
			view.addEventListener(TimelineViewEvent.MOUSE_MOVE_FRAME, layerMouseHandler);

			this.relayoutLayers();
		}

		private function layerMouseHandler(event : TimelineViewEvent) : void
		{
			var view : LayerView = event.currentTarget as LayerView;
			if (view)
			{
				switch(event.type)
				{
					case TimelineViewEvent.CLICK_LAYER:
						this.mediator.stopPlay();
						this.mediator.selectLayer(this.mediator.timeline.layers.indexOf(view.layer));
						break;
					case TimelineViewEvent.MOUSE_DOWN_FRAME:
						if (!this.selection) this.selection = new Rectangle();
						this.selection.x = view.frameIndexAtMouse;
						if (this.selection.x < 0) this.selection.x = 0;
						this.selection.y = this.mediator.timeline.layers.indexOf(view.layer);
						if (this.selection.y < 0) this.selection.y = 0;
						if (this.selection.y >= this.mediator.timeline.layerCount) this.selection.y = this.mediator.timeline.layerCount;
						//
						this.mediator.stopPlay();
						break;
					case TimelineViewEvent.MOUSE_MOVE_FRAME:
						if (this.selection)
						{
							this.selection.right = view.frameIndexAtMouse;
							if (this.selection.right < 0) this.selection.right = 0;
							this.selection.bottom = this.mediator.timeline.layers.indexOf(view.layer);
							if (this.selection.bottom < 0) this.selection.bottom = 0;
							if (this.selection.bottom >= this.mediator.timeline.layerCount) this.selection.bottom = this.mediator.timeline.layerCount;
							showSelection();
						}
						break;
					case TimelineViewEvent.MOUSE_UP_FRAME:
						setSelection();
						break;
					default:
				}
			}
		}

		private function setSelection() : void
		{
			if (!this.selection) return;
			var rect : Rectangle = new Rectangle();
			// rect = rect.intersection(this.selection);
			// trace("[TimelineView.setSelection()]:" + rect);
			rect.top = Math.min(this.selection.top, this.selection.bottom);
			rect.left = Math.min(this.selection.left, this.selection.right);
			rect.bottom = Math.max(this.selection.bottom, this.selection.top);
			rect.right = Math.max(this.selection.right, this.selection.left);

			if (rect.top < 0) rect.top = 0;
			if (rect.top >= this.mediator.timeline.layerCount) rect.top = this.mediator.timeline.layerCount - 1;
			if (rect.left < 0) rect.left = 0;
			if (rect.bottom < 0) rect.bottom = 0;
			if (rect.right < 0) rect.right = 0;
			if (rect.bottom >= this.mediator.timeline.layerCount) rect.bottom = this.mediator.timeline.layerCount - 1;

			var selectionList : Vector.<int> = new Vector.<int>();
			for (var r : int = rect.top; r <= rect.bottom; r++)
			{
				selectionList.push(r, rect.left, rect.right);
			}

			this.mediator.setSelectedFrames(-1, -1, true, selectionList);

			// 设置选中的图层
			this.mediator.selectLayer(selectionList[0]);

			// 设置选中的帧
			this.mediator.setCurrentFrame(selectionList[1]);

			//
			this.selection = null;
			this.showSelection();
		}

		/**
		 * 在视图上显示当前的选择帧区域
		 */
		private function showSelection() : void
		{
			if (layerViews.length && this.selection)
			{
				var h : Number = layerViews[0].frameH;
				var w : Number = layerViews[0].frameW;

				var rect : Rectangle = new Rectangle();
				rect.top = Math.min(this.selection.top, this.selection.bottom);
				rect.left = Math.min(this.selection.left, this.selection.right);
				rect.bottom = Math.max(this.selection.bottom, this.selection.top);
				rect.right = Math.max(this.selection.right, this.selection.left);

				if (rect.top < 0) rect.top = 0;
				if (rect.left < 0) rect.left = 0;
				if (rect.bottom < 0) rect.bottom = 0;
				if (rect.right < 0) rect.right = 0;

				// this.selectionGraph.graphics.clear();
				// this.selectionGraph.graphics.lineStyle(1, 0x0066FF);
				// this.selectionGraph.graphics.beginFill(0x0066FF, .4);
				// this.selectionGraph.graphics.drawRect(rect.x * w + 206, (this.mediator.timeline.layerCount - 1 - rect.y - rect.height) * h, (rect.width + 1) * w, (rect.height + 1) * h);

				this.selectionGraph.x = rect.x * w + 206;
				this.selectionGraph.y = (this.mediator.timeline.layerCount - 1 - rect.y - rect.height) * h;
				this.selectionGraph.width = (rect.width + 1) * w;
				this.selectionGraph.height = (rect.height + 1) * h;

				this.layerContainer.addChild(this.selectionGraph);
			}
			else
			{
				if (this.selectionGraph.parent) this.selectionGraph.parent.removeChild(this.selectionGraph);
			}
		}

		private function relayoutLayers() : void
		{
			if (layerViews.length)
			{
				var layerUI : MovieClip = this.mediator.skin.getSkinInstance("layer_ui");
				var h : Number = layerViews[0].frameH;
				for (var i : int = 0; i < this.layerViews.length; i++)
				{
					layerUI = this.layerViews[i].ui;
					layerUI.x = 0;
					var t : int = this.mediator.timeline.layers.indexOf(layerViews[i].layer);
					layerUI.y = h * (this.mediator.timeline.layers.length - 1 - t);
				}
			}
		}

		/**
		 * 当删除层时
		 */
		public function onDeleteLayer(layer : Layer) : void
		{
			var view : LayerView = this.getLayerView(layer);
			if (view)
			{
				layerContainer.removeChild(view.ui);
				var i : int = this.layerViews.indexOf(view);
				if (i >= 0) layerViews.splice(i, 1);
				view.removeEventListener(TimelineViewEvent.MOUSE_DOWN_FRAME, layerMouseHandler);
				view.removeEventListener(TimelineViewEvent.MOUSE_UP_FRAME, layerMouseHandler);
				view.removeEventListener(TimelineViewEvent.MOUSE_MOVE_FRAME, layerMouseHandler);

				this.relayoutLayers();
			}
		}

		public function get ui() : MovieClip
		{
			return _ui;
		}

		/**
		 * 由一个Layer获取对应的LayerView
		 */
		public function getLayerView(layer : Layer) : LayerView
		{
			for each (var layerView : LayerView in this.layerViews)
			{
				if (layerView.layer == layer) return layerView;
			}
			return null;
		}

		/**
		 * 由一个ui获取对应的LayerView
		 */
		public function getLayerViewByUI(ui : MovieClip) : LayerView
		{
			for each (var layerView : LayerView in this.layerViews)
			{
				if (layerView.ui == ui) return layerView;
			}
			return null;
		}

		/**
		 * 选择Layers
		 */
		public function onSelectLayers(selectedLayers : Vector.<int>) : void
		{
			for (var i : int = 0; i < this.layerViews.length; i++)
			{
				var layerView : LayerView = layerViews[i];
				layerView.onSelected(selectedLayers.indexOf(this.mediator.timeline.layers.indexOf(layerView.layer)) >= 0);
			}
		}

		/**
		 * 选择帧时
		 */
		public function onSelectedFrames(selectedFrames : Vector.<int>) : void
		{
			for each (var layerView : LayerView in this.layerViews)
			{
				layerView.clearSelectedFrames();
			}

			for (var i : int = 0; i < selectedFrames.length; i += 3)
			{
				var layer : Layer = this.mediator.timeline.layers[selectedFrames[i]];
				var view : LayerView = this.getLayerView(layer);
				view.onSelectedFrames(selectedFrames[i + 1], selectedFrames[i + 2]);
			}
		}

		/**
		 * 当把所选帧插入普通帧时
		 */
		public function onInsertSelectionFrames() : void
		{
			var selection : Vector.<int> = this.mediator.timeline.getSelectedFrames();
			for (var i : int = 0; i < selection.length; i += 3)
			{
				var layer : Layer = this.mediator.timeline.layers[selection[i]];
				var layerView : LayerView = this.getLayerView(layer);
				layerView.onUpdate();
			}
		}

		public function onConvertSelectionKeyframes() : void
		{
			var selection : Vector.<int> = this.mediator.timeline.getSelectedFrames();
			for (var i : int = 0; i < selection.length; i += 3)
			{
				var layer : Layer = this.mediator.timeline.layers[selection[i]];
				var layerView : LayerView = this.getLayerView(layer);
				layerView.onUpdate();
			}
		}

		public function onDeleteSelectionFrames() : void
		{
			var selection : Vector.<int> = this.mediator.timeline.getSelectedFrames();
			for (var i : int = 0; i < selection.length; i += 3)
			{
				var layer : Layer = this.mediator.timeline.layers[selection[i]];
				var layerView : LayerView = this.getLayerView(layer);
				layerView.onUpdate();
			}
		}
	}
}
