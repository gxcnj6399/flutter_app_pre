import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:intl/intl.dart';
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

  @override
  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      setState(() => this.resultInfo.text = barcode);
    }on PlatformException catch(e){
    }
  }
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Center(child:Text("進庫資訊-確認",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          TextField(
            controller: resultInfo,
            onEditingComplete: (){
              print(resultInfo.text);
            },
            decoration: InputDecoration(
                icon: Icon(Icons.desktop_windows),
                labelText: "輸入條碼",
                suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                }
                ),
                suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){scan();})
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: resultInfo.text).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData) return Text("loading...");
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(), ///防止 Singlechildscrollview 與 listview 的捲動功能衝突 (兩個指令都有捲動畫面的功能)
                  children: snapshot.data.documents.map((DocumentSnapshot document){
                    var img = document["系統代碼"];
                    var imgage = "assets/images/$img.jpg";
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
                    queryValues();
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
                                  text: "健保單位:",
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
                                  text: "藥庫總數量:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: total.toString(),
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

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
                              suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){}),
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
                              suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){}),
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
                              suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){}),
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
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => DrugBank()),
                  );
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
        appBar: AppBar(title: Center(child:Text("進庫資訊-掃描",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),automaticallyImplyLeading: false,),
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
                  queryValues();
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
                                text: "健保單位:",
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

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "藥庫總數量:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: total.toString(),
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

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
                              Firestore.instance.collection("DrugBank").document(document.documentID)
                                  .collection("LotNumber")
                                  .document(widget.LotNumber)
                                  .setData(
                                {"數量":widget.Number,
                                  "發票條碼":widget.Receipt,
                                  "效期":widget.Period,
                                  "批號":widget.LotNumber,
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
                                    "操作":"進貨",
                                    "數量":widget.Number,
                                  }
                              );
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
