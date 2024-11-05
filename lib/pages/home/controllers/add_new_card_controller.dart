import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/pages/home/controllers/buy_wash_checkout_controller.dart';
import 'package:get/get.dart';

class AddNewCardController extends GetxController {
  GlobalKey<FormState> addCreditCardInfoFormKey = GlobalKey<FormState>();

  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  RxBool isAddCardEnabled = false.obs;
  RxBool isDefaultSelected = false.obs;

  bool isEditCard = false;
  var buyWashCheckOutController = Get.find<BuyWashCheckOutController>();

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null) {
      var cardInfo = Get.arguments['card_details'];
      if (cardInfo != null) {
        cardNameController.text = cardInfo['name_on_card'];
        cardNumberController.text =
            formatCardInfo(cardInfo['card_number'].toString());
        cardExpiryController.text = cardInfo['exp_date'];
        cvvController.text = cardInfo['cvv'];
        isAddCardEnabled(true);
        isEditCard = true;
      }
    }
    super.onInit();
  }

  formatCardInfo(number) {
    // String number = "1234123412341234";
    number =
        "${number.substring(0, 4)} ${number.substring(4, 8)} ${number.substring(8, 12)} ${number.substring(12, number.length)}";
    return number;
  }

  dynamic isButtonEnabled() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((cardNameController.text.isEmpty ||
              cardNumberController.text.isEmpty ||
              cardExpiryController.text.isEmpty) ||
          (addCreditCardInfoFormKey.currentState != null &&
              !addCreditCardInfoFormKey.currentState!.validate())) {
        isAddCardEnabled(false);
      } else {
        isAddCardEnabled(true);
        update();
      }
    });
    return null;
  }

  onAddCardClicked() {
    int id = buyWashCheckOutController.savedPaymentDetails.length;
    buyWashCheckOutController.savedPaymentDetails.add({
      'card_number': cardNumberController.text,
      'name_on_card': cardNameController.text,
      'exp_date': cardExpiryController.text,
      'cvv': cvvController.text,
      'value': false,
      'id': id,
      'is_default': isDefaultSelected.value
    });
    buyWashCheckOutController.updateCheckboxValues(
        buyWashCheckOutController.savedPaymentDetails.length - 1, id);
    // update();
    Get.back(result: cardNumberController.text);
  }
}
