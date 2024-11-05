import 'dart:io';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/pages/already_member/controllers/already_member_controller.dart';
import 'package:get/get.dart';

class EditNamePhone extends GetView<AlreadyMemberController> {
  const EditNamePhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(
          titleWidget: const Text(CoreAppConstants.editNameOrPhoneLbl),
          iconData: Icons.arrow_back_sharp,
          onAppBarMenuPressed: () => Get.back(), //TODO: change this to Get.back
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              child: CommonButton(
                onTap: () {
                  controller.showAlert(
                      CoreAppConstants.changesUpdatedLbl,
                      CoreAppConstants.changesUpdatedInfoLbl,
                      CoreAppConstants.continueBtn);
                },
                isEnabled: controller.isUpdateBtnEnabled.value ? true : false,
                text: CoreAppConstants.changeMembershipLbl,
              )),
        ),
        body: SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.scaffoldBackgroundColor,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.disableColor,
                      width: 1.0,
                    ),
                    top: BorderSide(
                      color: AppColors.disableColor,
                      width: 1.0,
                    ),
                  ),
                ),
                height: Platform.isIOS
                    ? MediaQuery.of(context).size.height - 230
                    : MediaQuery.of(context).size.height - 180,
                width: double.infinity,
                child: _nameWidget())));
  }

  Widget _nameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            CoreAppConstants.nameLbl,
            style: TextStyle(color: AppColors.darkGreyColor),
          ),
          const SizedBox(height: 5),
          Obx(
            () => CommonTextField(
              controller: controller.nameController,
              hintText: CoreAppConstants.nameLbl,
              prefixIconData: null,
              suffixIconData: controller.nameSuffixIcon.value,
              onSuffixIconTap: null,
              onChangedInput: (value) {
                controller.showOnValidName(controller.nameSuffixIcon, value);
              },
              errorText: CoreAppConstants.errorEmailTextLbl,
            ),
          ),
        ],
      ),
    );
  }
}
