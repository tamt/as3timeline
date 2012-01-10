package timeline.enums
{
	/**
	 * 属性；一个字符串，它指定补间的类型；可接受值为 "motion"、"shape" 或 "none"。指定 "none" 值将删除补间动画。使用 timeline.createMotionTween() 方法创建一个补间动画。 如果指定 "motion" 值，帧中的对象必须为元件、文本字段或组合对象。该对象将从它在当前关键帧中的位置补间至下一关键帧中的位置。 如果指定 "shape"，帧中的对象必须为形状对象。该对象将从当前关键帧中的形状开始，混合成下一关键帧中的形状。
	 * @author tamt
	 */
	public class EnumTweenType
	{
		public static const NONE : String = "none";
		public static const SHAPE : String = "shape";
		public static const MOTION : String = "motion";
	}
}
