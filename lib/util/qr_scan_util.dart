import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
class QrScanUtil{


  static Future scan() async {
    try {
      String result = await BarcodeScanner.scan();
      print(result);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print('The user did not grant the camera permission!');
      } else {
        print('Unknown error: $e');
      }
    } on FormatException {
      print(
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      print('Unknown error: $e');
    }
  }
}