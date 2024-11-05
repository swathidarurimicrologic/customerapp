import 'package:customer_app/pages/already_member/bindings/already_member_binding.dart';
import 'package:customer_app/pages/already_member/views/already_member.dart';
import 'package:customer_app/pages/already_member/views/cancel_membership_widget.dart';
import 'package:customer_app/pages/already_member/views/update_membership_widget.dart';
import 'package:customer_app/pages/already_member/views/edit_name_phone.dart';
import 'package:customer_app/pages/create_account/bindings/create_account_binding.dart';
import 'package:customer_app/pages/create_account/views/create_account.dart';
import 'package:customer_app/pages/create_account/views/privacy_policy.dart';
import 'package:customer_app/pages/create_account/views/terms_of_service.dart';
import 'package:customer_app/pages/home/bindings/home_binding.dart';
import 'package:customer_app/pages/home/views/account/account_widget.dart';
import 'package:customer_app/pages/home/views/account/widgets/payment_methods_widget.dart';
import 'package:customer_app/pages/home/views/account/widgets/profile_widget.dart';
import 'package:customer_app/pages/home/views/account/widgets/transaction_detail.dart';
import 'package:customer_app/pages/home/views/account/widgets/transactions_widget.dart';
import 'package:customer_app/pages/home/views/account/widgets/update_phone_number_widget.dart';
import 'package:customer_app/pages/home/views/buy/add_credit_card_info.dart';
import 'package:customer_app/pages/home/views/buy/become_member/become_member_widget.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash_checkout_widget.dart';
import 'package:customer_app/pages/home/views/buy/redeem_code_widget.dart';
import 'package:customer_app/pages/home/views/buy/scan_checkout_widget.dart';
import 'package:customer_app/pages/home/views/buy/unlimited_terms.dart';
import 'package:customer_app/pages/home/views/home.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash/buy_wash_widget.dart';
import 'package:customer_app/pages/home/views/locations/location_detail_widget.dart';
import 'package:customer_app/pages/home/views/locations/locations_widget.dart';
import 'package:customer_app/pages/home/views/my_washes/my_wash_detail.dart';
import 'package:customer_app/pages/home/views/my_washes/my_washes.dart';
import 'package:customer_app/pages/legal/legal_widget.dart';
import 'package:customer_app/pages/login/views/widgets/contact_details.dart';
import 'package:customer_app/pages/login/views/widgets/main_screen.dart';
import 'package:customer_app/pages/redeem_wash/bindings/redeem_wash_binding.dart';
import 'package:customer_app/pages/redeem_wash/views/scan_qrcode_page.dart';
import 'package:customer_app/pages/redeem_wash/views/scan_qrcode_permission.dart';
import 'package:customer_app/pages/search_location/views/search_location_widget.dart';
import 'package:customer_app/pages/login/bindings/login_binding.dart';
import 'package:customer_app/pages/login/views/login.dart';
import 'package:customer_app/pages/splash_screen/bindings/splash_screen_binding.dart';
import 'package:customer_app/pages/splash_screen/views/splash_view.dart';
import 'package:customer_app/pages/verify_account/bindings/verify_account_binding.dart';
import 'package:customer_app/pages/verify_account/views/verify_account.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_LOCATION,
      page: () => const SearchLocationWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_DETAILS,
      page: () => const ContactDetailsWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BUY_WASH,
      page: () => const BuyWashWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BECOME_MEMBER,
      page: () => const BecomeMemberWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REDEEM_WASH,
      page: () => const ScanQRCodePermission(),
      binding: RedeemWashBinding(),
    ),
    GetPage(
      name: _Paths.BUY_WASH_CHECKOUT,
      page: () => const BuyWashCheckoutWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_CHECKOUT,
      page: () => const ScanCheckoutWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MY_WASHES,
      page: () => const MyWashesWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MY_WASH_DETAIL,
      page: () => MyWashDetailWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REDEEM_CODE,
      page: () => const RedeemCodeWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_CODE,
      page: () => const ScanCodePage(),
      binding: RedeemWashBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_CARD,
      page: () => const AddCreditCardInfoWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.UNLIMITED_TERMS,
      page: () => const UnlimitedTerms(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOCATIONS,
      page: () => const LocationsWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_DETAIL,
      page: () => const LocationDetailWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_ACCOUNT,
      page: () => const VerifyAccount(),
      binding: VerifyAccountBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_SCREEN,
      page: () => const MainScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT,
      page: () => const CreateAccount(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsOfService(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicy(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.ALREADY_MEMBER,
      page: () => const AlreadyMemberWidget(),
      binding: AlreadyMemberBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_MEMBERSHIP,
      page: () => const UpdateMembershipWidget(),
      binding: AlreadyMemberBinding(),
    ),
    GetPage(
      name: _Paths.CANCEL_MEMBERSHIP,
      page: () => const CancelMembershipWidget(),
      binding: AlreadyMemberBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_NAME,
      page: () => const EditNamePhone(),
      binding: AlreadyMemberBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PHONE_NUMBER,
      page: () => UpdatePhoneNumberWidget(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_DETAIL,
      page: () => const TransactionDetailWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD,
      page: () => const PaymentMethodsWidget(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LEGAL,
      page: () => const LegalWidget(),
      binding: HomeBinding(),
    ),
  ];
}
