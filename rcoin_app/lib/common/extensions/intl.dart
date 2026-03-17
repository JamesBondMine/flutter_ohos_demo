import 'package:get/get.dart';

extension Intl on String {
  String trans(Map<String, dynamic>? replacements) {
    if (replacements == null) {
      return tr;
    }
    return replacePlaceholders(tr, replacements);
  }
}

String replacePlaceholders(String template, Map<String, dynamic> replacements) {
  // 遍历replacements中的每个键值对
  replacements.forEach((key, value) {
    // 创建一个正则表达式来匹配模板中的占位符，以:作为标识
    final placeholderRegex = RegExp(r':\b' + RegExp.escape(key) + r'\b');
    // 将所有匹配的占位符替换为对应的值
    template = template.replaceAll(placeholderRegex, value.toString());
  });

  return template;
}