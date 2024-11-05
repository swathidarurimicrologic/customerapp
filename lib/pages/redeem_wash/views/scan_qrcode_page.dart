import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/redeem_wash/controllers/redeem_wash_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
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
        //       Get.back();
        //     });
        Get.back();
      } else {
        CommonAlertDialog().successAlert(
            title: CoreAppConstants.scanSuccessLbl,
            content: CoreAppConstants.scanCodeSuccessLbl,
            buttonText: CoreAppConstants.doneLbl,
            onPressed: () {
              Get.back();
              if (homeController.currentNavPage == 'my_wash') {
                Get.offAndToNamed(Routes.SCAN_CHECKOUT,
                    arguments: {'result': 'REDEEM55'});
              } else if (homeController.currentNavPage == 'scan_code') {
                Get.offAndToNamed(Routes.SCAN_CHECKOUT);
              } else if (homeController.currentNavPage == 'already_member') {
                Get.back(result: '9800655556');
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
