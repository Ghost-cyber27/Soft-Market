import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soft_market/constant/key.dart';

class MakePayment {
  MakePayment(
      {required this.context,
      required this.price,
      required this.email,
      required this.file});

  BuildContext context;

  int price;

  String email;

  String file;

  PaystackPlugin paystack = PaystackPlugin();

  Dio dio = Dio();
  double progree = 0.0;

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'IOS';
    } else {
      platform = 'Andriod';
    }
    return 'Charged from $platform _${DateTime.now().microsecondsSinceEpoch}';
  }

  PaymentCard getCardUI() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin() async {
    await paystack.initialize(publicKey: ConstantKey.paystackKey);
  }

  chargeCardandMakePayment(String network) async {
    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..reference = _getReference()
        ..card = getCardUI();
      CheckoutResponse response = await paystack.checkout(
        context,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: false,
        logo: Image.asset("asset/images/softmarket.png", height: 30),
      );

      if (response.status == true) {
        download();
        /*showDialog(
            context: context,
            builder: (context) => DownloadingDialog(fileNamePath: file));*/
      } else {
        _alertDialogBuilder('Transaction failed');
      }
    });
  }

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(error),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close Dialog"))
            ],
          );
        });
  }

  void download() async {
    final statues = await Permission.storage.request();
    if (statues.isGranted) {
      final externalDir = await getExternalStorageDirectory();

      FlutterDownloader.enqueue(
          url: file,
          savedDir: externalDir!.path,
          fileName: 'download',
          showNotification: true,
          openFileFromNotification: true);
    } else {}
  }
}
