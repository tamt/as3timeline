package timeline.enums
{
	/**
	 * 属性；一个字符串，它指定 Frame 名称的类型。可接受值为 "none"、"name"、"comment" 和 "anchor"。将标签设置为 "none" 可清除 frame.name 属性。 
	 * @author tamt
	 */
	public class EnumLabelType
	{
		public static const ANCHOR : String = "anchor";
		public static const COMMENT : String = "comment";
		public static const NAME : String = "name";
		public static const NONE : String = "none";
	}
}
