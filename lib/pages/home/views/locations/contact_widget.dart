import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ContactWidget extends StatelessWidget {
  var controller = Get.find<HomeController>();
  ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                leading: Icon(
                  Icons.access_time_filled_outlined,
                  color: Get.theme.colorScheme.primary,
                ),
                title: const Text("Open 9:00 AM - 7:00 PM"),
                subtitle: const Text("Tuesday to Sunday, Closed Monday")),
            ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    onPressed: () async {
                      await controller.launchCall(phoneNumber: "9243356688");
                    },
                    icon: Icon(
                      Icons.call,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ),
                title: const Text(
                  "(209) 519 4454",
                )),
          ],
        ),
      ),
    );
  }
}
