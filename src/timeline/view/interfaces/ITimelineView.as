package timeline.view.interfaces
{
	import timeline.core.Layer;

	/**
	 * @author tamt
	 */
	public interface ITimelineView
	{
		function onCurrentFrame(currentFrame : int) : void;

		function onCurrentLayer(currentLayer : int) : void;

		/**
		 * 当添加了新层时
		 */
		function onAddNewLayer(layer : int) : void;

		/**
		 * 当删除层时
		 */
		function onDeleteLayer(layer : Layer) : void;

		/**
		 * 选择Layers
		 */
		function onSelectLayers(selectedLayers : Vector.<int>) : void

		/**
		 * 选择帧时
		 */
		function onSelectedFrames(selectedFrames : Vector.<int>) : void

		/**
		 * 当把所选帧插入普通帧时
		 */
		function onInsertSelectionFrames() : void

		function onConvertSelectionKeyframes() : void

		function onDeleteSelectionFrames() : void

		/**
		 * 在当前层当前帧上添加一个元素
		 */
		function onAddElement(layerIndex : int, frameIndex : int, element : *) : void

		/**
		 * 当在当前层当前帧添加补间动画
		 */
		function onCreateMotionTween() : void

		function onRemoveMotionTween() : void
	}
}
