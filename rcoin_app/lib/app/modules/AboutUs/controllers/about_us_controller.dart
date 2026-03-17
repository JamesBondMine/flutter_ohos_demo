import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/response/article.dart';

class AboutUsController extends GetxController with StateMixin<Article>{
  @override
  void onInit() {
    super.onInit();
    fetchDetail();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchDetail() async {
    final res = await NetRepository.client.getArticle(tag: 'ABOUT_US');
    if (res.code != 0) {
      change(null, status: RxStatus.error(res.msg));
      return;
    }
    change(res.data, status: RxStatus.success());
  }
}
