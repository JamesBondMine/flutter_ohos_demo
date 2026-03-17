import 'package:get/get.dart';
import 'package:otc_app/intl/en_US.dart';
import 'package:otc_app/intl/zh_CN.dart';

import 'hi_IN.dart';

class IntlMessages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // 'zh_CN': zh_CN,
        'en_US': en_US,
        'hi_IN': hi_IN,
      };
}
