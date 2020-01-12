import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:image_picker/image_picker.dart';
import 'focus_widget.dart';

void main2() => runApp(MyApp2());

class MyApp2 extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage2(),
    );
  }
}

class MyHomePage2 extends StatefulWidget{
  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2>{

  File _file;
  bool isImageLoaded = false ;
  File _image;
  String barcode ="";
  String ocrtext1 = "" ;
  String ocrtext2 = "" ;
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _file = image;
      isImageLoaded = true ;
    });
  }

  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    }on PlatformException catch(e){
    }
  }


  void ocr() async {
    try {
      File file = await showDialog(
        context: context,
        builder: (context) => Camera(
          mode: CameraMode.fullscreen,
          imageMask: FocusWidget(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      );
      Img.Image image = Img.decodeJpg(file.readAsBytesSync());
      var w = image.width;
      var h = image.height;
      var ww = w/7;
      var hh = h/4;
      var w1 = (ww*3).toInt();
      var w2 = ww.toInt();
      var h1 = hh.toInt();
      var h2 = (hh*2).toInt();
      Img.Image trimmed = Img.copyCrop(image, w1, h1, w2, h2);
      print(w1);
      print(w2);
      print(h1);
      print(h2);
      var time = DateTime.now().millisecondsSinceEpoch;
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File('$tempPath/$time.jpg').writeAsBytesSync(Img.encodeJpg(trimmed));
      File tmp = File('$tempPath/$time.jpg');

      if (tmp != null) {
        setState(() {
          _file = tmp;
          _image = tmp ;
          isImageLoaded = true;
        });
      }


      try {
        final FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(_file);
        final VisionText readText = await textRecognizer.processImage(ourImage);

        int c = 0 ;
        String a = '';
        String b = '';

        for (TextBlock block in readText.blocks) {
          for (TextLine line in block.lines) {
            print(line.text);
            if(a != '' && b == '' ){
              b = line.text;
            }
            if(c == 0){
              a = line.text;
              c =1;
            }
            setState(() {
              ocrtext1 = a;
              ocrtext2 = b;
            });
          }
        }
      }catch(e){
        print(e.toString());
      }

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('ocr test'),
      ),
      body: Column(
        children: <Widget>[

          isImageLoaded ? Center(
            child: Container(
              height: 154.8,
              width: 59.0,
              decoration: BoxDecoration(
                  image: DecorationImage(image: FileImage(_file),fit: BoxFit.fill)
              ),
            ),
          ): Container(),

          SizedBox(height: 10.0,),
          RaisedButton(
            child: Text('ocr scan'),
            onPressed: ocr,
          ),
          Text(ocrtext1),
          Text(ocrtext2),
          SizedBox(height: 10.0,),
          RaisedButton(
            child: Text('barcode scan'),
            onPressed: scan ,
          ),
          Text(barcode),
        ],
      ),
    );
  }
}