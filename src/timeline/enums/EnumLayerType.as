package timeline.enums
{

	/**
	 * LayerType 一个字符串，它指定要添加的图层的类型。如果省略此参数，则创建“Normal”类型的图层。此参数是可选的。可接受值为 "normal"、"guide"、"guided"、"mask"、"masked" 和 "folder"。 
	 * @author tamt
	 */
	public class EnumLayerType
	{
		public static const FOLDER : String = "folder";
		public static const MASKED : String = "masked";
		public static const MASK : String = "mask";
		public static const GUIDED : String = "guided";
		public static const GUIDE : String = "guide";
		public static const NORMAL : String = "normal";
	}
}
