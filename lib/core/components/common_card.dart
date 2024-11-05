import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:get/get.dart';
import '../app_configuration/app_required.dart';

class CommonCard extends StatelessWidget {
  final Function()? onTap;
  final String titleText;
  final String? iconData;
  const CommonCard(
      {super.key, required this.onTap, required this.titleText, this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: (iconData != null)
                ? Image.asset(AppFlavor.defaultAssetPath + iconData!)
                : const IgnorePointer(),
            title: Text(
              titleText,
              style: Get.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
