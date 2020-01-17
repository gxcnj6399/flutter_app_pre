import 'package:flutter/material.dart';
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

class DrugBankDrugReturn extends StatefulWidget {
  @override
  _DrugBankDrugReturnState createState() => _DrugBankDrugReturnState();
}

class _DrugBankDrugReturnState extends State<DrugBankDrugReturn> {
  TextEditingController resultInfoDrugReturn =  TextEditingController(text:"");
  TextEditingController resultNumber = TextEditingController(text:"");
  TextEditingController resultLotNumber = TextEditingController(text:"");
  TextEditingController resultReason = TextEditingController(text:"");
  double total = 0;
  String lotnumber = "";
  bool flag = false;
  String choose = "國際條碼";
  var _littledrugbank = ["請選擇","小庫1","小庫2","小庫3"];
  var _currentItemSelected = "請選擇";
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

  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      setState(() => this.resultInfoDrugReturn.text = barcode);
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(title: Center(child:
      Text("客戶退藥資訊-掃描",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
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
          TextField(
            controller: resultInfoDrugReturn,
            onEditingComplete: (){
              print(resultInfoDrugReturn.text);
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
              stream: Firestore.instance.collection('DrugBank').where(choose,isEqualTo: resultInfoDrugReturn.text).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData) return Text("loading...");
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.documents.map((DocumentSnapshot document){
                    var img = document["系統代碼"];
                    var imgage = "assets/images/$img.jpg";
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("退藥小庫:",style: TextStyle(fontSize: 22.0,color: Colors.black),),
                              DropdownButton<String>(
                                items: _littledrugbank.map((String dropDownStringItem){
                                  return DropdownMenuItem<String>(
                                    value:dropDownStringItem,
                                    child: Text(dropDownStringItem,style: TextStyle(fontSize: 22.0,color: Colors.indigo),),
                                  );
                                }).toList(),

                                onChanged: (String newValueSelected){
                                  setState(() {
                                    this._currentItemSelected = newValueSelected;
                                  });
                                },
                                value: _currentItemSelected,
                              ),
                            ],),

                          TextField(
                            controller: resultLotNumber,
                            onEditingComplete: (){
                              print(resultLotNumber.text);
                            },
                            decoration: InputDecoration(
                              labelText: "批號:",
                              suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              }
                              ),
                              suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){ocrLotNumber();}),
                            ),
                          ),

                          TextField(
                            controller: resultNumber,
                            keyboardType: TextInputType.numberWithOptions(),
                            onEditingComplete: (){
                              print(resultNumber.text);
                            },
                            decoration: InputDecoration(
                              labelText: "輸入數量",
                              suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              }
                              ),
                            ),
                          ),

                          Text("退藥說明:",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                            TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              controller: resultReason,
                              onEditingComplete: (){
                                print(resultReason.text);
                              },
                              decoration: InputDecoration(
                                labelText: "輸入退藥原因",
                                fillColor: Colors.teal.shade50, filled: true,
                                suffix: IconButton(icon: Icon(Icons.clear), onPressed:() {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                }
                                ),
                              ),
                            ),


                          RaisedButton(
                            child: Text("下一步"),
                            onPressed: (){
                              var route = new MaterialPageRoute(
                                builder:(BuildContext context) => DrugBankDrugReturnEdit(
                                  value:resultInfoDrugReturn.text,
                                  Number: resultNumber.text,
                                  LotNumber: resultLotNumber.text,
                                  littledrugbank: _currentItemSelected,
                                  Reason:resultReason.text,
                                ), ///將資料傳遞到下一個畫面
                              );
                              Navigator.of(context).push(route);                                       ///切換到下個畫面
                            },
                          ),
                        ],), //trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: (){}),
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
                  resultInfoDrugReturn.clear();
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

class DrugBankDrugReturnEdit extends StatefulWidget {                                       ///病人退藥畫面2
  DrugBankDrugReturnEdit({Key key,  this.value,this.LotNumber,this.Number,this.littledrugbank,this.Reason,}):super(key:key);
  String value;
  final Number;
  final LotNumber;
  final littledrugbank;
  final Reason;
  @override
  _DrugBankDrugReturnEditState createState() => _DrugBankDrugReturnEditState();
}

class _DrugBankDrugReturnEditState extends State<DrugBankDrugReturnEdit> {
  DateTime now = DateTime.now();
  double total = 0;
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
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Center(child:Text("客戶退藥資訊-確認",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
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
                  var img = document["系統代碼"];
                  var imgage = "assets/images/$img.jpg";
                  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                  void queryValues() {
                    Firestore.instance
                        .collection('DrugBank').document(document.documentID).collection('LotNumber')
                        .snapshots()
                        .listen((snapshot) {
                      double tempTotal = snapshot.documents.fold(0, (tot, doc) => tot + double.parse(doc.data['數量']));
                      setState(() {total = tempTotal;});
                    });
                  }
                  void updateNumber(){

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
                                text: "單位:",
                                style: TextStyle(fontSize: 18.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["健保單位"],
                                style: TextStyle(fontSize: 18.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "藥名:",
                                style: TextStyle(fontSize: 18.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document.documentID,
                                style: TextStyle(fontSize: 18.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "系統代碼:",
                                style: TextStyle(fontSize: 18.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["系統代碼"],
                                style: TextStyle(fontSize: 18.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "成份:",
                                style: TextStyle(fontSize: 18.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["成份"],
                                style: TextStyle(fontSize: 18.0,color: Colors.indigo),
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
                                text: "退藥小庫:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.littledrugbank,
                                style: TextStyle(fontSize: 20.0,color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),


                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "退藥數量:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.Number,
                                style: TextStyle(fontSize: 20.0,color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),

                        Text("退藥原因:",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                        Container(width: 275.0,child:Text(widget.Reason,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black45),),),

                        RaisedButton(
                            child: Text("確認退藥"),                           ///上傳，預想發票條碼及批號每次皆不相同，所以上傳2是上傳的每筆資料皆以不同序號存放於資料庫，文件名稱為亂碼。
                            onPressed: (){
                              toast();
                              dr.get().then((datasnapshot){
                                final fin = (double.parse(datasnapshot.data["數量"]) + double.parse(widget.Number.toString())).toString(); ///此處先讀取資料庫藥品數量在扣除輸入的藥品數量
                                Firestore.instance.collection("DrugBank").document(document.documentID)
                                    .collection("LotNumber")
                                    .document(widget.LotNumber)
                                    .updateData(                                ///上傳運算後以及輸入框內的資料並完成退藥物動作
                                    {"數量":fin,
                                    },
                                );
                              });
                              Firestore.instance.collection("DrugBank").document(document.documentID)
                                  .collection("LotNumber")
                                  .document(widget.LotNumber)
                                  .collection("user")
                                  .document(formattedDate)
                                  .setData(
                                  {"操作人員":"1233",
                                    "時間": now,
                                    "操作":"退藥",
                                    "數量":widget.Number,
                                    "藥庫":widget.littledrugbank,
                                    "退庫說明":widget.Reason,
                                  }
                                  );
                            }),
                        RaisedButton(
                            child: Text("返回退藥"),
                            onPressed: (){
                              Navigator.push(
                                context,
                                new MaterialPageRoute(builder: (context) => DrugBankDrugReturn()),
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