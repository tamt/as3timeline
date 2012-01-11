package timeline.util
{
	import timeline.core.elements.Element;

	import flash.display.DisplayObjectContainer;

	import timeline.core.Layer;

	import flash.geom.ColorTransform;

	/**
	 * @author tamt
	 */
	public class Util
	{
		/**
		 * 返回layer的最后一个关键帧
		 * @param layer
		 * @return	int	最后一个关键帧的索引值, 如果为-1, 代表没有关键帧.
		 */
		public static function getLastKeyframe(layer : Layer) : int
		{
			for (var frameIndex : int = layer.frameCount; frameIndex >= 0; frameIndex--)
			{
				if (layer.checkIsKeyFrame(frameIndex))
				{
					return frameIndex;
				}
			}

			return -1;
		}

		/**
		 * 两个区间是不是有交集
		 * @return	有交集则返回true, 否则返回false
		 */
		public static function extentIntersection(aStart : int, aEnd : int, bStart : int, bEnd : int) : Boolean
		{
			if (bStart <= aEnd && bEnd >= aStart)
			{
				return true;
			}
			return false;
		}

		/**
		 * 一个区间是不是包含另外一个区间
		 */
		public static function extentContains(aStart : int, aEnd : int, bStart : int, bEnd : int) : Boolean
		{
			if (bStart >= aStart && bStart <= aEnd && bEnd >= aStart && bEnd <= aEnd)
			{
				return true;
			}
			return false;
		}

		/**
		 * tint效果
		 */
		public static function getTintColorTransform(color : int, mul : Number = 1) : ColorTransform
		{
			var ctMul : Number = (1 - mul);

			var ctRedOff : Number = Math.round(mul * (( color >> 16 ) & 0xFF));

			var ctGreenOff : Number = Math.round(mul * ( (color >> 8) & 0xFF ));

			var ctBlueOff : Number = Math.round(mul * ( color & 0xFF ));

			return new ColorTransform(ctMul, ctMul, ctMul, 1, ctRedOff, ctGreenOff, ctBlueOff, 0);
		}

		/**
		 * 返回一个随机的256颜色
		 */
		public static function getRandom256Color() : uint
		{
			var r : uint = Math.random() * 255;
			var g : uint = Math.random() * 255;
			var b : uint = Math.random() * 255;

			return (r << 16) + (g << 8) + b;
		}

		public static function removeAllChildren(container : DisplayObjectContainer) : void
		{
			while (container.numChildren)
			{
				container.removeChildAt(0);
			}
		}

		/**
		 * 对比Vector里的元素是不是相同.
		 */
		public static function compareElements(elements1 : Vector.<Element>, elements2 : Vector.<Element>) : Boolean
		{
			if (elements1 == elements2) return true;
			if (elements1.length == elements2.length)
			{
				for (var i : int = 0; i < elements1.length; i++)
				{
					if (elements1[i] != elements2[i]) return false;
				}
				return true;
			}
			return false;
		}
	}
}
