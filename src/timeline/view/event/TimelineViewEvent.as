package timeline.view.event
{
	import flash.events.Event;

	/**
	 * @author tamt
	 */
	public class TimelineViewEvent extends Event
	{
		//鼠标在帧上按下时
		public static const MOUSE_DOWN_FRAME : String = "MOUSE_DOWN_FRAME";
		//鼠标在帧上滑动时
		public static const MOUSE_MOVE_FRAME : String = "MOUSE_MOVE_FRAME";
		//鼠标在帧上释放时
		public static const MOUSE_UP_FRAME : String = "MOUSE_UP_FRAME";
		//鼠标点击一个层时
		public static const CLICK_LAYER : String = "CLICK_LAYER";
		//
		public function TimelineViewEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
