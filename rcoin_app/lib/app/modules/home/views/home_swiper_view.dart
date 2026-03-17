import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSwiperView extends GetView<HomeController> {
  HomeSwiperView({super.key, required this.items});

  final List items;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.w)),
      child: SizedBox(
          width: 343.w,
          height: 140.w,
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              final banner = items[index];
              return GestureDetector(
                onTap: () async {
                  if (banner.url == null || banner.url == "") {
                    return;
                  }
                  if (banner.urlType != null &&
                      banner.urlType! &&
                      await canLaunchUrl(Uri.parse(banner.url ?? ''))) {
                    launchUrl(Uri.parse(banner.url ?? ''));
                  }
                },
                child: Image.network(
                  banner.thumb!,
                  // items[index]["url"],
                  width: 375.w,
                  height: 140.w,
                  fit: BoxFit.fill,
                ),
              );
            },
            // itemCount: controller.banners.length,
            itemCount: items.length,
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Color(0xffffffff),
                color: Color(0xff868788),
                activeSize: 11,
              ),
            ),
            // control: SwiperControl(),
          )),
    );
  }
}
