import 'package:flutter/material.dart';
import 'package:web_image_drop_app/widgets/dropped_files.dart';

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile? file;
  const DroppedFileWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildImage(),
          if (file != null) buildFileDetails(file!),
        ],
      );

  Widget buildImage() {
    if (file == null) return buildEmptyFile('No file');
    return Image.network(
      file!.url,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
      errorBuilder: (context, error, _) => buildEmptyFile('No Preview'),
    );
  }

  Widget buildEmptyFile(String text) => Container(
        width: 300,
        height: 300,
        alignment: Alignment.center,
        color: Colors.blue.shade300,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      );

  Widget buildFileDetails(DroppedFile droppedFile) {
    final style = TextStyle(fontSize: 24);
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(file!.name, style: style.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(file!.mime, style: style.copyWith()),
          SizedBox(height: 8),
          Text(file!.size, style: style.copyWith()),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
