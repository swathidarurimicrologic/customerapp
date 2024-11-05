import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  GlobalKey<FormState> addCreditCardInfoFormKey = GlobalKey<FormState>();

  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  RxBool isAddCardEnabled = false.obs;

  List savedPaymentDetails = [
    {
      'card_number': '4315811189772110',
      'name_on_card': 'Joseph Amy',
      'exp_date': '12/26',
      'cvv': '843',
      'value': false,
      'id': 0,
      'status': 'Active'
    },
    {
      'card_number': '4315811189733112',
      'name_on_card': 'Siddhu Amy',
      'exp_date': '12/29',
      'cvv': '143',
      'value': false,
      'id': 1,
      'status': 'InActive'
    },
  ];

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
      }
    });
    return null;
  }

  onAddCardClicked() {
    Get.back(result: cardNumberController.text);
  }

  fetchLast4CharsOfCard(savedPaymentDetail) {
    var savedCard = savedPaymentDetail.toString();
    return savedCard.substring(savedCard.length - 4, savedCard.length);
  }
}
