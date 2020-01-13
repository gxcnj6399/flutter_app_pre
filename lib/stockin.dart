import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dart:async';
import 'dart:io';
import 'OCR.dart';
import 'focus_widget.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DrugBank extends StatefulWidget{                                            ///進庫
  @override
  State<StatefulWidget> createState() {
    // 1TODO: implement createState
    return DrugBankState();
  }
}

class DrugBankState extends State<DrugBank>{                                      ///進庫
  TextEditingController resultInfo =  TextEditingController(text:"");
  TextEditingController resultNumber = TextEditingController(text:"");   //數量輸入框資料
  TextEditingController resultReceipt = TextEditingController(text:"");  //發票號碼輸入框資料
  TextEditingController resultPeriod = TextEditingController(text:"");   //效期輸入框資料
  TextEditingController resultLotNumber = TextEditingController(text:"");//批號輸入框資料
  double total = 0;
  bool flag = false;
  String choose = "國際條碼";
  File _file;
  bool isImageLoaded = false ;
  File _image;
  String barcode ="";
  String ocrtext1 = "" ;
  String ocrtext2 = "" ;
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

  @override

  void toast(){
    Fluttertoast.showToast(
        msg: "上傳成功!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      setState(() => this.resultInfo.text = barcode);
    }on PlatformException catch(e){
    }
  }

  Future scan2() async{
    try{
      String barcode = await BarcodeScanner.scan();
      setState(() => this.resultReceipt.text = barcode);
    }on PlatformException catch(e){
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _file = image;
      isImageLoaded = true ;
    });
  }


  void ocrPeriod() async {
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
      var ww = w/4;
      var hh = h/7;
      var w1 = (ww).toInt();
      var w2 = (ww*3).toInt();
      var h1 = (hh*3).toInt();
      var h2 = (hh*4).toInt();
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

            if(c == 0){
              a = line.text;
              c =1;
            }
            setState(() {
              resultPeriod.text = a;
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

  void ocrLotNumber() async {
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
      var ww = w/4;
      var hh = h/7;
      var w1 = (ww).toInt();
      var w2 = (ww*3).toInt();
      var h1 = (hh*3).toInt();
      var h2 = (hh*4).toInt();
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

            if(c == 0){
              a = line.text;
              c =1;
            }
            setState(() {
              resultLotNumber.text = a;
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

  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Center(child:
          Text("進庫資訊-掃描",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Switch(
            value: this.flag,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                this.flag = value;
              });
              if (value==false) {choose = "國際條碼";}
              else{choose ="院內碼";};
            },
          ),
          Text("模式:$choose",style: TextStyle(fontSize: 20.0,color:Colors.black ),),
          TextField(            controller: resultInfo,
            onEditingComplete: (){
              print(resultInfo.text);
            },
            decoration: InputDecoration(
                icon: Icon(Icons.desktop_windows),
                labelText: "輸入條碼",
                suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {});
                }
                ),
                suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){scan();})
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('DrugBank').where(choose,isEqualTo: resultInfo.text).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData) return Text("loading...");
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(), ///防止 Singlechildscrollview 與 listview 的捲動功能衝突 (兩個指令都有捲動畫面的功能)
                  children: snapshot.data.documents.map((DocumentSnapshot document){
                    var img = document["系統代碼"];
                    var image = "assets/images/$img.jpg";
                    var image2 = "assets/images/$img---2.jpg";
                    var imagelist=[
                      "assets/images/$img.jpg",
                      "assets/images/$img---2.jpg",
                      "assets/images/$img---3.jpg",
                    ];

                    void queryValues() {
                      Firestore.instance
                          .collection('DrugBank').document(document.documentID).collection('LotNumber')
                          .snapshots()
                          .listen((snapshot) {
                        double tempTotal = snapshot.documents.fold(0, (tot, doc) => tot + double.parse(doc.data['數量']));
                        setState(() {total = tempTotal;});
                      });
                    }

                    @override
                    initState() {
                      super.initState();
                      queryValues();
                    }
                    //queryValues();
                    return
                      ListTile(
                        title: null,
                        subtitle:
                        Column(children: <Widget>[
                          Container(
                            width: 250,
                            height: 250,
                            child: PhotoViewGallery.builder(
                              itemCount: imagelist.length,
                              builder: (context,index){
                                return PhotoViewGalleryPageOptions(
                                    imageProvider: AssetImage(
                                      imagelist[index],
                                    ),
                                    maxScale: PhotoViewComputedScale.covered * 2,
                                    minScale: PhotoViewComputedScale.contained * 1
                                );
                              },
                              scrollPhysics: BouncingScrollPhysics(),
                              loadingChild: Center(child: CircularProgressIndicator(),),
                            ),
                          ),
                          Center(child:Text(document["中文"],style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black),),),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "藥名:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document.documentID,
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "系統代碼:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["系統代碼"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "單位:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["健保單位"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "成份:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["成份"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

//                          Text.rich(
//                            TextSpan(
//                              children:[
//                                TextSpan(
//                                  text: "藥庫總數量:",
//                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
//                                ),
//                                TextSpan(
//                                  text: total.toString(),
//                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
//                                ),
//                              ],
//                            ),
//                          ),


                          TextField(
                            controller: resultReceipt,
                            onEditingComplete: (){
                              print(resultReceipt.text);
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.desktop_windows),
                              labelText: "發票號碼",
                              suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              }
                              ),
                              suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){
                                scan2();
                              }),
                            ),
                          ),

                          TextField(
                            controller: resultLotNumber,
                            onEditingComplete: (){
                              print(resultLotNumber.text);
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.desktop_windows),
                              labelText: "批號",
                              suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              }
                              ),
                              suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){ocrLotNumber();}),
                            ),
                          ),
                          TextField(
                            controller: resultPeriod,
                            onEditingComplete: (){
                              print(resultPeriod.text);
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.desktop_windows),
                              labelText: "效期",
                              suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              }
                              ),
                              suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){ocrPeriod();}),
                            ),
                          ),
                          TextField(
                            controller: resultNumber,
                            onEditingComplete: (){
                              print(resultNumber.text);
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.desktop_windows),
                              labelText: "輸入數量",
                              suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              }
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: Text("下一步"),
                            onPressed: (){
                              var route = new MaterialPageRoute(
                                builder:(BuildContext context) => DrugBankEdit(
                                  value: resultInfo.text,
                                  Number: resultNumber.text,
                                  LotNumber: resultLotNumber.text,
                                  Period: resultPeriod.text,
                                  Receipt: resultReceipt.text,
                                ), ///將資料傳遞到下一個畫面
                              );
                              Navigator.of(context).push(route);                                       ///切換到下個畫面
                            },
                          ),
                        ],),
                        //trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: (){}),
                      );
                  }).toList(),
                );
              }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("清除資料"),
                onPressed: (){
                  resultInfo.clear();
                  setState(() {});
                },
              ),
              RaisedButton(
                child: Text("返回主頁面"),
                onPressed: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
              ),
            ],),
        ],
        ),
      ),
    );
  }
}

class DrugBankEdit extends StatefulWidget {                                       ///進庫畫面2
  DrugBankEdit({Key key, this.value,this.Period,this.LotNumber,this.Receipt,this.Number}):super(key:key);
  String value;
  final Number;
  final Period;
  final LotNumber;
  final Receipt;


  @override
  _DrugBankEditState createState() => _DrugBankEditState();
}

class _DrugBankEditState extends State<DrugBankEdit> {
  DateTime now = DateTime.now();
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Center(child:Text("進庫資訊-確認",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orangeAccent,
        ),
        body:
        //Text("${widget.value}"),
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: widget.value).snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData) return Text("loading...");
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data.documents.map((DocumentSnapshot document){
                  DocumentReference dr = Firestore.instance.collection("DrugBank").document(document.documentID)
                      .collection("LotNumber")
                      .document(widget.LotNumber);

                  void toast(){
                    Fluttertoast.showToast(
                        msg: "上傳成功!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }

                  var img = document["系統代碼"];
                  var imgage = "assets/images/$img.jpg";
                  String formattedDate = DateFormat('yyyy-MM-DD').format(now);
                  String dateWithT = widget.Period.substring(0, 4) + '-' + widget.Period.substring(4);
                  String dateWithT2 = dateWithT.substring(0, 7) + '-' + dateWithT.substring(7);
                  DateTime dateTime = DateTime.parse(dateWithT2);
                  getdata() async {
                    final receiptcheck3 = await Firestore.instance
                        .collection('posts')
                        .document(document.documentID)
                        .collection("LotNumber")
                        .document(widget.LotNumber).get();
                    if (receiptcheck3 == null || !receiptcheck3.exists) {
                      Firestore.instance.collection("DrugBank").document(document.documentID)
                          .collection("LotNumber")
                          .document(widget.LotNumber)
                          .setData(
                        {"數量":widget.Number,
                          "發票條碼":widget.Receipt,
                          "效期":widget.Period,
                          "批號":widget.LotNumber,
                          "比較效期":dateTime,
                        },
                      );
                      Firestore.instance.collection("DrugBank").document(document.documentID)
                          .collection("LotNumber")
                          .document(widget.LotNumber)
                          .collection("user")
                          .document(formattedDate)
                          .setData(
                          {"操作人員":"1233",
                            "時間":now,
                            "操作":"進庫",
                            "數量":widget.Number,
                          }
                      );
                    }
                    else{
                      Firestore.instance.collection("DrugBank").document(document.documentID)
                          .collection("LotNumber")
                          .document(widget.LotNumber)
                          .updateData(
                        {"數量":widget.Number,
                          "發票條碼2":widget.Receipt,
                          "效期":widget.Period,
                          "批號":widget.LotNumber,
                          "比較效期":dateTime,
                        },
                      );
                      Firestore.instance.collection("DrugBank").document(document.documentID)
                          .collection("LotNumber")
                          .document(widget.LotNumber)
                          .collection("user")
                          .document(formattedDate)
                          .setData(
                          {"操作人員":"1233",
                            "時間":now,
                            "操作":"進庫",
                            "數量":widget.Number,
                          }
                      );
                    }
                  }
                  void queryValues() {
                    Firestore.instance
                        .collection('DrugBank').document(document.documentID).collection('LotNumber')
                        .snapshots()
                        .listen((snapshot) {
                      double tempTotal = snapshot.documents.fold(0, (tot, doc) => tot + double.parse(doc.data['數量']));
                      setState(() {total = tempTotal;});
                    });
                  }

                  @override
                  initState() {
                    super.initState();
                    queryValues();
                  }
                  //queryValues();
                  getdata();
                  return
                    ListTile(
                      title: null,
                      subtitle:
                      Column(children: <Widget>[
                        Image.asset(
                          imgage,
                          width: 250.0,
                          height: 250.0,
                        ),
                        Center(child:Text(document["中文"],style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black),),),
                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "藥名:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document.documentID,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "單位:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["健保單位"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "成份:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["成份"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "系統代碼:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["系統代碼"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

//                        Text.rich(
//                          TextSpan(
//                            children:[
//                              TextSpan(
//                                text: "藥庫總數量:",
//                                style: TextStyle(fontSize: 20.0,color: Colors.black),
//                              ),
//                              TextSpan(
//                                text: total.toString(),
//                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
//                              ),
//                            ],
//                          ),
//                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "發票號碼:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.Receipt,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "批號:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.LotNumber,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "效期:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.Period,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "數量:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.Number,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        RaisedButton(
                            child: Text("確認上傳"),                           ///上傳，預想發票條碼及批號每次皆不相同，所以上傳2是上傳的每筆資料皆以不同序號存放於資料庫，文件名稱為亂碼。
                            onPressed: (){
                              getdata();
                              toast();
                            }),

                        RaisedButton(
                            child: Text("返回進庫"),
                            onPressed: (){
                              Navigator.push(
                                context,
                                new MaterialPageRoute(builder: (context) => DrugBank()),
                              );
                            }),

                      ],),
                    );
                }).toList(),
              );
            }),
      ),
    );
  }
}
