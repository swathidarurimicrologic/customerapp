import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:get/get.dart';
import '../app_configuration/app_required.dart';

class CommonListTile extends StatelessWidget {
  final Function()? onTap;
  final String titleText;
  final Text? subTitle;
  final String? trailingText;
  final String iconData;
  const CommonListTile(
      {super.key,
      required this.onTap,
      required this.titleText,
      this.subTitle,
      this.trailingText,
      required this.iconData});

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
              leading: Image.asset(AppFlavor.defaultAssetPath + iconData),
              title: Text(
                titleText,
                style: Get.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: (subTitle!),
              trailing: Text(trailingText!,
                  textAlign: TextAlign.start,
                  style: Get.textTheme.titleMedium!.copyWith(
                      color: Get.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold)),
            )),
      ),
    );
  }
}
