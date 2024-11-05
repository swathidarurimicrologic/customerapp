import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/search_location/providers/search_location_model.dart';
import 'package:get/get.dart';

class NearbyLocationsWidget extends StatefulWidget {
  final String titleText;
  final String subtitleText;
  final bool isFavorite;
  final String address;
  final List<String> filterTags;
  final String status;
  final LocationDetail locationPath;
  final bool fromFavTab;
  final dynamic onWidgetSelected;

  const NearbyLocationsWidget(
      {super.key,
      required this.titleText,
      required this.subtitleText,
      required this.isFavorite,
      required this.address,
      required this.filterTags,
      required this.status,
      required this.locationPath,
      this.fromFavTab = false,
      required this.onWidgetSelected});

  @override
  State<NearbyLocationsWidget> createState() => _NearbyLocationsWidgetState();
}

class _NearbyLocationsWidgetState extends State<NearbyLocationsWidget> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onWidgetSelected,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  // horizontalTitleGap: 0,
                  leading: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: (widget.locationPath.isFavorite)
                            ? Get.theme.colorScheme.primary
                            : AppColors.disableColor,
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5)), // radius as you wish
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.star,
                        color: (widget.locationPath.isFavorite)
                            ? Get.theme.colorScheme.primary
                            : AppColors.disableColor,
                      ),
                      onPressed: () {
                        if (!widget.fromFavTab) {
                          if (widget.locationPath.isFavorite) {
                            widget.locationPath.isFavorite = false;
                          } else {
                            widget.locationPath.isFavorite = true;
                          }
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  title: Text(widget.titleText,
                      style: Get.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Get.theme.colorScheme.primary)),
                  subtitle: Text("${widget.subtitleText} miles away",
                      style: Get.textTheme.bodyMedium),
                  trailing: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: buildLocationStatus(widget.status)),
                ),
                const SizedBox(
                  height: 5,
                ),
                buildUserAddress(widget.address),
                const SizedBox(
                  height: 5,
                ),
                widget.filterTags.isNotEmpty
                    ? Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.chipColor,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(widget.filterTags.first,
                                    style: Get.textTheme.bodySmall),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.chipColor,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(widget.filterTags.last,
                                      style: Get.textTheme.bodySmall),
                                )),
                          ),
                        ],
                      )
                    : const IgnorePointer()
              ],
            ),
          ),
          const Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  Widget buildUserAddress(String address) {
    int firstAddressIndex = address.toString().indexOf(",");
    var addressLine1 = address.substring(0, firstAddressIndex);
    var addressLine2 =
        address.substring(firstAddressIndex + 1, address.length - 1).trim();
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(addressLine1, style: Get.textTheme.bodySmall),
          Text(addressLine2, style: Get.textTheme.bodySmall)
        ]);
  }

  Widget buildLocationStatus(String status) {
    var statusList = status.toString().split(",");

    return SizedBox(
      width: 150,
      height: 100,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Chip(
                backgroundColor: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                // shadowColor: Colors.transparent,
                side: BorderSide.none,
                //CircleAvatar
                label: Text(
                  statusList.first.trim(),
                  style: Get.textTheme.bodySmall!
                      .copyWith(color: AppColors.whiteColor),
                ), //Text
              ),
            ), //Ch
            // CommonButton(
            //     text: statusList.first.trim(),
            //     onTap: null,
            //     btnStyle: Get.theme.elevatedButtonTheme.style!.copyWith(
            //         backgroundColor:
            //             WidgetStateProperty.all<Color>(AppColors.greenColor))
            //             ),
            Text(statusList.last.trim(), style: Get.textTheme.bodySmall)
          ]),
    );
  }
}
