import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/login/controllers/login_controller.dart';
import 'package:get/get.dart';

class ContactDetailsWidget extends StatefulWidget {
  const ContactDetailsWidget({super.key});

  @override
  State<ContactDetailsWidget> createState() => _ContactDetailsWidgetState();
}

class _ContactDetailsWidgetState extends State<ContactDetailsWidget> {
  var controller = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    // homeController.searchLocationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        // resizeToAvoidBottomInset: true,
        appBar: CommonAppBar(
          titleWidget: const Text(CoreAppConstants.searchLocationLbl),
          iconData: Icons.arrow_back_sharp,
          onAppBarMenuPressed: () => Get.back(),
        ),
        body: FutureBuilder<List<dynamic>?>(
          future: controller.readJson(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Divider(
                        height: 1,
                      ),
                      Container(
                        height: 70,
                        color: AppColors.whiteColor,
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 12, right: 12),
                        child: CommonTextField(
                          autoFocus: true,
                          controller: controller.searchContactController,
                          hintText: CoreAppConstants.searchHintLbl,
                          prefixIconData: const Icon(Icons.search,
                              color: AppColors.greyColor),
                          suffixIconData: const Icon(Icons.close),
                          onSuffixIconTap: () {
                            controller.searchContactController.clear();
                            controller.phoneCodeController.clear();

                            // controller.countriesList.clear();
                          },
                          onChangedInput: (value) =>
                              controller.searchContact(data: snapshot.data!),
                        ),
                      ),
                      const Divider(
                        height: 0.5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => (controller.countriesList.isNotEmpty)
                            ? Expanded(
                                child: Container(
                                  color: AppColors.whiteColor,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.countriesList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          const Divider(
                                            height: 0.5,
                                          ),
                                          ListTile(
                                            onTap: () {
                                              controller.searchContactController
                                                      .text =
                                                  "${controller.countriesList[index].name}";
                                              controller.phoneCodeController
                                                      .text =
                                                  controller
                                                      .countriesList[index]
                                                      .dialCode;
                                              Get.back();
                                            },
                                            title: Text(
                                                "${controller.countriesList[index].name}"),
                                          ),
                                          (index ==
                                                  controller.countriesList
                                                          .length -
                                                      1)
                                              ? const Divider(
                                                  height: 0.5,
                                                )
                                              : const IgnorePointer()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: (controller.searchContactController
                                          .text.isNotEmpty)
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(AppFlavor
                                                    .defaultAssetPath +
                                                CoreAppConstants
                                                    .locationPinErrorSearchPath),
                                            const Flexible(
                                              child: Text(CoreAppConstants
                                                  .noContactFound),
                                            )
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                AppFlavor.defaultAssetPath +
                                                    CoreAppConstants
                                                        .locationPinSearchPath),
                                            const Flexible(
                                              child: Text(CoreAppConstants
                                                  .locationSearchHintLbl),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                      ),
                    ],
                  );
                }

              default:
                return const Text('Unhandle State');
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
