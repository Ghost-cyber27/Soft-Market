// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:soft_market/payment/download_dialog.dart';

class DisplayDialog extends StatefulWidget {
  final DownloadingDialog down;
  const DisplayDialog({Key? key, required this.down}) : super(key: key);

  @override
  State<DisplayDialog> createState() => _DisplayDialogState();
}

class _DisplayDialogState extends State<DisplayDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator.adaptive(),
          SizedBox(
            height: 20,
          ),
          Text(
            "Downloading%",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
