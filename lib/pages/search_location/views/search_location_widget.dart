import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class SearchLocationWidget extends StatefulWidget {
  const SearchLocationWidget({super.key});

  @override
  State<SearchLocationWidget> createState() => _SearchLocationWidgetState();
}

class _SearchLocationWidgetState extends State<SearchLocationWidget> {
  var homeController = Get.find<HomeController>();

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
          future: homeController.readJson(),
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
                          controller: homeController.searchLocationController,
                          hintText: CoreAppConstants.searchHintLbl,
                          prefixIconData: const Icon(Icons.search,
                              color: AppColors.greyColor),
                          suffixIconData: const Icon(Icons.close),
                          onSuffixIconTap: () {
                            homeController.searchLocationController.clear();
                            homeController.searchData.clear();
                          },
                          onChangedInput: (value) => homeController
                              .searchLocation(data: snapshot.data!),
                        ),
                      ),
                      const Divider(
                        height: 0.5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => (homeController.searchData.isNotEmpty)
                            ? Expanded(
                                child: Container(
                                  color: AppColors.whiteColor,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: homeController.searchData.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          const Divider(
                                            height: 0.5,
                                          ),
                                          ListTile(
                                            onTap: () {
                                              homeController
                                                      .searchLocationController
                                                      .text =
                                                  "${homeController.searchData[index].name} , ${homeController.searchData[index].abbreviation}";
                                              homeController
                                                  .locationIndex(index);

                                              if (homeController
                                                  .isFromLocationsTab.value) {
                                                homeController.showAppBar(true);
                                                Get.offAndToNamed(
                                                    Routes.LOCATIONS);
                                              } else {
                                                Get.back();
                                              }
                                            },
                                            title: Text(
                                                "${homeController.searchData[index].name} , ${homeController.searchData[index].abbreviation}"),
                                          ),
                                          (index ==
                                                  homeController
                                                          .searchData.length -
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
                                  child: (homeController
                                          .searchLocationController
                                          .text
                                          .isNotEmpty)
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
                                                  .locationSearchErrorHintLbl),
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
