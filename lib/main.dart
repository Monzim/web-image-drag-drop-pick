import 'package:flutter/material.dart';
import 'package:web_image_drop_app/widgets/dropped_files.dart';

import 'widgets/droppedFile_widget.dart';
import 'widgets/dropzone_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFc5e3f6)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DroppedFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF7c203a),
        title: Text('Drag and Pick Image Web'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DroppedFileWidget(file: file),
            SizedBox(height: 16),
            Container(
              height: 300,
              width: 600,
              child: DropzoneWidget(
                onDroppedFile: (file) => setState(
                  () => this.file = file,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
