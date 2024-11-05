import 'dart:async';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_check_box.dart';
import 'package:customer_app/pages/home/views/locations/nearby_locations_widget.dart';
import 'package:customer_app/pages/search_location/providers/search_location_model.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class LocationsWidget extends StatefulWidget {
  const LocationsWidget({super.key});

  @override
  State<LocationsWidget> createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget>
    with SingleTickerProviderStateMixin {
  var homeController = Get.find<HomeController>();
  TabController? tabController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 9.4746,
  );

  static const _verona = LatLng(37.42796133580664, -122.085749655962);
  static const _verona2 = LatLng(37.92796133580664, -123.085749655962);

  final Marker marker1 = const Marker(
      markerId: MarkerId('verona'),
      position: _verona,
      infoWindow: InfoWindow(title: 'Verona'));
  final Marker marker2 = const Marker(
      markerId: MarkerId('verona1'),
      position: _verona2,
      infoWindow: InfoWindow(title: 'Verona'));

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        (homeController.showAppBar.value || homeController.isFromMenubar.value)
            ? Scaffold(
                appBar: CommonAppBar(
                    titleWidget: const Text(CoreAppConstants.locationsLbl),
                    iconData: Icons.arrow_back_sharp,
                    onAppBarMenuPressed: () {
                      homeController.isFromMenubar(false);
                      homeController.showAppBar(false);

                      Get.back();
                    } //TODO: change this to Get.back
                    ),
                body: _bodyWidget())
            : Scaffold(
                body: _bodyWidget(),
              ));
  }

  showFilters() {
    return CommonBottomSheet.showBottomSheet(
        isDismissible: true,
        widgetBody: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            Center(
                child: Text(
              CoreAppConstants.filterLbl,
              style: Get.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            )),
            const SizedBox(height: 10),
            GetBuilder<HomeController>(
              builder: (controller) => ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeController.filterList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: CommonCheckbox(
                        onCheckboxValueChanged: (value) {
                          homeController.updateCheckBoxValues(index, value);
                        },
                        text: homeController.filterList[index]['title']
                            .toString(),
                        checkedValue: homeController.filterList[index]
                            ['isChecked']),
                  );
                },
              ),
            ),
            const Divider(
              height: 10,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: CommonButton(
                  onTap: () {
                    Get.back();
                    homeController.applyFilters();
                  },
                  isEnabled: true,
                  text: CoreAppConstants.applyFiltersLbl),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                    alignment: Alignment.center,
                    child: Text(CoreAppConstants.closeBtn,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: Get.theme.colorScheme.primary))),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  Widget _tabBarWidget() {
    List<LocationDetail> selectedLocation;

    if (homeController.searchData.isNotEmpty) {
      selectedLocation = homeController
          .searchData[homeController.locationIndex.value].locationDetails;

      return Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Get.theme.colorScheme.primary,
              tabs: const [
                Tab(
                  text: CoreAppConstants.nearByLbl,
                ),
                Tab(
                  text: CoreAppConstants.favoritesLbl,
                ),
              ],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            homeController.searchData.isNotEmpty
                ? Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        selectedLocation.isNotEmpty
                            ? ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: selectedLocation.length,
                                itemBuilder: (context, index) {
                                  return NearbyLocationsWidget(
                                    onWidgetSelected: () {
                                      homeController.selectedLocation =
                                          selectedLocation[index];

                                      if (homeController
                                          .isFromLocationsTab.value) {
                                        Get.back();
                                      } else {
                                        Get.toNamed(Routes.LOCATION_DETAIL);
                                      }
                                    },
                                    locationPath: selectedLocation[index],
                                    titleText:
                                        selectedLocation[index].locationName,
                                    address: selectedLocation[index].address,
                                    isFavorite: homeController.getIsFavorite(
                                        selectedLocation[index].isFavorite),
                                    subtitleText:
                                        selectedLocation[index].distance,
                                    filterTags: homeController
                                        .getFilterTags('Exterior, Interior'),
                                    status: 'Open, Closes 8:00 PM',
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No stores near me'),
                              ),
                        ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: selectedLocation.length,
                          itemBuilder: (context, index) {
                            if (selectedLocation[index].isFavorite) {
                              return NearbyLocationsWidget(
                                onWidgetSelected: () {
                                  homeController.selectedLocation =
                                      selectedLocation[index];
                                  if (homeController.isFromLocationsTab.value) {
                                    Get.back();
                                  } else {
                                    Get.toNamed(Routes.LOCATION_DETAIL);
                                  }
                                },
                                fromFavTab: true,
                                locationPath: selectedLocation[index],
                                titleText: selectedLocation[index].locationName,
                                address: selectedLocation[index].address,
                                isFavorite: homeController.getIsFavorite(
                                    selectedLocation[index].isFavorite),
                                subtitleText: selectedLocation[index].distance,
                                filterTags: homeController
                                    .getFilterTags('Exterior, Interior'),
                                status: 'Open, Closes 8:00 PM',
                              );
                            } else {
                              return const IgnorePointer();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                : TabBarView(controller: tabController, children: [
                    selectedLocation.isEmpty
                        ? const Text("hfhf fhffhg hfgh hfg")
                        : const IgnorePointer()
                  ]),
          ],
        ),
      );
    }
    return const IgnorePointer();
  }

  _mapsWidget() {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: false,
        onCameraMove: (CameraPosition cameraPosition) {
          print(cameraPosition.zoom);
        },
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: {marker1, marker2},
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) _controller.complete(controller);
        },
      ),
    );
  }

  _bodyWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.disableColor,
            width: 1.0,
          ),
        ),
      ),
      child: FutureBuilder<List<dynamic>?>(
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
                return ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: Get.mediaQuery.size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Expanded(
                          //   flex: 1,
                          Column(
                            children: [
                              const Divider(
                                height: 1,
                              ),
                              Container(
                                height: 70,
                                color: AppColors.whiteColor,
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 12, right: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          homeController
                                              .isFromLocationsTab(false);
                                          Get.toNamed(Routes.SEARCH_LOCATION);
                                        },
                                        child: CommonTextField(
                                          controller: homeController
                                              .searchLocationController,
                                          hintText:
                                              CoreAppConstants.searchHintLbl,
                                          prefixIconData: const Icon(
                                              Icons.search,
                                              color: AppColors.greyColor),
                                          isEnabled: false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: Get.theme.colorScheme.primary,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          )),
                                      child: IconButton(
                                          onPressed: () => showFilters(),
                                          icon: const Icon(
                                            Icons.filter_list,
                                            color: AppColors.whiteColor,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0.5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          // ),
                          _mapsWidget(),
                          Obx(() => _tabBarWidget())
                        ],
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
      ),
    );
  }
}
