import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/controllers/my_washes_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlreadyMemberController extends GetxController {
  final appStorage = Get.find<AppStorage>();
  final homeController = Get.find<HomeController>();
  final washesController = Get.find<MyWashesController>();

  final memberPassController = TextEditingController();
  final paymentController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String selectedCardValue = '';
  int currentGroupId = -1;
  RxBool isContinueBtnEnabled = false.obs;
  int prevGroupId = -1;
  bool isMembershipLinked = false;
  // ignore: prefer_typing_uninitialized_variables
  var selectedMembershipList;

  RxBool isUpdateBtnEnabled = false.obs;
  RxBool membershipCancelled = false.obs;

  RxInt selectedIndex = 100.obs;
  final dynamic nameSuffixIcon = const Icon(null).obs;

  List savedPaymentDetails = [
    {
      'card_number': '4315811189772110',
      'name_on_card': 'Joseph Amy',
      'exp_date': '12/26',
      'cvv': '843',
      'value': false,
      'id': 0
    },
    {
      'card_number': '4315811189733112',
      'name_on_card': 'Siddhu Amy',
      'exp_date': '12/29',
      'cvv': '143',
      'value': false,
      'id': 1
    },
  ];

  List cancellationReasonList = [
    'Moving/Inconvenient Location',
    'Program Too Expensive',
    'Quality of Wash/Service',
    'Reason Not Listed',
    'Vehicle No Longer in Use',
    'Not Washing Often Enough',
    'Seasonal Member'
  ];

  @override
  void onInit() {
    if (appStorage.fetchMembershipDetails() != null) {
      isMembershipLinked = true;
    }

    super.onInit();
  }

  void formatCardDetails(result) {
    var finalResult;
    if (result != null && result.isNotEmpty) {
      finalResult =
          "${CoreAppConstants.endingInLbl} ${result.toString().substring(result.toString().length - 4, result.toString().length)}";
      paymentController.text = finalResult;
    }
  }

  void updateCheckboxValues(int index, value) {
    savedPaymentDetails[index]["id"] = value;
    currentGroupId = value;
    selectedCardValue = CoreAppConstants.endingInLbl +
        fetchLast4CharsOfCard(savedPaymentDetails[index]['card_number']);
    update();
  }

  fetchLast4CharsOfCard(savedPaymentDetail) {
    var savedCard = savedPaymentDetail.toString();
    return savedCard.substring(savedCard.length - 4, savedCard.length);
  }

  filterActiveCancelMembershipList() {
    var filteredList = washesController.myWashList
        .where((i) => (i['status'] == 'Active' || i['status'] == 'Canceled'))
        .toList();
    print(filteredList);
    return filteredList;
  }

  void saveMembershipDetails(filteredList) {
    selectedMembershipList = filteredList;
    formatCardDetails(filteredList['payment_info'][0]['card_number']);
    print(paymentController.text);
    if (selectedMembershipList != null &&
        selectedMembershipList['status'] == 'Canceled') {
      membershipCancelled(true);
    } else {
      membershipCancelled(false);
    }
  }

  getDateOnlyFormat(date) {
    DateTime now = DateTime.parse(date);
    var format = DateFormat("MMM dd, yyyy").format(now);
    return format;
  }

  showOnValidName(dynamic suffixIcon, String? value) {
    isButtonEnabled();
    if (value!.trim().isNotEmpty) {
      suffixIcon(const Icon(Icons.check_circle, color: AppColors.greenColor));
    } else {
      suffixIcon(const Icon(null));
    }
    return suffixIcon.value;
  }

  dynamic isButtonEnabled() {
    if (nameController.text.isEmpty) {
      isUpdateBtnEnabled(false);
    } else {
      isUpdateBtnEnabled(true);
    }
    return null;
  }

  showAlert(String title, String content, String btnText) {
    CommonAlertDialog().successAlert(
        title: title,
        content: content,
        buttonText: btnText,
        onPressed: () {
          Get.back();

          Get.back();
          //TODO: Update name parameter
        });
  }

  showCancelAlert(String title, String content, String btnText) {
    CommonAlertDialog().successAlert(
        title: title,
        content: content,
        buttonText: btnText,
        onPressed: () {
          Get.back();
          Get.back();
          //TODO: Update name parameter
        });
  }

  showCancelMembershipAlert() {
    CommonAlertDialog().warningAlert(
        title: CoreAppConstants.cancelMembershipLbl,
        content: CoreAppConstants.cancelMembershipInfoLbl,
        positiveButtonText: CoreAppConstants.cancelMembershipYesLbl,
        negativeButtonText: CoreAppConstants.closeBtn,
        onPositiveBtnPressed: () {
          Get.back();
          Get.toNamed(Routes.CANCEL_MEMBERSHIP);
        },
        onNegativeBtnPressed: () {
          Get.back();
        });
  }
}
