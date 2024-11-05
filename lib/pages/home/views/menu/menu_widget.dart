import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/core/components/common_card.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  var homeController = Get.find<HomeController>();
  var appStorage = Get.find<AppStorage>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          homeController.fetchNearbyLocationWidget(),
          homeController.alreadyMember
              ? Container(
                  color: AppColors.primaryColor,
                  padding: const EdgeInsets.all(4),
                  width: double.infinity,
                  child: Text(
                    "${CoreAppConstants.welcomeBackLbl} ${appStorage.getUserData()['name']}",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyMedium!
                        .copyWith(color: AppColors.whiteColor),
                  ))
              : const IgnorePointer(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: [
                CommonCard(
                  titleText: CoreAppConstants.unlimitedWashLbl,
                  iconData: CoreAppConstants.rotateSquareImgPath,
                  onTap: () => {joinUnlimited()},
                ),
                const SizedBox(height: 10),
                CommonCard(
                  titleText: homeController.alreadyMember
                      ? CoreAppConstants.manageMembershipLbl
                      : CoreAppConstants.alreadyMemberLbl,
                  iconData: CoreAppConstants.userSquareImgPath,
                  onTap: () => {memberLogin()},
                ),
                const SizedBox(height: 10),
                CommonCard(
                  titleText: CoreAppConstants.buyWashLbl,
                  iconData: CoreAppConstants.buyWashImgPath,
                  onTap: () {
                    homeController.hideAppBar(false);
                    buyWash();
                  },
                ),
                const SizedBox(height: 10),
                CommonCard(
                  titleText: CoreAppConstants.scanCodeLbl,
                  iconData: CoreAppConstants.scanCodeImgPath,
                  onTap: () {
                    if (homeController.alreadyMember) {
                      scanCode();
                    } else {
                      memberLogin();
                    }
                  },
                ),
                const SizedBox(height: 10),
                CommonCard(
                    titleText: CoreAppConstants.redeemCodeLbl,
                    iconData: CoreAppConstants.redeemCodeImgPath,
                    onTap: () {
                      if (homeController.alreadyMember) {
                        redeemCode();
                      } else {
                        memberLogin();
                      }
                    }),
                // homeController.alreadyMember
                //     ? premiumMemberWidget()
                //     : const IgnorePointer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  joinUnlimited() {
    homeController.hideAppBar(false);
    Get.toNamed(Routes.BECOME_MEMBER);
  }

  memberLogin() {
    if (homeController.alreadyMember) {
      Get.toNamed(Routes.ALREADY_MEMBER);
    } else {
      Get.toNamed(Routes.LOGIN);
    }
  }

  redeemCode() {
    homeController.currentNavPage = ('redeem_wash');
    Get.toNamed(Routes.REDEEM_WASH);
  }

  scanCode() {
    homeController.currentNavPage = 'scan_code';
    Get.toNamed(Routes.REDEEM_WASH, arguments: {'nav_screen': 'scan_code'});
  }

  buyWash() {
    Get.toNamed(Routes.BUY_WASH);
  }

  // premiumMemberWidget() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const SizedBox(height: 20),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Text(CoreAppConstants.myMembershipsLbl,
  //             style: Get.textTheme.titleMedium),
  //       ),
  //       const SizedBox(height: 10),
  //       CommonListTile(
  //         titleText: 'Platinum Full Service',
  //         subTitle: Text('Active'),
  //         trailingText: CoreAppConstants.manageLbl,
  //         iconData: CoreAppConstants.rotateSquareImgPath,
  //         onTap: () => {redeemCode()},
  //       ),
  //     ],
  //   );
  // }
}
