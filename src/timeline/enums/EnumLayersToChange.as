package timeline.enums
{
	/**
	 * 一个字符串，它指出应该修改哪些图层。可接受的值为 "selected"、"all" 和 "others"。如果省略此参数，则默认值为 "selected"。此参数是可选的。
	 * @author tamt
	 */
	public class EnumLayersToChange
	{
		public static const OTHERS : String = "others";
		public static const ALL : String = "all";
		public static const SELECTED : String = "selected";
	}
}
