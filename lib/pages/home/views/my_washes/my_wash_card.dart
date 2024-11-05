import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class MyWashCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final Icon leading;
  final bool isActive;
  final VoidCallback onTap;
  const MyWashCard(
      {super.key,
      required this.title,
      required this.trailing,
      required this.subtitle,
      required this.leading,
      required this.isActive,
      required this.onTap});

  @override
  State<MyWashCard> createState() => _MyWashCardState();
}

class _MyWashCardState extends State<MyWashCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
            color: Get.theme.colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: widget.leading,
                title: Text(
                  widget.title,
                  style: Get.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(widget.subtitle,
                    style: Get.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400)),
                trailing: FittedBox(
                  child: Row(
                    children: [
                      Chip(
                        backgroundColor: widget.isActive
                            ? AppColors.greenColor
                            : AppColors.greyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // shadowColor: Colors.transparent,
                        side: BorderSide.none,
                        //CircleAvatar
                        label: Text(
                          widget.trailing,
                          style: Get.textTheme.bodySmall!
                              .copyWith(color: AppColors.whiteColor),
                        ), //Text
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
