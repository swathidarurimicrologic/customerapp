import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionsController extends GetxController
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
      'purchase_date': '2020-10-02T00:57:08.000+08:00',
      'expiry_date': '2020-10-02T00:57:08.000+08:00',
      'number_washes': 2,
      'status': 'Active',
      'redeem_code': 'REDEEM55',
      'member_pass': '1234567890',
      'payment_info': [
        {
          'transaction_date': '2020-10-02T00:57:08.000+08:00',
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
          'transaction_date': '2020-10-26T00:57:08.000+08:00',
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
          'transaction_date': '2020-10-26T00:57:08.000+08:00',
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
          'transaction_date': '2020-09-26T00:57:08.000+08:00',
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

  List currentMonthWashList = [];
  List prevMonthWashList = [];

  RxInt selectedCurrentMonthWashIndex = 0.obs;
  RxInt selectedPrevMonthWashIndex = 0.obs;

  bool isCurrentMonthWash = false;

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    int currentMonth = DateTime.now().month;
    currentMonthWashList = fetchMonthWashList(currentMonth);
    prevMonthWashList = fetchMonthWashList(currentMonth - 1);

    super.onInit();
  }

  fetchMonthWashList(int compareMonth) {
    List currentMonthWashList = [];

    for (var i = 0; i < myWashList.length; i++) {
      List transactionList = myWashList[i]['payment_info'] as List;
      for (var j = 0; j < transactionList.length; j++) {
        var transactionMonth =
            fetchCurrentMonth(transactionList[j]['transaction_date']);
        if (compareMonth == transactionMonth) {
          currentMonthWashList.add(myWashList[i]);
        }
      }
    }
    return currentMonthWashList;
  }

  fetchPrevMonthWashList() {
    List currentMonthWashList = [];
    int currentMonth = DateTime.now().month - 1;

    for (var i = 0; i < myWashList.length; i++) {
      List transactionList = myWashList[i]['payment_info'] as List;
      for (var j = 0; j < transactionList.length; j++) {
        var transactionMonth =
            fetchCurrentMonth(transactionList[j]['transaction_date']);
        if (currentMonth == transactionMonth) {
          currentMonthWashList.add(myWashList[i]);
        }
      }
    }
    return currentMonthWashList;
  }

  fetchCurrentMonth(date) {
    int transactionMonth = DateTime.parse(date).month;

    return transactionMonth;
  }

  getFormatedDate(date) {
    DateTime now = DateTime.parse(date).toUtc();
    var suffix = "th";
    var digit = now.day % 10;
    if ((digit > 0 && digit < 4) && (now.day < 11 || now.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    var format = DateFormat("MMMM dd'$suffix', yyyy").format(now);
    return format;
  }

  getDateOnlyFormat(date) {
    DateTime now = DateTime.parse(date);
    var format = DateFormat("MMM dd, yyyy").format(now);
    return format;
  }

  calculateTotalAmount(String amount, String tax) {
    double amountInt = double.tryParse(amount) ?? 0.0;
    double taxInt = double.tryParse(tax) ?? 0.0;
    totalAmount = amountInt + taxInt;
    finalAmount = (amountInt + taxInt - fetchRedeemValue()).toDouble();
    return finalAmount.toStringAsPrecision(2);
  }

  fetchRedeemValue() {
    double parseRedeemCode = 0.0;
    String redeemCodeValue = '39.99';
    parseRedeemCode = double.tryParse(redeemCodeValue) ?? 0.0;
    if (parseRedeemCode > totalAmount) {
      parseRedeemCode = totalAmount;
    }
    return parseRedeemCode;
  }

  fetchLast4CharsOfCard(savedPaymentDetail) {
    var savedCard = savedPaymentDetail.toString();
    return savedCard.substring(savedCard.length - 4, savedCard.length);
  }
}
