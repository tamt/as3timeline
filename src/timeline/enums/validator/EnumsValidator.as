package timeline.enums.validator
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	/**
	 * 枚举值验证器, 用于验证一个值是不是在枚举属性组中(是不是合法的)
	 * @author tamt
	 */
	public class EnumsValidator
	{
		private static var _describeMap : Dictionary = new Dictionary();
		private static var _constMap : Dictionary = new Dictionary();

		public function EnumsValidator()
		{
		}

		/**
		 * 验证一个值是不是在枚举属性组中(是不是合法的)
		 */
		public static function validate(enumType:Class, value : *) : Boolean
		{
			if(!enumType || !value)return false;
			
			var _describe:XML = _describeMap[enumType];
			var _consts:Vector.<String> = _constMap[enumType];
			
			if (!_describe)
			{
				_describe = describeType(enumType);

				_consts = new Vector.<String>();
				for each (var constXML : XML in _describe.constant)
				{
					_consts.push(String(constXML.@name));
				}
				
				_describeMap[enumType] = _describe;
				_constMap[enumType] = _consts;
			}

			for each (var constName : String in _consts)
			{
				trace(constName, enumType[constName], value);
				if (enumType[constName] == value)
				{
					return true;
				}
			}

			return false;
		}
	}
}
