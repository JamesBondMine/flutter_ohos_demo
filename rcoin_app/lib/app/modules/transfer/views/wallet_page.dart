import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/modules/home/auth/pages/auth_IDcard_page.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';
import 'package:otc_app/app/modules/identityVerification/models/auth_model.dart';
import 'package:otc_app/app/modules/trade/views/trade_buysell_page.dart';
import 'package:otc_app/app/modules/transfer/views/wallet_botton_view.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/network/response/trade_coin_market_fon.dart';
import 'package:otc_app/network/response/trans_fon.dart';

import '../controllers/transfer_controller.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WalletPageState();
  }
}

class WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: CustomImage(
                Assets.walletHeader,
                width: Get.width,
                height: 350,
              ),
            ),
            Positioned.fill(child: _bodyView(context))
          ],
        ));
  }

  Widget _bodyView(BuildContext context) {
    return FutureBuilder(
        future: _amountDetailEvent(),
        builder: (c, AsyncSnapshot<List<TransFon>> s) {
          List<TransFon> dl = [];
          if (s.hasData && s.data != null && s.data!.isNotEmpty) {
            dl.addAll(s.data!);
          }
          return ListView.builder(
              padding: const EdgeInsets.only(bottom: 30),
              itemCount: dl.length + 1,
              itemBuilder: (item, index) {
                if (index == 0) {
                  return _headerView(context);
                }
                return _cellView(dl[index - 1]);
              });
        });
  }

  Widget _cellView(TransFon detail) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Get.toNamed(Routes.RECHARGE_DETAIL, arguments: detail);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 11, bottom: 14).w,
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          // borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("手续费".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Config.kTheme!.text1,
                    )),
                Text("+ ${detail.fee} ${Config.coinName}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Config.kTheme!.text1,
                    )),
              ],
            ),
            5.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDateTime(detail.CreatedAt!),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Config.kTheme!.text2,
                      // fontWeight: FontWeight.bold,
                    )),
                Text("${'支付'.tr} ${'+'}${detail.amount}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Config.kTheme!.text2,
                    )),
              ],
            ),
            5.w.vb,
          ],
        ),
      ),
    );
    ;
  }

  Future<List<TransFon>> _amountDetailEvent() async {
    List<TransFon> dataList = await TransferController.to.requestTranslogs(0);
    return dataList;
  }

  Widget _headerView(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Text('钱包'.tr,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Config.kTheme!.text1,
                    fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
                '${normalMoney(ApplicationController.to.assets.value?.money ?? 0)} ',
                style: TextStyle(
                    fontSize: 36.sp,
                    color: Config.kTheme!.text1,
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text("${'我的资产'.tr}(RSO)",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Config.kTheme!.text2,
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${'钱包地址'.tr}:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Config.kTheme!.text2,
                    )),
                Text(ApplicationController.to.assets.value?.address ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Config.kTheme!.text2,
                    )),
                CopyBtn(
                    text: ApplicationController.to.assets.value?.address ?? "",
                    color: Config.kTheme!.bg5,
                    size: 12.w),
              ],
            ),
          ),
          10.w.vb,
          Container(
              margin: EdgeInsets.only(top: 10.w, left: 16, right: 16),
              padding: EdgeInsets.only(top: 16.w, bottom: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Config.kTheme!.bg1),
              child: Column(children: [
                _coinDetailView(),
              ])),
          10.w.vb,
          Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              padding:
                  EdgeInsets.only(top: 10.w, bottom: 15.w, left: 16, right: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Config.kTheme!.bg1),
              child: WalletButtons(trade: () {
                _userAuthEvent(context, () {
                  Get.to(TradeBuySellPage(index: 0));
                });
              })),
          10.w.vb,
          _walletCoinView(),
          Container(
              margin: EdgeInsets.only(top: 10.w, left: 16, right: 16),
              padding: EdgeInsets.only(top: 6.w, bottom: 0.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.w),
                      topRight: Radius.circular(12.w)),
                  color: Config.kTheme!.bg1),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "资金明细".tr,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Config.kTheme!.text2),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          // widget.click(0);
                          Get.toNamed(Routes.TRANSFER_LOGS);
                        },
                        icon: const CustomImage(Assets.remoatTrade))
                  ],
                ),
              ])),
        ],
      ),
    );
  }

  // 认证弹窗
  _userAuthEvent(BuildContext c, VoidCallback push) async {
    push();
    return;
    AuthModel? res = await HomeController.to.authApplyStateInfo();
    if (res != null && res.id != 0 && res.state == 0) {
      Toast.showInfo("审核中".tr);
      return;
    }
    if (res != null && res.state == 1) {
      // 通过
      push();
      return;
    }
    Get.dialog(Builder(builder: (context) {
      return Container(
          padding: EdgeInsets.only(
              bottom: (Get.height - 360) / 2,
              left: 20,
              right: 20,
              top: (Get.height - 360) / 2),
          child: Center(
              child: Container(
                  height: 200.w,
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xff232322),
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: const CustomImage(
                            Assets.alertHead,
                          ),
                        ),
                      ),
                      Positioned.fill(child: _authAlertChildView(c))
                    ],
                  ))));
    }));
  }

  // 弹窗子视图
  Widget _authAlertChildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const SizedBox(
                width: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Material(
                child: Text(
                  '温馨提示'.tr,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.close,
                  color: const Color(0xff9b9d9c),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
                child: Text(
              "Please complete".tr,
              style: TextStyle(
                fontSize: 15.sp,
                color: const Color(0xffaeaeae),
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            Material(
                child: Text(
              "'authentication'".tr,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
              ),
            ))
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                width: MediaQuery.of(context).size.width / 2 - 40.w,
                height: 52.w,
                title: 'cancel'.tr,
                titleStyle: const TextStyle(color: Color(0xff5d4c30)),
                backgroundColor: Colors.black.withOpacity(0),
                borderSide:
                    const BorderSide(color: Color(0xff5d4c30), width: 0.8),
                onPressed: () {
                  Get.back();
                },
                radius: 8.w,
              ),
              AppButton(
                width: MediaQuery.of(context).size.width / 2 - 40.w,
                height: 52.w,
                title: 'user auth'.tr,
                titleStyle: const TextStyle(color: Color(0xff5d4c30)),
                backgroundColor: const Color(0xfff4e0bd),
                onPressed: () {
                  Get.back();
                  Get.to(AuthIDCardPage());
                },
                radius: 8.w,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _walletCoinView() {
    return FutureBuilder(
        future: HomeController.to.fetchMarketCoins(),
        builder: ((context, AsyncSnapshot<List<TradeCoinMarketFon>> snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            List<TradeCoinMarketFon> dl = snapshot.data!;
            return Container(
                padding: EdgeInsets.only(
                    top: 12.w, bottom: 0.w, left: 10, right: 10),
                width: Get.width - 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Config.kTheme!.bg1),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('实时汇率'.tr,
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Config.kTheme!.text1,
                              fontWeight: FontWeight.w500)),
                      15.w.vb,
                      dl.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.RECHARGE);
                              },
                              child: _tradeCCell(dl.first))
                          : Container(),
                      dl.length > 1
                          ? GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.RECHARGE);
                              },
                              child: _tradeCCell(dl[1]))
                          : Container(),
                    ]));
          }
          return Container(
              padding:
                  EdgeInsets.only(top: 12.w, bottom: 20.w, left: 10, right: 10),
              width: Get.width - 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Config.kTheme!.bg1),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('实时汇率'.tr,
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: const Color(0xfff4e0bd),
                            fontWeight: FontWeight.w500))
                  ]));
        }));
  }

  Widget _tradeCCell(TradeCoinMarketFon model) {
    return Container(
      width: Get.width - 52,
      // height: 70,
      // color: Config.kTheme!.bg1,
      padding: const EdgeInsets.only(bottom: 19),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            child: CachedNetworkImage(
              imageUrl: model.img!,
              errorWidget: (c, x, z) {
                return Text(
                  "U",
                  style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.coinName}",
                style: TextStyle(
                    color: Config.kTheme!.text1,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
              5.w.vb,
              Text(
                '${model.symbol}',
                style: TextStyle(color: Config.kTheme!.text2, fontSize: 13.sp),
              )
            ],
          ),
          Expanded(
              child: Container(
            // color: Colors.amber,
            alignment: Alignment.center,
            child: const CustomImage(
              Assets.walletCell,
              // width: 48,
              height: 40,
              width: 100,
            ),
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${model.price}',
                style: TextStyle(
                    color: Config.kTheme!.text1,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '≈ ₹ ${model.ud?.abs().toString()}',
                style: TextStyle(
                    color: Config.kTheme!.text2,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }

  TextStyle _amountStyle() {
    return TextStyle(
        color: Config.kTheme!.text1,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500);
  }

  Widget _coinDetailView() {
    TextStyle desc = TextStyle(
        color: Config.kTheme!.text2,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500);
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 12.sp,
        color: Colors.white,
      ),
      child: SizedBox(
        // height: 32.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Obx(() => Text(
                      normalMoney(
                              ApplicationController.to.assets.value?.money ?? 0)
                          .toString(),
                      style: _amountStyle(),
                    )),
                3.w.vb,
                Text(
                  '可用余额'.tr,
                  style: desc,
                ),
              ],
            ),
            Column(
              children: [
                Obx(() => Text(
                      normalMoney(ApplicationController
                                  .to.assets.value?.tradeAmount ??
                              0)
                          .toString(),
                      style: _amountStyle(),
                    )),
                3.w.vb,
                Text(
                  '交易中'.tr,
                  style: desc,
                ),
              ],
            ),
            Column(
              children: [
                Obx(() => Text(
                      normalMoney(
                              ApplicationController.to.assets.value?.deposit ??
                                  0)
                          .toString(),
                      style: _amountStyle(),
                    )),
                3.w.vb,
                Text(
                  '冻结中'.tr,
                  style: desc,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  normalMoney(double amount) {
    if (amount > 1000000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount;
  }
}
