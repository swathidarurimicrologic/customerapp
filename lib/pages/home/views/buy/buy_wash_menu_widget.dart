import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/views/buy/become_member/become_member_widget.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash/buy_wash_widget.dart';
import 'package:get/get.dart';

class BuyWashMenuWidget extends StatefulWidget {
  const BuyWashMenuWidget({super.key});

  @override
  State<BuyWashMenuWidget> createState() => _BuyWashMenuWidgetState();
}

class _BuyWashMenuWidgetState extends State<BuyWashMenuWidget> {
  var controller = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    print("current value");
    print(controller.selectedBuyWash.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SizedBox(
        height: Get.mediaQuery.size.height - 180,
        child: Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackgroundColor,
              border: const Border(
                bottom: BorderSide(
                  color: AppColors.disableColor,
                  width: 1.0,
                ),
                top: BorderSide(
                  color: AppColors.disableColor,
                  width: 1.0,
                ),
              ),
              image: DecorationImage(
                  image: AssetImage(
                      AppFlavor.assetPath + CoreAppConstants.backgroundImg),
                  fit: BoxFit.cover),
            ),
            child: Obx(
              () => controller.selectedBuyWash.value == 1
                  ? const BecomeMemberWidget()
                  : controller.selectedBuyWash.value == 2
                      ? const BuyWashWidget()
                      : const IgnorePointer(),
            ),
          ),
        ),
      ),
    );
  }
}
