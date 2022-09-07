import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadingDialog extends StatefulWidget {
  final String fileNamePath;
  const DownloadingDialog({Key? key, required this.fileNamePath})
      : super(key: key);

  @override
  State<DownloadingDialog> createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progree = 0.0;

  startDownloading(String network) async {
    String uRL = network;

    String fileName = "french.zip";

    String path = await getFilePath(fileName);

    await dio.download(
      uRL,
      path,
      onReceiveProgress: ((receivedBytes, totalBytes) {
        setState(() {
          progree = receivedBytes / totalBytes;
        });
      }),
      deleteOnError: true,
    ).then((value) {
      Navigator.pop(context);
    });
  }

  Future<String> getFilePath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$fileName";
  }

  @override
  void initState() {
    super.initState();
    startDownloading(widget.fileNamePath);
  }

  @override
  Widget build(BuildContext context) {
    String downloadProgress = (progree * 100).toInt().toString();
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading $downloadProgress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
