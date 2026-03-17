export 'params.dart';

import 'dart:io';

import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/coin.dart';
import 'package:otc_app/models/list_response.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/models/share_setting.dart';
import 'package:otc_app/models/system_message.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/models/trade_payment.dart';
import 'package:otc_app/models/trade_user_commission.dart';
import 'package:otc_app/network/request/appeal_request.dart';
import 'package:otc_app/network/request/auth_request.dart';
import 'package:otc_app/network/request/bill_log_request.dart';
import 'package:otc_app/network/request/bind_account_request.dart';
import 'package:otc_app/network/request/bind_google_auth_request.dart';
import 'package:otc_app/network/request/chat_message_request.dart';
import 'package:otc_app/network/request/check_update_request.dart';
import 'package:otc_app/network/request/coinpay_Request.dart';
import 'package:otc_app/network/request/id_request.dart';
import 'package:otc_app/network/request/login_request.dart';
import 'package:otc_app/network/request/match_order_request.dart';
import 'package:otc_app/network/request/message_history_request.dart';
import 'package:otc_app/network/request/order_list_request.dart';
import 'package:otc_app/network/request/order_trades_request.dart';
import 'package:otc_app/network/request/paging_request.dart';
import 'package:otc_app/network/request/post_withdraw_request.dart';
import 'package:otc_app/network/request/publish_order_request.dart';
import 'package:otc_app/network/request/quick_trade_request.dart';
import 'package:otc_app/network/request/recharge_list_request.dart';
import 'package:otc_app/network/request/recharge_pay_request.dart';
import 'package:otc_app/network/request/recharge_request.dart';
import 'package:otc_app/network/request/register_request.dart';
import 'package:otc_app/network/request/reset_password_request.dart';
import 'package:otc_app/network/request/send_captcha_request.dart';
import 'package:otc_app/network/request/set_commission_request.dart';
import 'package:otc_app/network/request/set_pay_password_request.dart';
import 'package:otc_app/network/request/trade_by_payment_request.dart';
import 'package:otc_app/network/request/trade_list_request.dart';
import 'package:otc_app/network/request/transfer_coin_request.dart';
import 'package:otc_app/network/request/transfer_logs_request.dart';
import 'package:otc_app/network/request/update_user_info_request.dart';
import 'package:otc_app/network/request/withdraw_logs_request.dart';
import 'package:otc_app/network/response/appeal_detail_res.dart';
import 'package:otc_app/network/response/article.dart';
import 'package:otc_app/network/response/banner.dart';
import 'package:otc_app/network/response/bill_types_fon.dart';
import 'package:otc_app/network/response/brokerage_list_fon.dart';
import 'package:otc_app/network/response/check_update_response.dart';
import 'package:otc_app/network/response/coin_bills_fon.dart';
import 'package:otc_app/network/response/dialogue_message_list_fon.dart';
import 'package:otc_app/network/response/login_response.dart';
import 'package:otc_app/network/response/receive_setting.dart';
import 'package:otc_app/network/response/recharge_res_detail.dart';
import 'package:otc_app/network/response/system_wallet_fon.dart';
import 'package:otc_app/network/response/trade_by_payment.dart';
import 'package:otc_app/network/response/trade_coin_market_fon.dart';
import 'package:otc_app/network/response/trade_commission.dart';
import 'package:otc_app/network/response/trade_ctc_appeal_reason.dart';
import 'package:otc_app/network/response/trade_fast_number_fon.dart';
import 'package:otc_app/network/response/trade_notice_fon.dart';
import 'package:otc_app/network/response/trans_fon.dart';
import 'package:otc_app/network/response/upload_response.dart';
import 'package:otc_app/network/response/user_assets_response.dart';
import 'package:otc_app/network/response/user_statistic_fon.dart';
import 'package:otc_app/network/response/user_statistic_team.dart';
import 'package:otc_app/network/response/withdraw_fee_res.dart';
import 'package:otc_app/network/response/withdraw_log.dart';
import 'package:otc_app/network/response/trade_payment_channel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:otc_app/models.dart';

import 'response/dialogue_list_fon.dart';
import 'response/income_statistics.dart';

part 'api_client.g.dart';

/// https://pub.dev/packages/retrofit
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/index/bannerList')
  Future<AppResponse<ListResponse<Banner>>> bannerList();

  @GET('/user/userInfo')
  Future<AppResponse<User>> userInfo();

  @POST('/user/register')
  Future<AppResponse<LoginResponse>> register(@Body() RegisterRequest params);

  @POST('/user/resetLoginPassword')
  Future<AppResponse<LoginResponse>> resetPassword(
      @Body() ResetPasswordRequest params);

  @POST('/user/login')
  Future<AppResponse<LoginResponse>> login(@Body() LoginRequest params);

  @POST('/user/auth')
  Future<AppResponse> auth(@Body() AuthRequest params);

  @POST('/user/updatePayPassword')
  Future<AppResponse> updatePayPassword(@Body() Map<String, String> params);

  @POST('/user/updateLoginPassword')
  Future<AppResponse> updateLoginPassword(@Body() Map<String, String> params);

  @POST('/user/bindAccount')
  Future<AppResponse> bindAccount(@Body() BindAccountRequest params);

  @POST('/userCoin/coinPay')
  Future<AppResponse> userCoinCoinPay(@Body() CoinPayRequest params);

  @POST('/user/updateUserInfo')
  Future<AppResponse> updateUserInfo(@Body() UpdateUserInfoRequest params);

  @POST('/user/sendCaptcha')
  Future<AppResponse> sendCaptcha(@Body() SendCaptchaRequest params);

  @POST('/user/bindGoogleSecret')
  Future<AppResponse> bindGoogleSecret(@Body() BindGoogleAuthRequest params);

  @POST('/user/delGoogleSecret')
  Future<AppResponse> deleteGoogleSecret(@Body() BindGoogleAuthRequest params);

  @GET('/userPaymentMethod/list')
  Future<AppResponse<PagingIndex<Payment>>> payments(
      @Query('page') int page, @Query('pageSize') int size);

  @POST('/userPaymentMethod/create')
  Future<AppResponse> createPayment(@Body() Payment params);

  @POST('/userPaymentMethod/update')
  Future<AppResponse> updatePayment(@Body() Payment params);

  @POST('/userPaymentMethod/delete')
  Future<AppResponse> deletePayment(@Body() Payment params);

  @POST('/user/setPayPassword')
  Future<AppResponse> setPayPassword(@Body() SetPayPasswordRequest params);

  @POST('/ctcOrder/list')
  Future<AppResponse<PagingIndex<PublishOrder>>> orderList(
      @Body() OrderListRequest params);

  @POST('/ctcOrder/userOrderList')
  Future<AppResponse<PagingIndex<PublishOrder>>> userOrderList(
      @Body() OrderListRequest params);

  @POST('/ctcOrder/terminationOrder')
  Future<AppResponse> terminationOrder(@Body() IdRequest params);

  @POST('/ctcOrder/orderTradeList')
  Future<AppResponse<PagingIndex<TradeDetail>>> orderTradeList(
      @Body() OrderTradesRequest params);

  @POST('/ctcTrade/buy')
  Future<AppResponse<TradeDetail>> tradeBuy(
      @Body(nullToAbsent: true) MatchOrderRequest params);

  @POST('/ctcTrade/sell')
  Future<AppResponse<TradeDetail>> tradeSell(
      @Body(nullToAbsent: true) MatchOrderRequest params);

  @POST('/ctcTrade/list')
  Future<AppResponse<PagingIndex<TradeDetail>>> tradeList(
      @Body(nullToAbsent: true) TradeListRequest params);

  @GET('/ctcTrade/detail')
  Future<AppResponse<TradeDetail>> tradeDetail(@Query('id') int id);

  @POST('/ctcTrade/payConfirm')
  Future<AppResponse> confirmPay(@Body() Map<String, dynamic> params);

  @POST('/ctcTrade/receiptConfirm')
  Future<AppResponse> receiptConfirm(@Body() IdRequest params);

  @POST('/ctcTrade/receivingConfirm')
  Future<AppResponse> receivingConfirm(@Body() IdRequest params);

  @POST('/ctcTrade/cancel')
  Future<AppResponse> cancelTrade(@Body() IdRequest params);

  @GET('/userCoin/detail')
  Future<AppResponse<UserAssetsResponse>> userAssets();

  @POST('/ctcTrade/fastBuy')
  Future<AppResponse<TradeDetail>> quickBuy(@Body() QuickTradeRequest params);

  @POST('/ctcTrade/fastSell')
  Future<AppResponse<TradeDetail>> quickSell(@Body() QuickTradeRequest params);

  @POST('/ctcOrder/publish')
  Future<AppResponse> publishOrder(@Body() PublishOrderRequest params);

  @POST('/user/receivingSwitch')
  Future<AppResponse> acceptSwitch(@Body() Map<String, dynamic> params);

  @GET('/index/fastNumber')
  Future<AppResponse<ListResponse<TradeFastNumberFon>>> fastNumbers();

  @GET('/index/noticeList')
  Future<AppResponse<ListResponse<TradeNoticeFon>>> noticeList();

  @GET('/index/coinMarket')
  Future<AppResponse<ListResponse<TradeCoinMarketFon>>> marketCoins();

  @GET('/ctcAppeal/getAppealReason')
  Future<AppResponse<ListResponse<TradeCtcAppealReason>>> appealReasons();

  @POST('/ctcAppeal/apply')
  Future<AppResponse> postAppeal(@Body() AppealRequest params);

  @GET('/ctcAppeal/detail')
  Future<AppResponse<AppealDetailRes>> appealDetail(@Query('id') int id);

  @POST('/ctcAppeal/cancel')
  Future<AppResponse> appealCancel(@Body() IdRequest params);

  @POST('/userCoin/coinTrans')
  Future<AppResponse> transferCoin(@Body() TransferCoinRequest params);

  @POST('/userCoin/transList')
  Future<AppResponse<PagingIndex<TransFon>>> transferLogs(
      @Body() TransferLogsRequest params);

  @GET('/userCoin/getCoinTransFee')
  Future<AppResponse> transferFee(
      @Query('coinId') int coinId, @Query('number') double number);

  @GET('/userCoin/coinSetting')
  Future<AppResponse<Coin>> coinInfo(@Query('id') int coinId);

  @POST('/team/agencyList')
  Future<AppResponse<PagingIndex<UserStatisticFon>>> myTeamMembers(
      @Body() Map<String, dynamic> params);

  @POST('/team/agencyBrokerage')
  Future<AppResponse<PagingIndex<BrokerageListFon>>> teamRewards(
      @Body() PagingRequest params);

  @GET('/team/agencyRule')
  Future<AppResponse> agentRule();

  @GET('/team/teamStatistic')
  Future<AppResponse<UserStatisticTeam>> teamStatistic();

  @POST('/message/send')
  Future<AppResponse<DialogueMessageListFon>> sendMessage(
      @Body() ChatMessageRequest params);

  @POST('/message/dialogueMessageList')
  Future<AppResponse<PagingIndex<DialogueMessageListFon>>> messageList(
      @Body() MessageHistoryRequest request);

  @POST('/message/dialogueList')
  Future<AppResponse<PagingIndex<DialogueListFon>>> dialogueList(
      @Body() PagingRequest request);

  @GET('/message/getDialogueId')
  Future<AppResponse<DialogueListFon>> getDialogue(
      @Query('receiveId') int receiveId);

  @POST('/userCoin/coinBillsList')
  Future<AppResponse<PagingIndex<CoinBillsFon>>> billLogs(
      @Body() BillLogRequest request);

  @GET('/userCoin/billTypesList')
  Future<AppResponse<ListResponse<BillTypesFon>>> billTypes();

  @POST('/message/systemMessageList')
  Future<AppResponse<PagingIndex<SystemMessage>>> systemMessageList(
      @Body() PagingRequest params);

  @GET('/message/systemMessageDetail')
  Future<AppResponse<SystemMessage>> systemMessageDetail(@Query('id') int id);

  @GET('/message/systemMessageUnread')
  Future<AppResponse<int>> unreadCount();

  @GET('/recharge/rechargeAddress')
  Future<AppResponse<ListResponse<SystemWalletFon>>> rechargeAddress();

  @GET('/recharge/rechargePayAmount')
  Future<AppResponse<String>> rechargePayAmount(@Query('amount') double amount);

  @POST('/recharge/recharge')
  Future<AppResponse> recharge(@Body() RechargeRequest request);

  @POST('/recharge/rechargePay')
  Future<AppResponse> rechargePay(@Body() RechargePayRequest request);

  @POST('/recharge/rechargeList')
  Future<AppResponse<PagingIndex<RechargeResDetail>>> rechargeList(
      @Body() RechargeListRequest request);

  @GET('/team/getCommissionSet')
  Future<AppResponse<List<TradeCommission>>> tradeCommission();

  @GET('/user/getUserCommission')
  Future<AppResponse<List<TradeUserCommission>>> getUserCommission(
      @Query('userId') int id);

  @POST('/user/setUserCommission')
  Future<AppResponse> setUserCommission(@Body() SetCommissionRequest request);

  @GET('/userCoin/getUSDRate')
  Future<AppResponse<double>> getUsdRate({@Query('type') String type = 'FLAT'});

  @GET('/ctcTrade/tradeStatistic')
  Future<AppResponse<TradeCtcTradeStatistic>> tradeStatistic(
      {@Query('day') String day = 'today'});

  @POST('/ctcTrade/tradeByPaymentList')
  Future<AppResponse<ResponseCtcTradeByPaymentListRes>> tradeStatisticByPayment(
      @Body() TradeByPaymentRequest request);

  @GET('/userCoin/getCoinWithdrawFee')
  Future<AppResponse<WithdrawFeeRes>> withdrawFee({
    @Query('number') required double num,
    @Query('coinId') int coinId = 1,
  });

  @POST('/userCoin/withdraw')
  Future<AppResponse> postWithdraw(@Body() PostWithdrawRequest request);

  @POST('/userCoin/withdrawList')
  Future<AppResponse<PagingIndex<WithdrawLog>>> withdrawLogs(
      @Body() WithdrawLogsRequest request);

  @GET('/index/articleDetail')
  Future<AppResponse<Article>> getArticle({
    @Query('tag') required String tag,
  });

  @POST('/receiveOrderSetting/detail')
  Future<AppResponse<ReceiveSetting>> receiveOrderSetting(@Body() dynamic data);

  @GET('/userPaymentMethod/channel')
  Future<AppResponse<ListResponse<TradePaymentChannel>>> paymentChannels(
      {@Query('type') int type = 0, @Query('payWay') int payWay = 0});

  @POST('/receiveOrderSetting/update')
  Future<AppResponse> updateReceiveOrderSetting(@Body() ReceiveSetting data);

  @GET('/userPaymentMethod/channel')
  Future<AppResponse<ListResponse<TradePayment>>> paymentMethods(
      [@Query('type') int type = 0]);

  @GET('/index/getShareRewardSetting')
  Future<AppResponse<ShareSetting>> shareSetting();

  @POST('/version/needUpgrade')
  Future<AppResponse<CheckUpdateResponse>> needUpgrade(
      @Body() CheckUpdateRequest params);

  @MultiPart()
  @POST('/user/upload')
  Future<AppResponse<UploadResponse>> upload(@Part() File file);
}
