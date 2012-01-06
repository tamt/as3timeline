package test
{
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;

	import timeline.util.Util;

	import flash.events.MouseEvent;

	import fl.controls.Button;

	import timeline.view.LayerView;
	import timeline.enums.EnumLayerType;
	import timeline.core.Layer;

	import flash.display.Sprite;

	/**
	 * 测试Layer功能
	 * @author tamt
	 */
	public class TestLayer extends Sprite
	{
		// insert相关
		private var insertKeyframe : Button;
		private var insertBlankKeyframe : Button;
		private var insertFrames : Button;
		//
		private var appendToFrameIndex : Button;
		// clear相关
		private var clearframes : Button;
		private var clearKeyframes : Button;
		// convert相关
		private var convertToKeyframes : Button;
		private var convertToBlankKeyframes : Button;
		// remove相关
		private var removeFrames : Button;
		//
		private var buttons : Array;
		private var layer : Layer;
		private var view : LayerView;

		public function TestLayer()
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;

			insertKeyframe = new Button();
			insertKeyframe.label = "insertKeyframe";

			insertBlankKeyframe = new Button();
			insertBlankKeyframe.label = "insertBlankKeyframe";

			insertFrames = new Button();
			insertFrames.label = "insertFrames";

			appendToFrameIndex = new Button();
			appendToFrameIndex.label = "appendToFrameIndex";

			clearframes = new Button();
			clearframes.label = "clearframes";

			clearKeyframes = new Button();
			clearKeyframes.label = "clearKeyframes";

			convertToKeyframes = new Button();
			convertToKeyframes.label = "convertToKeyframes";

			convertToBlankKeyframes = new Button();
			convertToBlankKeyframes.label = "convertToBlankKeyframes";

			removeFrames = new Button();
			removeFrames.label = "removeFrames";

			//
			buttons = [insertKeyframe, insertBlankKeyframe, insertFrames, appendToFrameIndex, clearframes, clearKeyframes, convertToKeyframes, convertToBlankKeyframes, removeFrames];

			// 布局
			for (var i : int = 0; i < buttons.length; i++)
			{
				var button : Button = buttons[i];
				button.x = this.stage.stageWidth - button.width - 10;
				button.y = 5 + 25 * i;
				addChild(button);

				// 处理点击事件
				button.addEventListener(MouseEvent.CLICK, buttonHandler);
			}

			layer = new Layer("图层1", EnumLayerType.NORMAL);
			layer.appendsToFrameIndex(4);
			trace("TestLayer.TestLayer():" + layer.toFramesString());
			trace("TestLayer.TestLayer():" + layer.toFramesString(true));
			view = new LayerView(layer, null, null);
			addChild(view.ui);
		}

		private function buttonHandler(event : MouseEvent) : void
		{
			var button : Button = event.currentTarget as Button;
			trace('buttonHandler: ' + button.label);
			switch(button.label)
			{
				case "insertKeyframe":
					var index : int = Util.getLastKeyframe(layer) + 1;
					layer.insertKeyframe(index);
					view.render();
					break;
				case "insertBlankKeyframe":
					layer.insertBlankKeyframe(0);
					view.render();
					break;
				case "insertFrames":
					layer.insertFrames(4, 2);
					view.render();
					break;
				case "appendToFrameIndex":
					layer.appendsToFrameIndex(layer.frameCount);
					view.render();
					break;
				case "clearframes":
					layer.clearframes(2, 5);
					view.render();
					break;
				case "clearKeyframes":
					layer.clearKeyframes(2, 3);
					view.render();
					break;
				case "convertToKeyframes":
					layer.convertToKeyframes(20, 3);
					view.render();
					break;
				case "convertToBlankKeyframes":
					layer.convertToBlankKeyframes(11, 13);
					view.render();
					break;
				case "removeFrames":
					layer.removeFrames(2, 4);
					view.render();
					break;
				default:
			}

			trace("TestLayer.buttonHandler(event):nM:" + layer.toFramesString());
			trace("TestLayer.buttonHandler(event):kM:" + layer.toFramesString(true));
		}
	}
}
