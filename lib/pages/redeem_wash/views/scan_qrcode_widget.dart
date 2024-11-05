import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/redeem_wash/controllers/redeem_wash_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class ScanCodeWidget extends StatefulWidget {
  const ScanCodeWidget({super.key});

  @override
  State<ScanCodeWidget> createState() => _ScanCodeWidgetState();
}

class _ScanCodeWidgetState extends State<ScanCodeWidget> {
  String _scanBarcode = 'Unknown';
  var controller = Get.find<RedeemWashController>();
  var homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    scanQR();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.blackColor,
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.DEFAULT);
      print(barcodeScanRes);
      if (barcodeScanRes == "-1") {
        // CommonAlertDialog().errorAlert(
        //     title: CoreAppConstants.scanFailedLbl,
        //     content: CoreAppConstants.unableToScanLbl,
        //     buttonText: CoreAppConstants.closeBtn,
        //     onPressed: () {
        //       Get.back();
        //       scanQR();
        //     });
        Get.back();
      } else {
        CommonAlertDialog().successAlert(
            title: CoreAppConstants.scanSuccessLbl,
            content: CoreAppConstants.scanCodeSuccessLbl,
            buttonText: CoreAppConstants.doneLbl,
            onPressed: () {
              Get.back();
              if (homeController.currentNavPage == 'scan_code' ||
                  homeController.currentNavPage == 'my_wash') {
                Get.offAndToNamed(Routes.SCAN_CHECKOUT,
                    arguments: {'result': 'REDEEM55'});
              } else {
                Get.offAndToNamed(Routes.REDEEM_CODE,
                    arguments: {'page': 'scan_qr'});
              }
            });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}


// class SplashScreenView extends GetView<SplashScreenController> {
//   const SplashScreenView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DecoratedBox(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(AppConstants.splashImage), fit: BoxFit.cover),
//         ),
//         child: Container(),
//       ),
//     );
//   }
// }
