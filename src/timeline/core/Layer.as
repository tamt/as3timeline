package timeline.core
{
	import timeline.enums.EnumTweenType;
	import timeline.core.elements.Element;
	import timeline.enums.EnumLayerType;
	import timeline.enums.validator.EnumsValidator;
	import timeline.util.Util;

	/**
	 * Layer 对象表示时间轴中的图层。timeline.layers 属性包含 Layer 对象的数组，fl.getDocumentDOM().getTimeline().layers 可以访问这些对象。 
	 * @productversion Flash MX 2004。
	 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7f70.html
	 */
	public class Layer
	{
		private var _color : int;
		private var _frames : Vector.<Frame> = new Vector.<Frame>();
		private var _height : int;
		private var _layerType : String = EnumLayerType.NORMAL;
		private var _locked : Boolean;
		private var _name : String;
		private var _outline : Boolean;
		private var _parentLayer : Layer;
		private var _visible : Boolean;
		private var _selectedFrames : Vector.<int> = new Vector.<int>;

		public function Layer(name : String, layerType : String)
		{
			this.name = name;
			this.layerType = layerType;
			this.color = Util.getRandom256Color();
		}

		/**
		 * 属性；所分配的用于显示图层轮廓的颜色，使用以下格式之一：格式为 "#RRGGBB" 或 "#RRGGBBAA" 的字符串格式为 0xRRGGBB 的十六进制数字表示与十六进制数字等价的十进制整数 该属性等效于“图层属性”对话框中的“轮廓”颜色设置。 
		 * @return %RETURN%
		 * @example <p>下面的示例在 colorValue 变量中存储第一图层的值： 下面的示例显示将第一图层的颜色设置为红色的三种方法： </p>
		 * @usage <pre>layer.color</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a41.html
		 */
		public function get color() : int
		{
			return _color;
		}

		/**
		 * 属性；所分配的用于显示图层轮廓的颜色，使用以下格式之一：格式为 "#RRGGBB" 或 "#RRGGBBAA" 的字符串格式为 0xRRGGBB 的十六进制数字表示与十六进制数字等价的十进制整数 该属性等效于“图层属性”对话框中的“轮廓”颜色设置。 
		 * @return %RETURN%
		 * @example <p>下面的示例在 colorValue 变量中存储第一图层的值： 下面的示例显示将第一图层的颜色设置为红色的三种方法： </p>
		 * @usage <pre>layer.color</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a41.html
		 */
		public function set color(value : int) : void
		{
			_color = value;
		}

		/**
		 * 只读属性；一个整数，它指定图层中的帧数。
		 * @return %RETURN%
		 * @example <p>下面的示例在 fcNum 变量中存储第一图层的帧数： </p>
		 * @usage <pre>layer.frameCount</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a40.html
		 */
		public function get frameCount() : int
		{
			return this.frames.length;
		}

		/**
		 * 只读属性；Frame 对象的数组（请参阅 Frame 对象）。 
		 * @return %RETURN%
		 * @example <p>下面的示例将变量 frameArray 设置为当前文档中帧的 Frame 对象的数组：若要确定帧是否为关键帧，可以检查 frame.startFrame 属性是否与数组索引匹配，如下面的示例所示：</p>
		 * @usage <pre>layer.frames</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7f6d.html
		 */
		public function get frames() : Vector.<Frame>
		{
			return _frames;
		}

		/**
		 * 属性；一个整数，它指定百分比图层高度；等效于“图层属性”对话框中的“图层”高度值。可接受的值表示默认高度的百分比：100、200 或 300。 
		 * @return %RETURN%
		 * @example <p>下面的示例存储第一图层的高度设置的百分比值： 下面的示例将第一图层的高度设置为 300%： </p>
		 * @usage <pre>layer.height</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3e.html
		 */
		public function get height() : int
		{
			return _height;
		}

		/**
		 * 属性；一个整数，它指定百分比图层高度；等效于“图层属性”对话框中的“图层”高度值。可接受的值表示默认高度的百分比：100、200 或 300。 
		 * @return %RETURN%
		 * @example <p>下面的示例存储第一图层的高度设置的百分比值： 下面的示例将第一图层的高度设置为 300%： </p>
		 * @usage <pre>layer.height</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3e.html
		 */
		public function set height(value : int) : void
		{
			_height = value;
		}

		/**
		 * 属性；一个字符串，它指定当前使用的图层；等效于“图层属性”对话框中的“类型”设置。可接受值为 "normal"、"guide"、"guided"、"mask"、"masked" 和 "folder"。 
		 * @return %RETURN%
		 * @example <p>下面的示例将时间轴中的第一个图层设置为 folder 类型： </p>
		 * @usage <pre>layer.layerType</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3d.html
		 */
		public function get layerType() : String
		{
			return _layerType;
		}

		/**
		 * 属性；一个字符串，它指定当前使用的图层；等效于“图层属性”对话框中的“类型”设置。可接受值为 "normal"、"guide"、"guided"、"mask"、"masked" 和 "folder"。 
		 * @return %RETURN%
		 * @example <p>下面的示例将时间轴中的第一个图层设置为 folder 类型： </p>
		 * @usage <pre>layer.layerType</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3d.html
		 */
		public function set layerType(value : String) : void
		{
			if (EnumsValidator.validate(EnumLayerType, value))
			{
				_layerType = value;
			}
		}

		/**
		 * 属性；一个布尔值，它指定图层的锁定状态。如果设置为 true，则图层被锁定。默认值为 false。 
		 * @return %RETURN%
		 * @example <p>下面的示例在 lockStatus 变量中存储第一图层的状态的布尔值： 下面的示例将第一图层的状态设置为未锁定： </p>
		 * @usage <pre>layer.locked</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3c.html
		 */
		public function get locked() : Boolean
		{
			return _locked;
		}

		/**
		 * 属性；一个布尔值，它指定图层的锁定状态。如果设置为 true，则图层被锁定。默认值为 false。 

		 * @return %RETURN%
		 * @example <p>下面的示例在 lockStatus 变量中存储第一图层的状态的布尔值： 下面的示例将第一图层的状态设置为未锁定： </p>
		 * @usage <pre>layer.locked</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3c.html
		 */
		public function set locked(value : Boolean) : void
		{
			_locked = value;
		}

		/**
		 * 属性；一个字符串，它指定图层的名称。 

		 * @return %RETURN%
		 * @example <p>下面的示例将当前文档中第一个图层的名称设置为 foreground： </p>
		 * @usage <pre>layer.name</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3b.html
		 */
		public function get name() : String
		{
			return _name;
		}

		/**
		 * 属性；一个字符串，它指定图层的名称。 

		 * @return %RETURN%
		 * @example <p>下面的示例将当前文档中第一个图层的名称设置为 foreground： </p>
		 * @usage <pre>layer.name</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3b.html
		 */
		public function set name(value : String) : void
		{
			_name = value;
		}

		/**
		 * 属性；一个布尔值，它指定图层中所有对象的轮廓的状态。如果设置为 true，则图层中的所有对象仅显示轮廓。如果为 false，则对象在创建后会即刻显示。
		 * @return %RETURN%
		 * @example <p>下面的示例使第一图层上的所有对象仅显示轮廓： </p>
		 * @usage <pre>layer.outline</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3a.html
		 */
		public function get outline() : Boolean
		{
			return _outline;
		}

		/**
		 * 属性；一个布尔值，它指定图层中所有对象的轮廓的状态。如果设置为 true，则图层中的所有对象仅显示轮廓。如果为 false，则对象在创建后会即刻显示。
		 * @return %RETURN%
		 * @example <p>下面的示例使第一图层上的所有对象仅显示轮廓： </p>
		 * @usage <pre>layer.outline</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a3a.html
		 */
		public function set outline(value : Boolean) : void
		{
			_outline = value;
		}

		/**
		 * 属性；一个 Layer 对象，它表示包含此图层的文件夹、引导层或遮罩层。父图层必须为在图层前面的文件夹、引导层或遮罩层，或者是前面或后面的图层的 parentLayer。设置图层的 parentLayer 不会移动图层在列表中的位置；如果尝试将图层的 parentLayer 设置为一个需要移动该图层的另一个图层，则不会有任何效果。顶级图层使用 null。
		 * @return %RETURN%
		 * @example <p>下面的示例使用在同一时间轴上同一级的两个图层。将第一个图层 (layers[0]) 转换为文件夹，然后将其设置为第二个图层 (layers[1]) 的父文件夹。此动作将第二图层移动到第一图层内。</p>
		 * @usage <pre>layer.parentLayer</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a39.html
		 */
		public function get parentLayer() : Layer
		{
			return _parentLayer;
		}

		/**
		 * 属性；一个 Layer 对象，它表示包含此图层的文件夹、引导层或遮罩层。父图层必须为在图层前面的文件夹、引导层或遮罩层，或者是前面或后面的图层的 parentLayer。设置图层的 parentLayer 不会移动图层在列表中的位置；如果尝试将图层的 parentLayer 设置为一个需要移动该图层的另一个图层，则不会有任何效果。顶级图层使用 null。
		 * @return %RETURN%
		 * @example <p>下面的示例使用在同一时间轴上同一级的两个图层。将第一个图层 (layers[0]) 转换为文件夹，然后将其设置为第二个图层 (layers[1]) 的父文件夹。此动作将第二图层移动到第一图层内。</p>
		 * @usage <pre>layer.parentLayer</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a39.html
		 */
		public function set parentLayer(value : Layer) : void
		{
			_parentLayer = value;
		}

		/**
		 * 属性；一个布尔值，它指定舞台上的图层的对象是显示的还是隐藏的。如果设置为 true，则图层的所有对象都可见；如果为 false，则它们都是隐藏的。默认值为 true。
		 * @return %RETURN%
		 * @example <p>下面的示例使第一图层中的所有对象都不可见： </p>
		 * @usage <pre>layer.visible</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a38.html
		 */
		public function get visible() : Boolean
		{
			return _visible;
		}

		/**
		 * 属性；一个布尔值，它指定舞台上的图层的对象是显示的还是隐藏的。如果设置为 true，则图层的所有对象都可见；如果为 false，则它们都是隐藏的。默认值为 true。
		 * @return %RETURN%
		 * @example <p>下面的示例使第一图层中的所有对象都不可见： </p>
		 * @usage <pre>layer.visible</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7a38.html
		 */
		public function set visible(value : Boolean) : void
		{
			_visible = value;
		}

		/**
		 * 根据索引值返回Frame
		 */
		public function getFrame(frameIndex : int) : Frame
		{
			if (frameIndex < this.frames.length)
			{
				return this.frames[frameIndex];
			}

			return null;
		}

		/**
		 * 方法；将关键帧转换为普通帧，并删除它在当前图层中的内容。 
		 * @param startFrameIndex	 一个从零开始的索引，它定义要清除的帧范围的起点。如果省略 startFrameIndex，则该方法使用当前的选择。此参数是可选的。
		 * @param endFrameIndex	 一个从零开始的索引，它定义要清除的帧范围的终点。该范围的终点为 endFrameIndex（但不包括此值）。如果您只指定 startFrameIndex，则 endFrameIndex 默认为 startFrameIndex 的值。此参数是可选的。
		 * @return 无。 
		 * @usage <pre>timeline.clearKeyframes([startFrameIndex [, endFrameIndex]])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7830.html
		 */
		public function clearKeyframes(startFrameIndex : int, endFrameIndex : int) : void
		{
			if (startFrameIndex < this.frameCount && endFrameIndex < this.frameCount)
			{
				for (var i : int = startFrameIndex; i < endFrameIndex; i++)
				{
					// 判断是不是关键帧
					if (this.checkIsKeyFrame(i))
					{
						this.clearKeyframe(i);
					}
				}
			}
		}

		/**
		 * 清除一个关键帧:清除关键帧的内容, 也会清除关键帧duration范围内所有关键帧里的内容
		 * 如果该关键键帧的前面有关键帧, 则会把前一关键帧的startFrame和duration持续到清除范围.
		 */
		private function clearKeyframe(i : int) : void
		{
			var toClearKeyFrame : Frame = this.frames[i];
			var frameStartFrame : int, frameDuration : int, frameElements : Vector.<Element>;

			if (i > 0)
			{
				// 前一关键帧
				var preKeyFrame : Frame = this.frames[i - 1];
				frameStartFrame = preKeyFrame.startFrame;
				frameDuration = preKeyFrame.duration + toClearKeyFrame.duration;
				frameElements = preKeyFrame.elements;
			}
			else
			{
				frameStartFrame = toClearKeyFrame.startFrame;
				frameDuration = toClearKeyFrame.duration;
				frameElements = toClearKeyFrame.elements;
			}

			this.setFrameProperty("duration", frameDuration, frameStartFrame, frameStartFrame + frameDuration);
			this.setFrameProperty("startFrame", frameStartFrame, frameStartFrame, frameStartFrame + frameDuration);
			this.setFrameProperty("elements", frameElements, frameStartFrame, frameStartFrame + frameDuration);
		}

		/**
		 * 判断一个帧是不是关键帧, 包括空白关键帧.
		 */
		public function checkIsKeyFrame(frameIndex : int) : Boolean
		{
			if (frameIndex >= this.frameCount) return false;
			var frame : Frame = this.frames[frameIndex];
			if (frame.startFrame == frameIndex)
			{
				return true;
			}
			return false;
		}

		/**
		 * 将当前图层的帧转换为空白关键帧。
		 * @param startFrameIndex	 一个从零开始的索引，它指定要转换成关键帧的起始帧。如果省略 startFrameIndex，则该方法转换当前选定的帧。此参数是可选的。
		 * @param endFrameIndex	 一个从零开始的索引，它指定将停止转换成关键帧时的帧位置。要转换的帧范围的终点为 endFrameIndex（但不包括此值）。如果您只指定 startFrameIndex，则 endFrameIndex 默认为 startFrameIndex 的值。此参数是可选的。
		 * @return 无。 
		 * @example <p>下面的示例将第 2 帧到（但不包括）第 10 帧转换成空白关键帧（记住：索引值不同于帧编号值）：下面的示例将第 5 帧转换成空白关键帧：</p>
		 * @usage <pre>timeline.convertToBlankKeyframes([startFrameIndex [, endFrameIndex]])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-782f.html
		 */
		public function convertToBlankKeyframes(startFrameIndex : int, endFrameIndex : int) : void
		{
			if (endFrameIndex <= startFrameIndex) endFrameIndex = startFrameIndex + 1;
			for (var frameIndex : int = startFrameIndex; frameIndex < endFrameIndex; frameIndex++)
			{
				this.coreInsertKeyframe(frameIndex, true);
			}
		}

		/**
		 * 把现有帧数扩展到一个帧索引
		 * @param frameIndex	
		 */
		public function appendsToFrameIndex(toFrameIndex : int) : void
		{
			// 如果当前还没有帧, 则先插入一个空白关键帧
			if (frameCount == 0)
			{
				var blankFrame : Frame = new Frame();
				blankFrame.startFrame = 0;
				blankFrame.duration = 1;
				blankFrame.elements = null;
				this.frames.push(blankFrame);
			}

			// 扩展帧数到startFrame
			if (toFrameIndex >= frameCount)
			{
				// 补全现有帧长度到toFrameIndex
				var currLastFrame : Frame = this.frames[frameCount - 1];
				var preKeyframe : Frame = this.frames[currLastFrame.startFrame];
				var frameIndex : int;
				var frame : Frame;
				for (frameIndex = this.frameCount; frameIndex < toFrameIndex + 1; frameIndex++)
				{
					frame = new Frame();
					this.frames.push(frame);
				}

				// 补完的帧设置startframe, duration, elements.
				var startFrame : int = preKeyframe.startFrame;
				var duration : int = toFrameIndex + 1 - preKeyframe.startFrame;
				var elements : Vector.<Element> = preKeyframe.elements;

				this.setFrameProperty("duration", duration, preKeyframe.startFrame, toFrameIndex + 1);
				this.setFrameProperty("startFrame", startFrame, preKeyframe.startFrame, toFrameIndex + 1);
				this.setFrameProperty("elements", elements, preKeyframe.startFrame, toFrameIndex + 1);
			}
		}

		/**
		 * 核心函数:把帧转化成关键帧, 在convertToKeyframes, 和convertToBlankKeyframes调用
		 * @param startFrameIndex		起始帧
		 * @param endFrameIndex			结束帧(但不包括此值)
		 * @param clearFrameContent		是否清除关键的内容, 即是不是空白关键帧
		 */
		private function coreConvertToKeyframes(startFrameIndex : int, endFrameIndex : int, clearFrameContent : Boolean = false) : void
		{
			// if (startFrameIndex >= endFrameIndex) endFrameIndex = startFrameIndex + 1;

			var toConvertFrame : Frame, preKeyframe : Frame, nextFrame : Frame;
			var frameIndex : int, frame : Frame;
			var duration : int;

			if (startFrameIndex >= 1)
			{
				// 把现有帧数扩展到endFrame
				if (endFrameIndex >= frameCount) this.appendsToFrameIndex(endFrameIndex);

				// 设置startFrame之前
				preKeyframe = this.frames[this.frames[startFrameIndex - 1].startFrame];
				duration = startFrameIndex - preKeyframe.startFrame;
				this.setFrameProperty("duration", duration, preKeyframe.startFrame, startFrameIndex);
			}

			// 转化startFrame-endFrame
			for (frameIndex = startFrameIndex; frameIndex < endFrameIndex; frameIndex++)
			{
				toConvertFrame = this.frames[frameIndex];
				toConvertFrame.startFrame = frameIndex;
				toConvertFrame.duration = 1;
				if (clearFrameContent) toConvertFrame.clearContent();
			}

			// 转化endFrame
			if (endFrameIndex < this.frameCount)
			{
				nextFrame = this.frames[endFrameIndex];
				duration = nextFrame.duration - (endFrameIndex - nextFrame.startFrame);
				var end : int = nextFrame.startFrame + nextFrame.duration;
				this.setFrameProperty("duration", duration, endFrameIndex, end);
				this.setFrameProperty("startFrame", endFrameIndex, endFrameIndex, end);
			}
		}

		/**
		 * 将当前图层中的某个范围内的帧转换成关键帧（如果没有指定帧，则转换所选范围内的帧）。
		 * @param startFrameIndex	 一个从零开始的索引，它指定要转换成关键帧的起始帧。如果省略 startFrameIndex，则该方法转换当前选定的帧。此参数是可选的。
		 * @param endFrameIndex	 一个从零开始的索引，它指定将停止转换成关键帧时的帧位置。要转换的帧范围的终点为 endFrameIndex（但不包括此值）。如果您只指定 startFrameIndex，则 endFrameIndex 默认为 startFrameIndex 的值。此参数是可选的。
		 * @return 无。 
		 * @example <p>下面的示例将选定的帧转换成关键帧：下面的示例将第 2 帧到（但不包括）第 10 帧转换成关键帧（记住：索引值不同于帧编号值）：下面的示例将第 5 帧转换成关键帧：</p>
		 * @usage <pre>timeline.convertToKeyframes([startFrameIndex [, endFrameIndex]])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-782e.html
		 */
		public function convertToKeyframes(startFrameIndex : int, endFrameIndex : int) : void
		{
			if (endFrameIndex <= startFrameIndex) endFrameIndex = startFrameIndex + 1;
			for (var frameIndex : int = startFrameIndex; frameIndex < endFrameIndex; frameIndex++)
			{
				this.coreInsertKeyframe(frameIndex, false);
			}
//			this.coreConvertToKeyframes(startFrameIndex, endFrameIndex);
		}

		/**
		 * 方法；删除当前图层中某个帧或某个范围内的帧的所有内容。 
		 * @param startFrameIndex	 一个从零开始的索引，它定义要清除的帧范围的起点。如果省略 startFrameIndex，则该方法使用当前的选择。此参数是可选的。 
		 * @param endFrameIndex	 一个从零开始的索引，它定义要清除的帧范围的终点。该范围的终点为 endFrameIndex（但不包括此值）。如果您只指定 startFrameIndex，则 endFrameIndex 默认为 startFrameIndex 的值。此参数是可选的。
		 * @return 无。 
		 * @example <p>下面的示例清除第 6 帧到（但不包括）第 11 帧（记住：索引值不同于帧编号值）： 下面的示例清除第 15 帧：</p>
		 * @usage <pre>timeline.clearFrames([startFrameIndex [, endFrameIndex]])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7831.html
		 */
		public function clearframes(startFrameIndex : int, endFrameIndex : int) : void
		{
			if (startFrameIndex < this.frameCount)
			{
				if (endFrameIndex >= this.frameCount) endFrameIndex = this.frameCount;

				var preKeyframe : Frame, nextFrame : Frame;
				var duration : int;

				// 修改startFrame之前的那些帧
				if (startFrameIndex > 0)
				{
					preKeyframe = this.frames[this.frames[startFrameIndex - 1].startFrame];
					duration = startFrameIndex - preKeyframe.startFrame;
					this.setFrameProperty("duration", duration, preKeyframe.startFrame, startFrameIndex);
				}

				// 修改endFrame之后的帧
				nextFrame = this.frames[endFrameIndex];
				var end : int = nextFrame.startFrame + nextFrame.duration;
				duration = end - endFrameIndex;
				this.setFrameProperty("duration", duration, endFrameIndex, end);
				this.setFrameProperty("startFrame", endFrameIndex, endFrameIndex, end);

				// 修改startFrame-endFrame
				// 设置duration
				duration = endFrameIndex - startFrameIndex > 0 ? (endFrameIndex - startFrameIndex) : 1;
				this.setFrameProperty("duration", duration, startFrameIndex, endFrameIndex);
				this.setFrameProperty("startFrame", startFrameIndex, startFrameIndex, endFrameIndex);
				this.setFrameProperty("elements", null, startFrameIndex, endFrameIndex);
			}
		}

		/**
		 * 方法；在指定的帧索引处插入一个空白关键帧；如果没有指定索引，则该方法会使用“播放头/选择”来插入空白关键帧。请参阅 timeline.insertKeyframe()。
		 * @param frameNumIndex	 一个从零开始的索引，它指定要插入关键帧的帧位置。如果省略 frameNumIndex，则该方法使用当前播放头帧编号。此参数是可选的。如果指定或选定的帧是一个普通帧，则关键帧会插在该帧上。例如，如果您有编号为从 1 到 10 的 10 个帧，并且您选择第 5 帧，则此方法会使第 5 帧成为空白关键帧，而帧范围的长度仍然是 10 帧。如果选择了第 5 帧，而它是关键帧且旁边是一个普通帧，则此方法会在第 6 帧处插入一个空白关键帧。如果第 5 帧是关键帧且它旁边的帧已经是关键帧，则不会插入关键帧，但播放头会移到第 6 帧处。
		 * @return 无。 
		 * @example <p>下面的示例在第 20 帧处插入一个空白关键帧（记住：索引值不同于帧编号值）：下面的示例在当前选定的帧处插入一个空白关键帧（如果没有选择帧，则在播放头位置插入）：</p>
		 * @usage <pre>timeline.insertBlankKeyframe([frameNumIndex])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7823.html
		 */
		public function insertBlankKeyframe(frameNumIndex : int) : void
		{
			this.coreInsertKeyframe(frameNumIndex, true);
		}

		/**
		 * 方法；在指定索引处插入指定数目的帧。 
		 * 		如果没有指定参数，则此方法会按以下方式工作：
		 * 			如果没有选择一个或多个帧，则该方法会在当前图层的第一个选定帧的位置上插入选定数目的帧。
		 * 			也就是说，如果选择范围是从第 6 帧到第 10 帧（总共五帧），则该方法会在包含选定帧的图层上的第 6 帧处添加五个帧。
		 * 			如果没有选择帧，则该方法会在所有图层的当前帧处插入一个帧。
		 * 		如果指定参数，则该方法按以下方式工作：
		 * 			如果只指定 numFrames，则在当前图层的当前帧处插入指定数目的帧。
		 * 			如果指定了 numFrames，并且 bAllLayers 为 true，则在所有图层的当前帧处插入指定数目的帧。
		 * 			如果三个参数都指定，则在指定索引 (frameIndex) 处插入指定数目的帧；
		 * 			传递给 bAllLayers 的值确定这些帧是只添加到当前图层中，还是添加到所有图层中。
		 * 			如果指定或选定的帧是一个普通帧，则会在该帧处插入帧。
		 * 			例如，如果您有编号为从 1 到 10 的 10 个帧，并且您选择第 5 帧（或者向 frameIndex 传递值 4），则此方法会在第 5 帧处添加一个帧，帧范围的长度变为 11 帧。如果选择了第 5 帧并且它是一个关键帧，则无论第 6 帧旁的帧是否是关键帧，此方法都会在第 6 帧处插入一个帧。
		 * @param numFrames	 一个整数，它指定要插入的帧的数目。如果省略此参数，则该方法会在当前图层的当前选择位置插入帧。此参数是可选的。
		 * @param frameNumIndex	 一个从零开始的索引，它指定要插入新帧的帧位置。此参数是可选的。
		 * @return 无。 
		 * @example <p>下面的示例会在当前图层的当前选择位置上插入一个帧（或者多个帧，取决于选择范围）：下面的示例在所有图层的当前帧处插入五个帧：下面的示例只在当前图层中插入三个帧：下面的示例会在所有图层中插入四个帧，从第一个帧开始：</p>
		 * @usage <pre>timeline.insertFrames([numFrames [, bAllLayers [, frameNumIndex]]])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7822.html
		 */
		public function insertFrames(numFrames : int, frameNumIndex : int) : void
		{
			if (frameNumIndex >= this.frameCount)
			{
				this.appendsToFrameIndex(frameNumIndex);
			}

			for (var i : int = numFrames - 1; i >= 0; i--)
			{
				this.frames.splice(frameNumIndex + 1, 0, new Frame());
			}

			// 设置该关键帧区域内的属性
			var preKeyframe : Frame = this.frames[this.frames[frameNumIndex].startFrame];
			var startFrameIndex : int = preKeyframe.startFrame;
			var endFrameIndex : int = preKeyframe.startFrame + preKeyframe.duration + numFrames;
			var duration : int = preKeyframe.duration + numFrames;
			this.setFrameProperty("startFrame", preKeyframe.startFrame, startFrameIndex, endFrameIndex);
			this.setFrameProperty("duration", duration, startFrameIndex, endFrameIndex);
			this.setFrameProperty("elements", preKeyframe.elements, startFrameIndex, endFrameIndex);

			// 延长其后所有帧的startFrame属性
			for (var frameIndex : int = endFrameIndex; frameIndex < this.frameCount; frameIndex++)
			{
				var frame : Frame = this.frames[frameIndex];
				frame.startFrame += numFrames;
			}
		}

		/**
		 * 在指定帧处插入一个关键帧。如果省略该参数，则该方法会使用播放头或选择位置插入关键帧。此方法的作用与 timeline.insertBlankKeyframe() 相同，不同之处在于插入的关键帧包含它转换的帧的内容（也就是说，它不是空白帧）。
		 * @param frameNumIndex	 一个从零开始的索引，它指定当前图层中要插入关键帧的帧索引。如果省略 frameNumIndex，则该方法使用当前播放头或选定帧的帧编号。此参数是可选的。
		 * @return 无。 
		 * @example <p>下面的示例在播放头或选择位置上插入一个关键帧： 下面的示例在第二层的第 10 帧上插入一个关键帧（记住：索引值不同于帧或图层编号值）：</p>
		 * @usage <pre>timeline.insertKeyframe([frameNumIndex])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7821.html
		 */
		public function insertKeyframe(frameNumIndex : int) : void
		{
			this.coreInsertKeyframe(frameNumIndex, false);
		}

		/**
		 * 在指定帧处插入一个关键帧。
		 * @param blank		是不是空白关键帧
		 */
		public function coreInsertKeyframe(frameNumIndex : int, blank : Boolean = false) : void
		{
			var preKeyframe : Frame, nextFrame : Frame;
			var duration : int;

			if (frameNumIndex >= frameCount)
			{
				this.appendsToFrameIndex(frameNumIndex);
				if (frameNumIndex == 0) return;
			}

			// 如果frameNumIndex是关键帧, 则在下一帧插入.
			if (checkIsKeyFrame(frameNumIndex))
			{
				if (!this.checkIsKeyFrame(frameNumIndex + 1))
				{
					this.coreInsertKeyframe(frameNumIndex + 1, blank);
				}
			}
			else
			{
				// 修改之前的帧
				if (frameNumIndex > 0)
				{
					preKeyframe = this.frames[this.frames[frameNumIndex - 1].startFrame];
					duration = frameNumIndex - preKeyframe.startFrame;
					this.setFrameProperty("duration", duration, preKeyframe.startFrame, frameNumIndex);
				}

				// 修改之后的帧
				if (frameNumIndex < frameCount)
				{
					nextFrame = this.frames[frameNumIndex];
					duration = nextFrame.startFrame + nextFrame.duration - frameNumIndex;

					var endFrameIndex : int = nextFrame.startFrame + nextFrame.duration;
					this.setFrameProperty("duration", duration, frameNumIndex, endFrameIndex);
					this.setFrameProperty("startFrame", frameNumIndex, frameNumIndex, endFrameIndex);
					if (blank) this.setFrameProperty("elements", null, frameNumIndex, endFrameIndex);
				}

				// 插入关键帧
				// toConvertFrame = new Frame();
				// toConvertFrame.startFrame = frameNumIndex;
				// toConvertFrame.duration = 1;
				// if (!blank) toConvertFrame.elements = preKeyframe.elements;
				// this.frames.splice(frameNumIndex, 0, toConvertFrame);
			}
		}

		/**
		 * 删除帧。 
		 * @param startFrameIndex	 一个从零开始的索引，它指定要开始删除的第一个帧。如果省略 startFrameIndex，则该方法使用当前的选择；如果没有选择，则删除所有图层中当前播放头位置的所有帧。此参数是可选的。
		 * @param endFrameIndex	一个从零开始的索引，它指定要停止删除帧时的帧位置；帧范围的终点为 endFrameIndex（但不包括此值）。如果您只指定 startFrameIndex，则 endFrameIndex 默认为 startFrameIndex 的值。此参数是可选的。
		 * @return 无。 
		 * @example <p>下面的示例删除当前场景的顶层中的第 5 帧到（但不包括）第 10 帧（记住：索引值不同于帧编号值）：下面的示例删除当前场景的顶层中的第 8 帧：</p>
		 * @usage <pre>timeline.removeFrames([startFrameIndex [,endFrameIndex]])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-781f.html
		 */
		public function removeFrames(startFrameIndex : int, endFrameIndex : int) : void
		{
			if (startFrameIndex == endFrameIndex) endFrameIndex = startFrameIndex + 1;

			var num : int = endFrameIndex - startFrameIndex;
			while (num--)
			{
				this.removeFrame(startFrameIndex);
			}
		}

		/**
		 * 删除一个帧
		 */
		public function removeFrame(frameIndex : int) : void
		{
			//
			if (frameIndex >= 0 && frameIndex < frameCount)
			{
				var frame : Frame = this.frames[frameIndex];
				var keyframe : Frame = this.frames[frame.startFrame];

				// 设置本身所在的关键帧范围
				var duration : int = keyframe.duration - 1;
				setFrameProperty("duration", duration, keyframe.startFrame, keyframe.startFrame + keyframe.duration);

				// 设置其后的startFrame - 1
				var startFrameIndex : int = keyframe.startFrame + duration + 1;
				for (var k : int = startFrameIndex; k < frameCount; k++)
				{
					this.frames[k].startFrame -= 1;
				}

				// 删除帧
				this.frames.splice(frameIndex, 1);
			}
		}

		/**
		 * 方法；设置选定帧的 Frame 对象的属性。 
		 * @param 属性	 一个字符串，它指定要修改的属性的名称。有关属性和值的完整列表，请参阅 Frame 对象的“摘要”属性。此方法不能用来设置只读属性（如 frame.duration 和 frame.elements）的值。
		 * @param value	 指定要为该属性设置的值。若要确定正确的值和类型，请参阅 Frame 对象的“属性”摘要。 
		 * @param startFrameIndex	 一个从零开始的索引，它指定要修改的起始帧编号。如果省略 startFrameIndex，则该方法使用当前的选择。此参数是可选的。
		 * @param endFrameIndex	 一个从零开始的索引，它指定要停止的第一帧。帧范围的终点为 endFrameIndex（但不包括此值）。如果您指定了 startFrameIndex 但省略 endFrameIndex，则 endFrameIndex 默认为 startFrameIndex 的值。此参数是可选的。
		 * @return 无。 
		 * @example <p>下面的示例为当前文档中顶层的第一帧指定了 stop() ActionScript 命令：下面的示例为当前图层的第 2 帧到（但不包括）第 5 帧设置补间动画（记住：索引值不同于帧编号值）：</p>
		 * @usage <pre>timeline.setFrameProperty(property, value [, startFrameIndex [, endFrameIndex]])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-781b.html
		 */
		public function setFrameProperty(property : String, value : *, startFrameIndex : int, endFrameIndex : int) : void
		{
			if (endFrameIndex == startFrameIndex) endFrameIndex = startFrameIndex + 1;

			for (var frameIndex : int = startFrameIndex; frameIndex < endFrameIndex; frameIndex++)
			{
				var frame : Frame = this.frames[frameIndex];
				frame[property] = value;
			}
		}

		/**
		 * 调用选定帧的Frame对象的方法
		 * @param funName				方法的名称
		 * @param startFrameIndex		一个从零开始的索引，它指定要修改的起始帧编号。如果省略 startFrameIndex，则该方法使用当前的选择。此参数是可选的。
		 * @param endFrameIndex	 		一个从零开始的索引，它指定要停止的第一帧。帧范围的终点为 endFrameIndex（但不包括此值）。如果您指定了 startFrameIndex 但省略 endFrameIndex，则 endFrameIndex 默认为 startFrameIndex 的值。此参数是可选的。
		 * @param args					方法的参数
		 */
		public function callFrameFunction(funName : String, startFrameIndex : int, endFrameIndex : int, ...args) : void
		{
			if (endFrameIndex == startFrameIndex) endFrameIndex = startFrameIndex + 1;

			for (var frameIndex : int = startFrameIndex; frameIndex < endFrameIndex; frameIndex++)
			{
				var frame : Frame = this.frames[frameIndex];
				(frame[funName] as Function).apply(null, args);
			}
		}

		/**
		 * 方法；选择当前图层中的某个范围内的帧，或者将选择的帧设置为传递到此方法的选定数组。 
		 * @param startFrameIndex	 一个从零开始的索引，它指定要设置的起始帧。 
		 * @param endFrameIndex	一个从零开始的索引，它指定选择范围的终点；endFrameIndex 是选择范围最后一帧后面的帧。 
		 * @param bReplaceCurrentSelection	一个布尔值，如果设置为 true，则在选择指定帧之前取消选择当前选定的帧。默认值为 true。 
		 * @param selectionList	三个整数组成的数组，由 timeline.getSelectedFrames() 返回。 
		 * @return 无。 
		 * @example <p>下面的示例展示了两种方法，它们用于选择顶层图层的第 1 帧到（但不包括）第 10 帧，然后将该图层的第 12 帧到（但不包括）第 15 帧添加到当前选择（记住，索引值不同于帧编号值）：下面的示例首先将所选帧的数组存储在 savedSelectionList 变量中，然后在有命令或用户交互更改了选择之后，在代码中使用该数组来重新选择这些帧：</p>
		 * @usage <pre>timeline.setSelectedFrames(startFrameIndex, endFrameIndex [, bReplaceCurrentSelection]) 
		timeline.setSelectedFrames(selectionList [, bReplaceCurrentSelection])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7d00.html
		 */
		public function setSelectedFrames(startFrameIndex : int, endFrameIndex : int, bReplaceCurrentSelection : Boolean) : void
		{
			if (!_selectedFrames || bReplaceCurrentSelection) _selectedFrames = new Vector.<int>();

			if (startFrameIndex < 0) startFrameIndex = 0;
			if (startFrameIndex >= endFrameIndex) endFrameIndex = startFrameIndex;

			if (!_selectedFrames.length)
			{
				_selectedFrames.push(startFrameIndex, endFrameIndex);
				return;
			}

			var i : int = 0;
			// 加入选中帧数组
			for (i = 0; i < this._selectedFrames.length; i += 2)
			{
				if (startFrameIndex < this._selectedFrames[i])
				{
					this._selectedFrames.splice(i, 0, startFrameIndex, endFrameIndex);
				}
			}

			if (this._selectedFrames.length >= 4)
			{
				// 优化选中帧数组
				for (i = 0; i < this._selectedFrames.length; i += 2)
				{
					if (this._selectedFrames[i + 1] >= this._selectedFrames[i + 2])
					{
						if (this._selectedFrames[i + 1] >= this._selectedFrames[i + 3])
						{
							// 删除后两个
							this._selectedFrames.splice(i + 2, 2);
							i -= 2;
						}
						else
						{
							// 删除中间两个
							this._selectedFrames.splice(i + 1, 2);
							i -= 2;
						}
					}
				}
			}
		}

		/**
		 * 检索一个层中当前选定的帧。 
		 * @return 一个范围内的帧(Vector.<int>), 下一个值表示起始帧, 上二个表示终点帧。
		 * @example <p>当最上面的图层为当前图层时，下面的示例在“输出”面板中显示 0,5,10,0,20,25：</p>
		 * @usage <pre>null</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7d01.html
		 */
		public function getSelectedFrames() : Vector.<int>
		{
			return _selectedFrames;
		}

		/**
		 * 把frames转化成字符串
		 */
		public function toFramesString(keyFrameMode : Boolean = false) : String
		{
			var str : String = "";
			var i : int, frame : Frame;

			if (!keyFrameMode)
			{
				if (this.frames)
				{
					for (i = 0; i < this.frames.length; i++)
					{
						frame = this.frames[i];
						if (checkIsKeyFrame(i))
						{
							str += frame.hasElement() ? "●" : "○";
						}
						else
						{
							str += frame.hasElement() ? "■" : "□";
						}
					}
				}
				else
				{
					str = "Layer.toFramesString():" + "null";
				}
			}
			else
			{
				if (this.frames)
				{
					for (i = 0; i < this.frames.length; i)
					{
						frame = this.frames[i];
						str += frame.hasElement() ? "●" : "○";
						for (var j : int = frame.startFrame + 1; j < frame.startFrame + frame.duration; j++)
						{
							str += frame.hasElement() ? "■" : "□";
						}
						i += frame.duration;
					}
				}
				else
				{
					str = "Layer.toFramesString():" + "null";
				}
			}

			return str;
		}

		/**
		 * 方法；创建一个传统补间. 将当前图层中每个选定的关键帧的 frame.tweenType 属性设置为 motion，如果需要，还可以将每个帧的内容转换为单个元件实例。此属性等同于 Flash 创作工具中的“创建补间动画”菜单项。 
		 * @param startFrameIndex	 一个从零开始的索引，它指定要创建补间动画的起始帧位置。如果省略 startFrameIndex，则该方法使用当前的选择。此参数是可选的。
		 * @param endFrameIndex	 一个从零开始的索引，它指定要停止创建补间动画时的帧位置。帧范围的终点为 endFrameIndex（但不包括此值）。如果您只指定 startFrameIndex，则 endFrameIndex 默认为 startFrameIndex 的值。此参数是可选的。
		 * @return 无。 
		 * @example <p>下面的示例将从第一帧到（但不包括）第 10 帧中的形状转换成图形元件实例，并将 frame.tweenType 设置为 motion（记住：索引值不同于帧编号值）： </p>
		 * @usage <pre>timeline.createMotionTween([startFrameIndex [, endFrameIndex]])</pre>
		 * @productversion Flash MX 2004。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WS5b3ccc516d4fbf351e63e3d118a9024f3f-7aa8.html
		 */
		public function createMotionTween(startFrameIndex : int, endFrameIndex : int) : void
		{
			if (endFrameIndex <= startFrameIndex) endFrameIndex = startFrameIndex + 1;
			var keyframe : Frame;
			keyframe = this.frames[this.frames[startFrameIndex].startFrame];
			if (keyframe.hasElement())
			{
				while (Util.extentIntersection(keyframe.startFrame, keyframe.startFrame + keyframe.duration, startFrameIndex, endFrameIndex))
				{
					this.setFrameProperty("tweenType", EnumTweenType.MOTION, keyframe.startFrame, keyframe.startFrame + keyframe.duration);
					if (keyframe.startFrame + keyframe.duration < this.frameCount)
					{
						keyframe = this.frames[this.frames[keyframe.startFrame + keyframe.duration].startFrame];
					}
					else
					{
						break;
					}
				}
			}
		}

		/**
		 * 删除补间动画
		 */
		public function removeMotionTween(startFrameIndex : int, endFrameIndex : int) : void
		{
			if (endFrameIndex <= startFrameIndex) endFrameIndex = startFrameIndex + 1;
			var keyframe : Frame;
			keyframe = this.frames[this.frames[startFrameIndex].startFrame];
			if (keyframe.hasElement())
			{
				while (Util.extentIntersection(keyframe.startFrame, keyframe.startFrame + keyframe.duration, startFrameIndex, endFrameIndex))
				{
					this.setFrameProperty("tweenType", EnumTweenType.NONE, keyframe.startFrame, keyframe.startFrame + keyframe.duration);
					if (keyframe.startFrame + keyframe.duration < this.frameCount)
					{
						keyframe = this.frames[this.frames[keyframe.startFrame + keyframe.duration].startFrame];
					}
					else
					{
						break;
					}
				}
			}
		}

		/**
		 * 方法；创建一个新动画对象。这些参数是可选的，指定这些参数后，会在创建动画对象之前将时间轴选项设置为指示的帧。
		 * @param startFrame	指定要创建动画对象的第一个帧。如果省略 startFrame，则该方法使用当前的选择；如果没有选择，则删除所有图层中当前播放头位置的所有帧。此参数是可选的。 
		 * @param endFrame	指定要停止创建动画对象的帧位置；帧范围的终点为 endFrame（但不包括此值）。如果您只指定 startFrame，则 endFrame 默认为 startFrame 值。此参数是可选的。
		 * @return 无。
		 * @example <p>以下示例在顶层的当前播放头位置创建动画对象：以下示例从第 5 帧开始创建动画对象，直到当前场景中顶层的第 15 帧（但不包括该帧）：</p>
		 * @usage <pre>timeline.createMotionObject([startFrame [,endFrame])</pre>
		 * @productversion Flash Professional CS5。
		 * @see http://help.adobe.com/zh_CN/flash/cs/extend/WSffbeefbeb633bc94622cd1b2124b67b9d87-8000.html
		 */
		public function createMotionObject(startFrame : int, endFrame : int) : void
		{
			// TODO:create motion object
		}

		public function clearSelectedFrames() : void
		{
			_selectedFrames = new Vector.<int>();
		}

		/**
		 * 在帧上添加一个元素
		 */
		public function addElement(frameIndex : int, element : *) : void
		{
			if (frameIndex < this.frameCount && frameIndex >= 0)
			{
				var keyframe : Frame = this.frames[this.frames[frameIndex].startFrame];
				this.callFrameFunction("addElement", keyframe.startFrame, keyframe.startFrame + keyframe.duration, element);
			}
		}

		/**
		 * 返回前一个关键帧
		 */
		public function getPreKeyframe(frameIndex : int) : Frame
		{
			var frame : Frame = this.frames[this.frames[frameIndex].startFrame];
			if (frame.startFrame > 0)
			{
				return this.frames[this.frames[frame.startFrame - 1].startFrame];
			}
			return null;
		}
	}
}