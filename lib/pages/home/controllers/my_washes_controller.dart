import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyWashesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  double finalAmount = 0.0;
  double totalAmount = 0.0;
  final homeController = Get.find<HomeController>();

  var myWashEmptyList = [];
  var myWashList = [
    {
      'title': 'Ultimate Full Service',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '19',
      'tax': '0.24',
      'purchase_date': '2020-03-26T00:57:08.000+08:00',
      'expiry_date': '2020-03-26T00:57:08.000+08:00',
      'number_washes': 2,
      'status': 'Active',
      'redeem_code': 'REDEEM55',
      'member_pass': '1234567890',
      'payment_info': [
        {
          'transaction_date': '2020-03-26T00:57:08.000+08:00',
          'transaction_id': 'MLA-029312',
          'card_number': '411111111111',
          'card_name': 'Joseph',
          'card_expiry': '',
          'cvv': '143',
          'id': 0
        }
      ]
    },
    {
      'title': 'Express Wash',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '19',
      'tax': '0.24',
      'purchase_date': '2020-03-26T00:57:08.000+08:00',
      'expiry_date': '2020-03-26T00:57:08.000+08:00',
      'number_washes': 0,
      'status': 'Canceled',
      'redeem_code': 'REDEEM99',
      'member_pass': '1234567890',
      'payment_info': [
        {
          'transaction_date': '2020-03-26T00:57:08.000+08:00',
          'transaction_id': 'MLA-029312',
          'card_number': '411111111111',
          'card_name': 'Joseph',
          'card_expiry': '',
          'cvv': '143',
          'id': 1
        }
      ]
    },
    {
      'title': 'Express Wash',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '19',
      'tax': '0.24',
      'purchase_date': '2020-03-26T00:57:08.000+08:00',
      'expiry_date': '2020-03-26T00:57:08.000+08:00',
      'number_washes': 0,
      'status': 'Redeemed',
      'redeem_code': 'REDEEM99',
      'member_pass': '1234567890',
      'payment_info': [
        {
          'transaction_date': '2020-03-26T00:57:08.000+08:00',
          'transaction_id': 'MLA-029312',
          'card_number': '411111111111',
          'card_name': 'Joseph',
          'card_expiry': '',
          'cvv': '143',
          'id': 2
        }
      ]
    },
    {
      'title': 'Platinum Full Service',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '19',
      'tax': '0.24',
      'purchase_date': '2020-03-26T00:57:08.000+08:00',
      'expiry_date': '2020-03-26T00:57:08.000+08:00',
      'number_washes': 2,
      'status': 'InActive',
      'redeem_code': 'REDEEM95',
      'member_pass': '1234567890',
      'payment_info': [
        {
          'transaction_date': '2020-03-26T00:57:08.000+08:00',
          'transaction_id': 'MLA-029312',
          'card_number': '411111111111',
          'card_name': 'Joseph',
          'card_expiry': '',
          'cvv': '143',
          'id': 3
        }
      ]
    },
  ];

  List activeWashList = [];
  List redeemWashList = [];

  RxInt selectedActiveWashIndex = 0.obs;
  RxInt selectedRedeemWashIndex = 0.obs;

  bool isRedeemWash = false;

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    activeWashList = fetchActiveWashList();
    redeemWashList = fetchRedeemWashList();

    super.onInit();
  }

  fetchActiveWashList() {
    return myWashList.where((i) => (i['status'] == 'Active')).toList();
  }

  fetchRedeemWashList() {
    return myWashList.where((i) => (i['status'] == 'Redeemed')).toList();
  }

  fetchCurrentMonth(date) {
    int transactionMonth = DateTime.parse(date).month;

    return transactionMonth;
  }

  getFormatedDate(date) {
    DateTime now = DateTime.parse(date);
    var format = DateFormat("MM/dd/yyyy - hh:mm a").format(now);
    return format;
  }

  getDateOnlyFormat(date) {
    DateTime now = DateTime.parse(date);
    var format = DateFormat("MMM dd, yyyy").format(now);
    return format;
  }

  calculateTotalAmount(String amount, String tax) {
    double amountInt = double.tryParse(amount) ?? 0;
    double taxInt = double.tryParse(tax) ?? 0;
    totalAmount = amountInt + taxInt;
    finalAmount = (amountInt + taxInt - fetchRedeemValue());
    return finalAmount.toStringAsFixed(2);
  }

  fetchRedeemValue() {
    double parseRedeemCode = 0.0;
    String redeemCodeValue = '39.99';
    parseRedeemCode = double.tryParse(redeemCodeValue) ?? 0;
    if (parseRedeemCode > totalAmount) {
      parseRedeemCode = totalAmount;
    }
    return parseRedeemCode;
  }
}
