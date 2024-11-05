import 'dart:async';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class BuyWashCheckOutController extends GetxController {
  GlobalKey<FormState> redeemCodeFormKey = GlobalKey<FormState>();

  TextEditingController paymentController = TextEditingController();
  TextEditingController redeemCodeController = TextEditingController();
  int currentGroupId = -1;
  int prevGroupId = -1;
  String selectedCardValue = '';
  double totalAmount = 0.0;
  double finalAmount = 0.0;
  bool redeemCodeVisible = false;
  RxBool isSendCodeEnabled = true.obs;
  RxBool isPayBtnEnabled = false.obs;

  late Timer timer;
  RxInt secondsRemaining = 60.obs;

  RxBool isRedeemCodeEnabled = false.obs;

  RxList savedPaymentDetails = [
    {
      'card_number': '4315811189772110',
      'name_on_card': 'Joseph Amy',
      'exp_date': '12/26',
      'cvv': '843',
      'value': false,
      'id': 0,
      'is_default': false
    },
    {
      'card_number': '4315811189733112',
      'name_on_card': 'Siddhu Amy',
      'exp_date': '12/29',
      'cvv': '143',
      'value': false,
      'id': 1,
      'is_default': true
    },
  ].obs;

  String? isScanQRPage;
  String? redeemCode;
  bool isUpdateMembership = false;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null) {
      isScanQRPage = arguments['page'];
    }
    if (arguments != null) {
      redeemCode = arguments['result'];
      if (redeemCode != null) {
        redeemCodeController.text = redeemCode!;
      }
    }
    if (arguments != null) {
      var status = arguments['status'];
      if (status != null) {
        isUpdateMembership = true;
      }
    }
    super.onInit();
  }

  calculateTotalAmount(String amount, String tax) {
    double amountInt = double.tryParse(amount) ?? 0.00;
    double taxInt = double.tryParse(tax) ?? 0.00;
    totalAmount = amountInt + taxInt;
    if (redeemCodeController.text.isNotEmpty) {
      finalAmount = (amountInt + taxInt - fetchRedeemValue()).toDouble();
    } else {
      finalAmount = (amountInt + taxInt).toDouble();
    }

    return "\$${finalAmount.toStringAsFixed(2)}";
  }

  fetchRedeemCode() {
    redeemCodeController.text = 'REDEEM55';
  }

  fetchRedeemCodeLast4Chars() {
    var value = redeemCodeController.text.toString().trim();
    return value.substring(value.length - 4, value.length);
  }

  fetchRedeemValue() {
    double parseRedeemCode = 0.0;
    String redeemCodeValue = '39.99';
    if (redeemCodeController.text.isNotEmpty) {
      parseRedeemCode = double.tryParse(redeemCodeValue) ?? 0.0;
      if (parseRedeemCode > totalAmount) {
        parseRedeemCode = totalAmount;
      }
    }
    return parseRedeemCode;
  }

  verifyCode() {
    if (redeemCodeFormKey.currentState!.validate()) {
      CommonAlertDialog().successAlert(
          title: CoreAppConstants.redeemCodeAcceptedLbl,
          content: CoreAppConstants.redeemCodeSuccessLbl,
          buttonText: CoreAppConstants.doneLbl,
          onPressed: () {
            Get.back();
            redeemCodeVisible = true;
            fetchRedeemCode();
            if (isScanQRPage == 'scan_qr') {
              Get.toNamed(Routes.SCAN_CHECKOUT,
                  arguments: {'result': 'REDEEM55'});
            } else {
              Get.back(result: 'REDEEM55');
            }
          });
    } else {
      CommonAlertDialog().errorAlert(
          title: CoreAppConstants.invalidPasscodeLbl,
          content: CoreAppConstants.invalidPasscodeDetailLbl,
          buttonText: CoreAppConstants.closeBtn,
          onPressed: () {
            Get.back();
          });
    }
  }

  fetchPaymentSelectedOptions(int index) {
    print(savedPaymentDetails[index]['is_selected']);
  }

  void updateCheckboxValues(int index, value) {
    savedPaymentDetails[index]["id"] = value;
    currentGroupId = value;
    selectedCardValue = CoreAppConstants.endingInLbl +
        fetchLast4CharsOfCard(savedPaymentDetails[index]);

    update();
  }

  void formatCardDetails(result) {
    String finalResult;
    if (result != null && result.isNotEmpty) {
      finalResult =
          "${CoreAppConstants.endingInLbl} ${result.toString().substring(result.toString().length - 4, result.toString().length)}";
      paymentController.text = finalResult;
    }
  }

  fetchLast4CharsOfCard(savedPaymentDetail) {
    var savedCard = savedPaymentDetail['card_number'].toString();
    return savedCard.substring(savedCard.length - 4, savedCard.length);
  }

  enableRedeemButton(value) {
    if (value.length == 5) {
      isRedeemCodeEnabled(true);
    } else {
      isRedeemCodeEnabled(false);
    }
  }

  validateCode(value) {
    return (value!.isNotEmpty && value == '12345') ? null : "";
  }

  showSendCodeDialog() {
    isSendCodeEnabled(false);
    showTimer();
    CommonAlertDialog().successAlert(
        title: CoreAppConstants.newCodeLbl,
        content: CoreAppConstants.newCodeDetailLbl,
        buttonText: CoreAppConstants.doneLbl,
        onPressed: () {
          Get.back();
        });
  }

  void showTimer() {
    secondsRemaining(60);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining--;
      } else {
        isSendCodeEnabled(true);
      }
    });
  }
}
