import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/models/trade_user_commission.dart';
import 'package:otc_app/network/request/set_commission_request.dart';
import 'package:otc_app/network/response/trade_commission.dart';
import 'package:otc_app/network/response/user_statistic_fon.dart';

import '../controllers/agent_setting_page_controller.dart';

class AgentSettingPageView extends GetView<AgentSettingPageController> {
  const AgentSettingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detail = Get.arguments['detail'] as UserStatisticFon;

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AAppBar(
        title: '代理管理'.tr,
        leading: CircleLeading(),
        actions: [
          TextButton(
            onPressed: () async {
              bool? res =
                  await Get.to(() => SetBottomSheet(userId: detail.userId!));
              if (res != null && res) {
                controller.freshCommission();
              }
            },
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: const ShapeDecoration(
                  shape: CircleBorder(), color: Color(0xffF6F6F6)),
              child: const Center(
                child: Icon(
                  Icons.edit_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(14).w,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  children: [
                    Avatar(
                      width: 59.w,
                      imagePath: detail.headerImg,
                      color: Colors.grey,
                    ),
                    23.w.hb,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.nickName!,
                            style:  TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          8.w.vb,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                detail.username!,
                                style: TextStyle(
                                  color: const Color(0xFF999999),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(
                      formatDateTime(detail.CreatedAt!, format: 'yyyy.MM.dd'),
                      style: TextStyle(
                        color: const Color(0xFF666666),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              16.w.vb,
              Container(
                width: 343.w,
                padding: EdgeInsets.all(24.w),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '佣金比例'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        5.w.vb,
                      ],
                    ),
                    controller.obx((state) {
                      final List<Widget> children = [];
                      for (final item in state!) {
                        children.add(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.w.vb,
                            Text(
                              item.name!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: context.appColors.primary,
                              ),
                            ),
                            10.w.vb,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '代付佣金比例'.tr,
                                  style: TextStyle(
                                    color: const Color(0xFF999999),
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  '${item.payCommissionRate?.rtz ?? ''}%',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '代收佣金比例'.tr,
                                  style: TextStyle(
                                    color: const Color(0xFF999999),
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  '${item.commissionRate?.rtz ?? ''}%',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ));
                      }

                      return Column(
                        children: children,
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SetBottomSheet extends HookWidget {
  const SetBottomSheet({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    final AgentSettingPageController controller = Get.find();

    final commissions =
        controller.state?.where((e) => e.id != null).toList() ?? [];
    Map<int, TradeUserCommission> commissionMap =
        commissions.fold({}, (m, e) => m..[e.id!] = e);
    var config = useState<List<TradeCommission>>([]);
    var loading = useState<bool>(true);

    useEffect(() {
      NetRepository.client.tradeCommission().then((res) {
        config.value = res.data;
        loading.value = false;
      });
      return null;
    }, []);

    final List<Widget> children = [];
    if (!loading.value && config.value.isNotEmpty) {
      for (var i = 0; i < commissions.length; i++) {
        final itemConfig = config.value
            .firstWhere((element) => element.id == commissions[i].id);
        children.add(ConfigInput(
            m: commissionMap, id: commissions[i].id!, config: itemConfig));
      }
    }

    return Scaffold(
      appBar: AAppBar(
        title: '修改佣金比例'.tr,
        leading: CircleLeading(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(26.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(4.w),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...children,
              30.w.vb,
              AppButton(
                width: 315.w,
                height: 38.w,
                onPressed: () async {
                  final res = await NetRepository.client
                      .setUserCommission(SetCommissionRequest(
                    userId: userId,
                    commission: commissionMap.values.toList(),
                  ));

                  if (res.code != 0) {
                    Toast.showError(res.msg);
                    return;
                  }
                  Toast.showSuccess('成功'.tr);
                  controller.freshCommission();
                  Get.back(result: true);
                },
                title: '确定'.tr,
                titleStyle: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.white,
                ),
              ),
              15.w.vb,
              Text(
                '修改后立即生效，只可更改一次。请谨慎处理。'.tr,
                style: TextStyle(
                  color: const Color(0xFFEE1212),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfigInput extends HookWidget {
  const ConfigInput({
    super.key,
    required this.m,
    required this.id,
    required this.config,
  });

  final Map<int, TradeUserCommission> m;
  final int id;
  final TradeCommission config;

  @override
  Widget build(BuildContext context) {
    final payCtrl = useTextEditingController()
      ..text = (m[id]!.payCommissionRate ?? '').toString();
    payCtrl.addListener(() {
      if (payCtrl.text.isEmpty) {
        m[id]!.payCommissionRate = null;
      } else {
        m[id]!.payCommissionRate = double.parse(payCtrl.text);
      }
    });
    final receiveCtrl = useTextEditingController()
      ..text = (m[id]!.commissionRate ?? '').toString();
    receiveCtrl.addListener(() {
      if (receiveCtrl.text.isEmpty) {
        m[id]!.commissionRate = null;
      } else {
        m[id]!.commissionRate = double.parse(receiveCtrl.text);
      }
    });
    return Column(
      children: [
        20.w.vb,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${m[id]!.name}(${'金额'.tr}${config.minAmount}-${config.maxAmount})',
              style: TextStyle(
                fontSize: 15.sp,
                color: context.appColors.text1,
              ),
            ),
            5.w.vb,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '代付佣金比例'.tr,
                          style: TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      10.w.vb,
                      TextField(
                        controller: payCtrl,
                        style: TextStyle(fontSize: 14.sp),
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputFormatters: [
                          positiveNumberFormatter,
                        ],
                        decoration: outlineInputDecoration.copyWith(
                            hintText: '请输入佣金比例'.tr,
                            hintStyle: TextStyle(fontSize: 14.sp),
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ),
                      2.w.vb,
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${config.minPayCommissionRate?.rtz}%-${config.payCommissionRate?.rtz}%',
                          style: TextStyle(
                            color: const Color(0xFF999999),
                            fontSize: 12.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                10.w.hb,
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '代收佣金比例'.tr,
                          style: TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      10.w.vb,
                      TextField(
                        controller: receiveCtrl,
                        style: TextStyle(fontSize: 14.sp),
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputFormatters: [
                          positiveNumberFormatter,
                        ],
                        decoration: outlineInputDecoration.copyWith(
                            hintText: '请输入佣金比例'.tr,
                            hintStyle: TextStyle(fontSize: 14.sp),
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ),
                      2.w.vb,
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${config.minCommissionRate?.rtz}%-${config.commissionRate?.rtz}%',
                          style: TextStyle(
                            color: const Color(0xFF999999),
                            fontSize: 12.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
