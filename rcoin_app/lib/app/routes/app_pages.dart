import 'package:get/get.dart';
import 'package:otc_app/app/modules/add_payment/views/payment_detail_view.dart';
import 'package:otc_app/app/modules/enterPin/views/enter_pin_black_view.dart';
import 'package:otc_app/app/modules/help/views/help_publish.dart';
import 'package:otc_app/app/modules/help/views/help_rechage.dart';
import 'package:otc_app/app/modules/order_detail/views/payment_info_old.dart';
import 'package:otc_app/app/modules/post_order/views/post_order_page.dart';
import 'package:otc_app/app/modules/post_order/views/post_order_success.dart';
import 'package:otc_app/app/modules/signin/views/guid_launch_page.dart';

import '../modules/AboutUs/bindings/about_us_binding.dart';
import '../modules/AboutUs/views/about_us_view.dart';
import '../modules/AgentSettingPage/bindings/agent_setting_page_binding.dart';
import '../modules/AgentSettingPage/views/agent_setting_page_view.dart';
import '../modules/IncomeRecordDetailPage/bindings/income_record_detail_page_binding.dart';
import '../modules/IncomeRecordDetailPage/views/income_record_detail_page_view.dart';
import '../modules/IncomeRecordPage/bindings/income_record_page_binding.dart';
import '../modules/IncomeRecordPage/views/income_record_page_view.dart';
import '../modules/SharePage/bindings/share_page_binding.dart';
import '../modules/SharePage/views/share_page_view.dart';
import '../modules/acceptance/bindings/acceptance_binding.dart';
import '../modules/acceptance/views/acceptance_view.dart';
import '../modules/acceptance_order/bindings/acceptance_order_binding.dart';
import '../modules/acceptance_order/views/acceptance_order_view.dart';
import '../modules/account_detail/bindings/account_detail_binding.dart';
import '../modules/account_detail/views/account_detail_view.dart';
import '../modules/accout_binding/bindings/accout_binding_binding.dart';
import '../modules/accout_binding/views/accout_binding_view.dart';
import '../modules/add_payment/bindings/add_payment_binding.dart';
import '../modules/add_payment/views/add_payment_view.dart';
import '../modules/advertise/bindings/advertise_binding.dart';
import '../modules/advertise/views/advertise_view.dart';
import '../modules/advertise_trades/bindings/advertise_trades_binding.dart';
import '../modules/advertise_trades/views/advertise_trades_view.dart';
import '../modules/appeal/bindings/appeal_binding.dart';
import '../modules/appeal/views/appeal_view.dart';
import '../modules/application/bindings/application_binding.dart';
import '../modules/application/views/application_view.dart';
import '../modules/auth_result/bindings/auth_result_binding.dart';
import '../modules/auth_result/views/auth_result_view.dart';
import '../modules/auth_role/bindings/auth_role_binding.dart';
import '../modules/auth_role/views/auth_role_view.dart';
import '../modules/bill_logs/bindings/bill_logs_binding.dart';
import '../modules/bill_logs/views/bill_logs_view.dart';
import '../modules/bind_google_auth/bindings/bind_google_auth_binding.dart';
import '../modules/bind_google_auth/views/bind_google_auth_view.dart';
import '../modules/bind_google_auth_next/bindings/bind_google_auth_next_binding.dart';
import '../modules/bind_google_auth_next/views/bind_google_auth_next_view.dart';
import '../modules/bind_phone_email/bindings/bind_phone_email_binding.dart';
import '../modules/bind_phone_email/views/bind_phone_email_view.dart';
import '../modules/bind_phone_email_next/bindings/bind_phone_email_next_binding.dart';
import '../modules/bind_phone_email_next/views/bind_phone_email_next_view.dart';
import '../modules/chat_demo/bindings/chat_page_binding.dart';
import '../modules/chat_demo/page/chat_page.dart';
import '../modules/confirm_order/bindings/confirm_order_binding.dart';
import '../modules/confirm_order/views/confirm_order_view.dart';
import '../modules/conversation_list/bindings/conversation_list_binding.dart';
import '../modules/conversation_list/views/conversation_list_view.dart';
import '../modules/delete_google_auth/bindings/delete_google_auth_binding.dart';
import '../modules/delete_google_auth/views/delete_google_auth_view.dart';
import '../modules/enterPin/bindings/enter_pin_binding.dart';
import '../modules/enterPin/views/enter_pin_view.dart';
import '../modules/forgetpassword/bindings/forgetpassword_binding.dart';
import '../modules/forgetpassword/views/forgetpassword_verify_view.dart';
import '../modules/forgetpassword/views/forgetpassword_view.dart';
import '../modules/google_auth/bindings/google_auth_binding.dart';
import '../modules/google_auth/views/google_auth_view.dart';
import '../modules/google_auth_info/bindings/google_auth_info_binding.dart';
import '../modules/google_auth_info/views/google_auth_info_view.dart';
import '../modules/help/bindings/help_binding.dart';
import '../modules/help/views/help_buy_coin_view.dart';
import '../modules/help/views/help_payment_view.dart';
import '../modules/help/views/help_sell_coin_view.dart';
import '../modules/help/views/help_view.dart';
import '../modules/help/views/real_name_verification.dart';
import '../modules/history_orders/bindings/history_orders_binding.dart';
import '../modules/history_orders/views/history_orders_view.dart';
import '../modules/language_switch/bindings/language_switch_binding.dart';
import '../modules/language_switch/views/language_switch_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/merchant/bindings/merchant_binding.dart';
import '../modules/merchant/views/merchant_view.dart';
import '../modules/mine_info/bindings/mine_info_binding.dart';
import '../modules/mine_info/views/mine_info_view.dart';
import '../modules/notification_detail/bindings/notification_detail_binding.dart';
import '../modules/notification_detail/views/notification_detail_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/order_detail/bindings/order_detail_binding.dart';
import '../modules/order_detail/confirm_cancel_order/bindings/confirm_cancel_order_binding.dart';
import '../modules/order_detail/confirm_cancel_order/views/confirm_cancel_order_view.dart';
import '../modules/order_detail/views/order_detail_view.dart';
import '../modules/payment_method/bindings/payment_method_binding.dart';
import '../modules/payment_method/views/payment_method_view.dart';
import '../modules/post_order/bindings/post_order_binding.dart';
import '../modules/post_order/views/post_order_buy_view.dart';
import '../modules/post_order/views/post_order_sell_view.dart';
import '../modules/quick_trade/bindings/quick_trade_binding.dart';
import '../modules/quick_trade/views/quick_trade_view.dart';
import '../modules/receipt/bindings/receipt_binding.dart';
import '../modules/receipt/views/receipt_view.dart';
import '../modules/receipt_logs/bindings/receipt_logs_binding.dart';
import '../modules/receipt_logs/views/receipt_logs_view.dart';
import '../modules/receive_setting/bindings/receive_setting_binding.dart';
import '../modules/receive_setting/views/receive_setting_view.dart';
import '../modules/recharge/bindings/recharge_binding.dart';
import '../modules/recharge/views/recharge_submit_view.dart';
import '../modules/recharge/views/recharge_view.dart';
import '../modules/recharge_detail/bindings/recharge_detail_binding.dart';
import '../modules/recharge_detail/views/recharge_detail_view.dart';
import '../modules/recharge_logs/bindings/recharge_logs_binding.dart';
import '../modules/recharge_logs/views/recharge_logs_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_pay_view.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/scan_page/bindings/scan_page_binding.dart';
import '../modules/scan_page/views/scan_page_view.dart';
import '../modules/service_online/bindings/service_online_binding.dart';
import '../modules/service_online/views/service_online_view.dart';
import '../modules/set_nickname/bindings/set_nickname_binding.dart';
import '../modules/set_nickname/views/set_nickname_view.dart';
import '../modules/set_pay_password/bindings/set_pay_password_binding.dart';
import '../modules/set_pay_password/views/set_pay_password_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/teamSubMembers/bindings/team_sub_members_binding.dart';
import '../modules/teamSubMembers/views/team_sub_members_view.dart';
import '../modules/teams/bindings/teams_binding.dart';
import '../modules/teams/views/teams_view.dart';
import '../modules/trade/bindings/trade_binding.dart';
import '../modules/trade/views/trade_view.dart';
import '../modules/transfer/bindings/transfer_binding.dart';
import '../modules/transfer/views/transfer_view.dart';
import '../modules/transfer_logs/bindings/transfer_logs_binding.dart';
import '../modules/transfer_logs/views/transfer_logs_view.dart';
import '../modules/update_pay_password/bindings/update_pay_password_binding.dart';
import '../modules/update_pay_password/views/update_pay_password_view.dart';
import '../modules/user_coin_pay/bindings/user_coin_pay_binding.dart';
import '../modules/user_coin_pay/views/user_coin_pay_view.dart';
import '../modules/verify_identity/bindings/verify_identity_binding.dart';
import '../modules/verify_identity/views/verify_identity_view.dart';
import '../modules/withdraw/bindings/withdraw_binding.dart';
import '../modules/withdraw/views/withdraw_view.dart';
import '../modules/withdraw_logs/bindings/withdraw_logs_binding.dart';
import '../modules/withdraw_logs/views/withdraw_logs_view.dart';
import 'middlewares/auth_guard.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.APPLICATION;

  static final routes = [
    GetPage(
      name: _Paths.SIGN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.APPLICATION,
      page: () => ApplicationView(),
      binding: ApplicationBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.TRADE,
      page: () => const TradeView(),
      binding: TradeBinding(),
    ),
    GetPage(
      name: _Paths.ACCEPTANCE,
      page: () => const AcceptanceView(),
      binding: AcceptanceBinding(),
    ),
    GetPage(
      name: _Paths.MERCHANT,
      page: () => const MerchantView(),
      binding: MerchantBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.REGISTERPAY,
      page: () => const RegisterPayView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.QUICK_TRADE,
      page: () => const QuickTradeView(),
      binding: QuickTradeBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () => const OrderDetailView(),
      binding: OrderDetailBinding(),
      middlewares: [
        AuthGuard(),
      ],
      children: [
        GetPage(
          name: _Paths.CONFIRM_CANCEL_ORDER,
          page: () => const ConfirmCancelOrderView(),
          binding: ConfirmCancelOrderBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.AUTH_ROLE,
      page: () => const AuthRoleView(),
      binding: AuthRoleBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.AUTH_RESULT,
      page: () => const AuthResultView(),
      binding: AuthResultBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.POST_BUY_ORDER,
      page: () => const PostOrderBuyView(),
      binding: PostOrderBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.POST_ORDER_SUCCESS,
      page: () => const PostOrderSuccess(),
      binding: PostOrderBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.POST_SELL_ORDER,
      page: () => const PostOrderSellView(),
      binding: PostOrderBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.POST_ORDER_PAGE,
      page: () => const PostOrderPage(),
      binding: PostOrderBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.CONFIRM_ORDER,
      page: () => const ConfirmOrderView(),
      binding: ConfirmOrderBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.MINE_INFO,
      page: () => const MineInfoView(),
      binding: MineInfoBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.SET_NICKNAME,
      page: () => const SetNicknameView(),
      binding: SetNicknameBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.LANGUAGE_SWITCH,
      page: () => const LanguageSwitchView(),
      binding: LanguageSwitchBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_IDENTITY,
      page: () => const VerifyIdentityView(),
      binding: VerifyIdentityBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.ACCEPTANCE_ORDER,
      page: () => const AcceptanceOrderView(),
      binding: AcceptanceOrderBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD,
      page: () => const PaymentMethodView(),
      binding: PaymentMethodBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.ADD_PAYMENT,
      page: () => const AddPaymentView(),
      binding: AddPaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_INFO,
      page: () => const PaymentIDetailView(),
      binding: AddPaymentBinding(),
    ),
    GetPage(
      name: _Paths.BIND_PHONE_EMAIL,
      page: () => const BindPhoneEmailView(),
      binding: BindPhoneEmailBinding(),
    ),
    GetPage(
      name: _Paths.BIND_PHONE_EMAIL_NEXT,
      page: () => const BindPhoneEmailNextView(),
      binding: BindPhoneEmailNextBinding(),
    ),
    GetPage(
      name: _Paths.SET_PAY_PASSWORD,
      page: () => const SetPayPasswordView(),
      binding: SetPayPasswordBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PAY_PASSWORD,
      page: () => UpdatePayPasswordView(),
      binding: UpdatePayPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_ORDERS,
      page: () => const HistoryOrdersView(),
      binding: HistoryOrdersBinding(),
    ),
    GetPage(
      name: _Paths.GOOGLE_AUTH,
      page: () => const GoogleAuthView(),
      binding: GoogleAuthBinding(),
    ),
    GetPage(
      name: _Paths.BIND_GOOGLE_AUTH,
      page: () => const BindGoogleAuthView(),
      binding: BindGoogleAuthBinding(),
    ),
    GetPage(
      name: _Paths.BIND_GOOGLE_AUTH_NEXT,
      page: () => const BindGoogleAuthNextView(),
      binding: BindGoogleAuthNextBinding(),
    ),
    GetPage(
      name: _Paths.GOOGLE_AUTH_INFO,
      page: () => const GoogleAuthInfoView(),
      binding: GoogleAuthInfoBinding(),
    ),
    GetPage(
      name: _Paths.DELETE_GOOGLE_AUTH,
      page: () => const DeleteGoogleAuthView(),
      binding: DeleteGoogleAuthBinding(),
    ),
    GetPage(
      name: _Paths.ADVERTISE,
      page: () => const AdvertiseView(),
      binding: AdvertiseBinding(),
    ),
    GetPage(
      name: _Paths.ADVERTISE_TRADES,
      page: () => const AdvertiseTradesView(),
      binding: AdvertiseTradesBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_PAGE,
      page: () => const ScanPageView(),
      binding: ScanPageBinding(),
    ),
    GetPage(
      name: _Paths.APPEAL,
      page: () => const AppealView(),
      binding: AppealBinding(),
    ),
    GetPage(
      name: _Paths.RECEIPT,
      page: () => const ReceiptView(),
      binding: ReceiptBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.TRANSFER,
      page: () => const TransferView(),
      binding: TransferBinding(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: _Paths.RECEIPT_LOGS,
      page: () => const ReceiptLogsView(),
      binding: ReceiptLogsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFER_LOGS,
      page: () => const TransferLogsView(),
      binding: TransferLogsBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_ONLINE,
      page: () => const ServiceOnlineView(),
      binding: ServiceOnlineBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_PAGE,
      page: () => const ChatPage(),
      binding: ChatPageBinding(),
    ),
    GetPage(
      name: _Paths.TEAMS,
      page: () => const TeamsView(),
      binding: TeamsBinding(),
    ),
    GetPage(
      name: _Paths.CONVERSATION_LIST,
      page: () => const ConversationListView(),
      binding: ConversationListBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_DETAIL,
      page: () => const NotificationDetailView(),
      binding: NotificationDetailBinding(),
    ),
    GetPage(
      name: _Paths.BILL_LOGS,
      page: () => BillLogsView(),
      binding: BillLogsBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGE,
      page: () => const RechargeView(),
      binding: RechargeBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGESUBMIT,
      page: () => const RechargeSubmitView(),
      binding: RechargeBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGE_LOGS,
      page: () => const RechargeLogsView(),
      binding: RechargeLogsBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGE_DETAIL,
      page: () => const RechargeDetailView(),
      binding: RechargeDetailBinding(),
    ),
    GetPage(
      name: _Paths.AGENT_SETTING_PAGE,
      page: () => const AgentSettingPageView(),
      binding: AgentSettingPageBinding(),
    ),
    GetPage(
      name: _Paths.INCOME_RECORD_PAGE,
      page: () => const IncomeRecordPageView(),
      binding: IncomeRecordPageBinding(),
    ),
    GetPage(
      name: _Paths.INCOME_RECORD_DETAIL_PAGE,
      page: () => const IncomeRecordDetailPageView(),
      binding: IncomeRecordDetailPageBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW,
      page: () => const WithdrawView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_LOGS,
      page: () => const WithdrawLogsView(),
      binding: WithdrawLogsBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVE_SETTING,
      page: () => const ReceiveSettingView(),
      binding: ReceiveSettingBinding(),
    ),
    GetPage(
      name: _Paths.SHARE_PAGE,
      page: () => const SharePageView(),
      binding: SharePageBinding(),
    ),
    GetPage(
      name: _Paths.TEAM_SUB_MEMBERS,
      page: () => const TeamSubMembersView(),
      binding: TeamSubMembersBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUT_BINDING,
      page: () => const AccoutBindingView(),
      binding: AccoutBindingBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_DETAIL,
      page: () => const AccountDetailView(),
      binding: AccountDetailBinding(),
    ),
    GetPage(
      name: _Paths.HELP,
      page: () => const HelpView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.HELPREALNAME,
      page: () => const HelpRealNameView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.HELPPAYMENT,
      page: () => const HelpPayMentView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.HELPBUYCOIN,
      page: () => const HelpBuyCoinView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.HELPSELLCOIN,
      page: () => const HelpSellCoinView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSWORD,
      page: () => const ForgetpasswordView(),
      binding: ForgetpasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSWORDVERIFY,
      page: () => const ForgetpasswordVerifyView(),
      binding: ForgetpasswordBinding(),
    ),
    GetPage(
      name: _Paths.ENTER_PIN,
      page: () => const EnterPinView(),
      binding: EnterPinBinding(),
    ),
    GetPage(
      name: _Paths.ENTER_PIN_black,
      page: () => const EnterPinBlackView(),
      binding: EnterPinBinding(),
    ),
    GetPage(
      name: _Paths.USER_COIN_PAY,
      page: () => const UserCoinPayView(),
      binding: UserCoinPayBinding(),
    ),
    GetPage(
      name: _Paths.HELPRECHAGE,
      page: () => const HelpRechageView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.HELPPUBLISH,
      page: () => const HelpPublishView(),
      binding: HelpBinding(),
    ),
  ];
}

const AuthWhiteListRoute = [
  Routes.LOGIN,
  Routes.REGISTER,
  Routes.RESET_PASSWORD,
];
