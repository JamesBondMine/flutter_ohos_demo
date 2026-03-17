import 'package:otc_app/common/net.dart';
import 'dart:convert';
import 'config.dart';

main() async {
  (await Config.init());
  print('after config init');
}
// String replacePlaceholders(String template, Map<String, dynamic> replacements) {
//   // 遍历replacements中的每个键值对
//   replacements.forEach((key, value) {
//     // 创建一个正则表达式来匹配模板中的占位符，以:作为标识
//     final placeholderRegex = RegExp(r':\b' + RegExp.escape(key) + r'\b');
//     // 将所有匹配的占位符替换为对应的值
//     template = template.replaceAll(placeholderRegex, value.toString());
//   });
//
//   return template;
// }
//
// void main() {
//   // 示例字符串和参数
//   String template = "我有:num个苹果，我还有:num1个橙子";
//   Map<String, dynamic> replacements = {
//     'num': 5,
//     'num1': 10
//   };
//
//   // 替换占位符
//   String result = replacePlaceholders(template, replacements);
//   print(result);  // 输出 "我有5个苹果，我还有5个橙子"
// }
