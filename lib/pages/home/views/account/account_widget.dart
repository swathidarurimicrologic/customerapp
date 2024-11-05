import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key});

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !homeController.hideAccountAppBar.value
          ? Scaffold(
              appBar: CommonAppBar(
                  titleWidget: const Text(CoreAppConstants.accountLbl),
                  iconData: Icons.arrow_back_sharp,
                  onAppBarMenuPressed: () {
                    homeController.hideAccountAppBar(true);
                    Get.back();
                  }),
              body: Container(
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
                  child: _bodyWidget()))
          : Scaffold(body: _bodyWidget()),
    );
  }

  _bodyWidget() {
    return homeController.alreadyMember
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: ListView(
                children: [
                  Container(
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
                    child: ListTile(
                      onTap: () {
                        homeController.hideAppBar(true);
                        Get.toNamed(Routes.PROFILE);
                      },
                      title: Text(
                        CoreAppConstants.profileLbl,
                        style: Get.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.scaffoldBackgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.disableColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        homeController.hideAppBar(true);
                        Get.toNamed(Routes.UPDATE_PHONE_NUMBER);
                      },
                      title: Text(CoreAppConstants.updatePhoneNumberLbl,
                          style: Get.textTheme.titleMedium),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.scaffoldBackgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.disableColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () => Get.toNamed(Routes.ALREADY_MEMBER),
                      title: Text(CoreAppConstants.manageMembershipLbl,
                          style: Get.textTheme.titleMedium),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.scaffoldBackgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.disableColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(Routes.PAYMENT_METHOD);
                      },
                      title: Text(CoreAppConstants.paymentMethodsLbl,
                          style: Get.textTheme.titleMedium),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.scaffoldBackgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.disableColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () => Get.toNamed(Routes.TRANSACTIONS),
                      title: Text(
                        CoreAppConstants.transactionsLbl,
                        style: Get.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.scaffoldBackgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.disableColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.offAllNamed(Routes.SPLASH,
                            arguments: {'is_from_account_tab': true});
                      },
                      title: Text(
                        CoreAppConstants.logoutLbl,
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: AppColors.errorColor),
                      ),
                    ),
                  )
                ],
              )),
            ],
          )
        : Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.scaffoldBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.disableColor,
                  width: 1.0,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                    AppFlavor.defaultAssetPath + CoreAppConstants.washIcon,
                    width: 60,
                    height: 60),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(CoreAppConstants.accessAccountLbl,
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: CommonButton(
                    onTap: () {
                      homeController.hideAppBar(false);
                      Get.toNamed(Routes.LOGIN);
                    },
                    isEnabled: true,
                    text: CoreAppConstants.loginSignupLbl,
                  ),
                ),
              ],
            ),
          );
  }
}
