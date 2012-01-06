package timeline.util {
	import timeline.core.Layer;

	/**
	 * @author tamt
	 */
	public class Util {
		/**
		 * 返回layer的最后一个关键帧
		 * @param layer
		 * @return	int	最后一个关键帧的索引值, 如果为-1, 代表没有关键帧.
		 */
		public static function getLastKeyframe(layer : Layer) : int {
			for (var frameIndex : int = layer.frameCount; frameIndex >= 0; frameIndex--) {
				if (layer.checkIsKeyFrame(frameIndex)) {
					return frameIndex;
				}
			}

			return -1;
		}

		/**
		 * 两个区间是不是有交集
		 * @return	有交集则返回true, 否则返回false
		 */
		public static function extentIntersection(aStart : int, aEnd : int, bStart : int, bEnd : int) : Boolean {
			var l : int = bEnd - bStart;
			if (bStart >= (aStart - l) || bEnd <= (aEnd - l)) {
				return true;
			}
			return false;
		}

		/**
		 * 一个区间是不是包含另外一个区间
		 */
		public static function extentContains(aStart : int, aEnd : int, bStart : int, bEnd : int) : Boolean {
			if (bStart >= aStart && bStart <= aEnd && bEnd >= aStart && bEnd <= aEnd) {
				return true;
			}
			return false;
		}
	}
}
