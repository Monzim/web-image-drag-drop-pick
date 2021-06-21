import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import 'dropped_files.dart';

class DropzoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppedFile;

  const DropzoneWidget({
    Key? key,
    required this.onDroppedFile,
  }) : super(key: key);

  @override
  _DropzoneWidgetState createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  bool isHighLighted = false;
  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    final colorButton =
        isHighLighted ? Colors.blue.shade300 : Color(0x5F22eaaa);

    return buildDecoration(
      child: Stack(
        children: [
          //! Dropzone
          DropzoneView(
            onCreated: (controller) => this.controller = controller,
            onHover: () => setState(() => isHighLighted = true),
            onLeave: () => setState(() => isHighLighted = false),
            onDrop: acceptFile,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.cloud_upload,
                  size: 80,
                  color: Colors.white,
                ),
                Text('Drop Files here',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 16.0),
                ElevatedButton.icon(
                  //!File Picker Button

                  onPressed: () async {
                    final events = await controller.pickFiles();
                    if (events.isEmpty) return;
                    acceptFile(events.first);
                  },

                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    primary: colorButton,
                    shape: RoundedRectangleBorder(),
                  ),
                  icon: Icon(
                    Icons.search,
                    size: 32,
                  ),
                  label: Text(
                    'Choose Files',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    print('Name:  $name');
    print('Mime:  $mime');
    print('Bytes:  $bytes');
    print('Url:  $url');

    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );

    widget.onDroppedFile(droppedFile);
    setState(() => isHighLighted = false);
  }

  Widget buildDecoration({required Widget child}) {
    final colorBackground = isHighLighted ? Colors.blue : Color(0xFF17b978);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: colorBackground,
        padding: EdgeInsets.all(10),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.white,
          strokeWidth: 3,
          padding: EdgeInsets.zero,
          dashPattern: [8, 4],
          radius: Radius.circular(10),
          child: child,
        ),
      ),
    );
  }
}
