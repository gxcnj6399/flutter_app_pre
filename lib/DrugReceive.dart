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
class DrugBankDrugTake extends StatefulWidget {
  @override
  _DrugBankDrugTakeState createState() => _DrugBankDrugTakeState();
}

class _DrugBankDrugTakeState extends State<DrugBankDrugTake> {
  TextEditingController resultInfoDrugTake = new TextEditingController(text:"");
  TextEditingController resultNumber = TextEditingController(text:"");
  double total = 0;
  String lotnumber = "";
  String choose = "國際條碼";
  var _littledrugbank = ["小庫1","小庫2","小庫3"];
  var _currentItemSelected = "小庫1";
  var _dropPeriod = ["請選擇"];
  var _currentItemSelected2 = "請選擇";
  var qn = [];
  List<DropdownMenuItem<String>> list = [];
  bool flag = false;
  File _file;
  bool isImageLoaded = false ;
  File _image;
  String barcode ="";
  String ocrtext1 = "" ;
  String ocrtext2 = "" ;
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  var selectItemValue;

  @override
  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      setState(() => this.resultInfoDrugTake.text = barcode);
    }on PlatformException catch(e){
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child:
        Text("客戶領藥資訊-掃描",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
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
            controller: resultInfoDrugTake,
            onEditingComplete: (){
              print(resultInfoDrugTake.text);
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
              stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: resultInfoDrugTake.text).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData) return Text("loading...");
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.documents.map((DocumentSnapshot document){
                    DocumentReference dr = Firestore.instance.collection("DrugBank").document(document.documentID)
                        .collection("LotNumber")
                        .document(_currentItemSelected2);
                    Future getPosts() async {
                      QuerySnapshot qn = await Firestore.instance
                          .collection('DrugBank')
                          .document("Clozaril ◎100mg")
                          .collection('LotNumber')
                          .orderBy('比較效期', descending: false ).limit(3).getDocuments();
                      return qn.documents;
                    }
                    var img = document["系統代碼"];
                    var imgage = "assets/images/$img.jpg";
                    var image2 = "assets/images/$img---2.jpg";
                    var imagelist=[
                      "assets/images/$img.jpg",
                      "assets/images/$img---2.jpg",
                      "assets/images/$img---3.jpg",
                    ];
                    void dataread(){
                      dr.get().then((datasnapshot){
                        lotnumber = datasnapshot.data["批號"];
                      });
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
                    var list3=list.toSet().toList();
                    var check="12345";
                    var listen=Firestore.instance
                        .collection('DrugBank')
                        .document(document.documentID)
                        .collection("LotNumber")
                        .orderBy('比較效期', descending: false ).limit(3).snapshots();

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
                            Text("領藥小庫:",style: TextStyle(fontSize: 22.0,color: Colors.black),),
                            DropdownButton<String>(
                              hint: Text("請選擇小庫"),
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("選擇效期:",style: TextStyle(fontSize: 22.0,color: Colors.black),),
                              DropdownButton<String>(
                                hint: Text("請選擇效期"),
                                items: _dropPeriod.map((String dropDownStringItem){
                                  return DropdownMenuItem<String>(
                                    value:dropDownStringItem,
                                    child: Text(dropDownStringItem,style: TextStyle(fontSize: 22.0,color: Colors.indigo),),
                                  );
                                }).toList(),
                                onChanged: (String newValueSelected){
                                  setState(() {
                                    this._currentItemSelected2 = newValueSelected;
                                  });
                                },
                                value: _currentItemSelected2,
                              ),
                            ],),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              Text("選擇效期:",style: TextStyle(fontSize: 22.0,color: Colors.black),),
                              DropdownButton<String>(
                                items: list3,
                                hint: Text("請選擇效期"),
                                onChanged: (String newValueSelected){
                                  setState(() {
                                    this.selectItemValue = newValueSelected;
                                    print(newValueSelected);
                                  });
                                },
                                value: selectItemValue,
                              ),
                            ],),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Text("選擇效期:",style: TextStyle(fontSize: 22.0,color: Colors.black),),
//                              DropdownButton<String>(
//                                hint: Text("請選擇效期"),
//                                items: list3,
//                                onChanged: (String newValueSelected){
//                                  setState(() {
//                                    this._currentItemSelected2 = newValueSelected;
//                                  });
//                                },
//                                value: _currentItemSelected2,
//                              ),
//                            ],),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "批號:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: "",
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
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
                                builder:(BuildContext context) => DrugBankDrugTakeEdit(
                                  value:resultInfoDrugTake.text,
                                  Number: resultNumber.text,
                                  LotNumber: lotnumber,
                                  Period: _currentItemSelected2,
                                  littledrugbank: _currentItemSelected,
                                ), ///將資料傳遞到下一個畫面
                              );
                              Navigator.of(context).push(route);                                       ///切換到下個畫面
                            },
                          ),
                          //Text(list.length.toString()),
                          StreamBuilder<QuerySnapshot>(
                            stream: listen,
                            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                              if(!snapshot.hasData){
                                return Center(child: Text("Loading"),);
                              }
                              return Container(
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  children:snapshot.data.documents.map((DocumentSnapshot document){
                                    void add() {
                                      if (list.length >= 3)
                                      {SizedBox.shrink();}
                                      else {
                                        list.add(new DropdownMenuItem(
                                          child: Text(document["效期"]),
                                          value: document["效期"],
                                        ));
                                      }
                                    };
                                    add();
                                    return Container();
                                  }).toList(),
                                ),
                              );
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
                  resultInfoDrugTake.clear();
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

class DrugBankDrugTakeEdit extends StatefulWidget {                                       ///病人領藥畫面2
  DrugBankDrugTakeEdit({Key key, this.value,this.Period,this.LotNumber,this.Number,this.littledrugbank}):super(key:key);
  String value;
  final Number;
  final Period;
  final LotNumber;
  final littledrugbank;
  @override
  _DrugBankDrugTakeEditState createState() => _DrugBankDrugTakeEditState();
}

class _DrugBankDrugTakeEditState extends State<DrugBankDrugTakeEdit> {
  DateTime now = DateTime.now();
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Center(child:Text("客戶領藥資訊-確認",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey,
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
                                text: "領藥數量:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.Number,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "領藥小庫:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.littledrugbank,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        RaisedButton(                                            ///退庫與入庫1功能相同，在退庫時每次上傳都會在相同效期的文件內扣除藥品數量
                            child: Text("確認領藥"),
                            onPressed: (){

                              dr.get().then((datasnapshot){
                                final fin = (double.parse(datasnapshot.data["數量"]) - double.parse(widget.Number.toString())).toString(); ///此處先讀取資料庫藥品數量在扣除輸入的藥品數量
                                Firestore.instance.collection("DrugBank").document(document.documentID)
                                    .collection("LotNumber")
                                    .document(widget.LotNumber)
                                    .updateData(                                ///上傳運算後以及輸入框內的資料並完成領藥動作
                                  {"數量":fin,
                                  },
                                );
                                Firestore.instance.collection("DrugBank").document(document.documentID)
                                    .collection("LotNumber")
                                    .document(widget.LotNumber)
                                    .collection("user")
                                    .document(formattedDate)
                                    .setData(
                                    {"操作人員":"1233",
                                      "時間": now,
                                      "操作":"領藥",
                                      "數量":widget.Number,
                                      "藥庫":widget.littledrugbank,
                                    }
                                );
                              });
                            }),

                        RaisedButton(
                            child: Text("返回領藥"),
                            onPressed: (){
                              Navigator.push(
                                context,
                                new MaterialPageRoute(builder: (context) => DrugBankDrugTake()),
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

