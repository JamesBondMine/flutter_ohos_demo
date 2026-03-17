import 'package:dio/dio.dart';
import 'package:otc_app/common/widgets/toast.dart';

tryCatch(Future Function() fn) async {
  try {
    await fn();
  } on DioException catch (e) {
    Toast.showError(e.error.toString() ?? '请求失败');
  }
}
