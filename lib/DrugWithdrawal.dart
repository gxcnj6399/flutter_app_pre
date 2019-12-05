import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:intl/intl.dart';

class DrugBankDrugReturn extends StatefulWidget {
  @override
  _DrugBankDrugReturnState createState() => _DrugBankDrugReturnState();
}

class _DrugBankDrugReturnState extends State<DrugBankDrugReturn> {
  TextEditingController resultInfoDrugReturn =  TextEditingController(text:"");
  TextEditingController resultNumber = TextEditingController(text:"");
  TextEditingController resultLotNumber = TextEditingController(text:"");
  double total = 0;
  String lotnumber = "";
  var _littledrugbank = ["請選擇","小庫1","小庫2","小庫3"];
  var _currentItemSelected = "請選擇";

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(title: Center(child:Text("客戶退藥資訊-確認",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
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
                }
                ),
                suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){})
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: resultInfoDrugReturn.text).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData) return Text("loading...");
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
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
                            controller: resultLotNumber,
                            onEditingComplete: (){
                              print(resultLotNumber.text);
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.desktop_windows),
                              labelText: "批號:",
                              suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              }
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("上傳藥庫:",style: TextStyle(fontSize: 22.0,color: Colors.black),),
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
                                builder:(BuildContext context) => DrugBankDrugReturnEdit(
                                  value:resultInfoDrugReturn.text,
                                  Number: resultNumber.text,
                                  LotNumber: resultLotNumber.text,
                                  littledrugbank: _currentItemSelected,
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
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => DrugBankDrugReturn()),
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

class DrugBankDrugReturnEdit extends StatefulWidget {                                       ///病人退藥畫面2
  DrugBankDrugReturnEdit({Key key,  this.value,this.LotNumber,this.Number,this.littledrugbank}):super(key:key);
  String value;
  final Number;
  final LotNumber;
  final littledrugbank;
  @override
  _DrugBankDrugReturnEditState createState() => _DrugBankDrugReturnEditState();
}

class _DrugBankDrugReturnEditState extends State<DrugBankDrugReturnEdit> {
  DateTime now = DateTime.now();
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Center(child:Text("客戶退藥資訊-掃描",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,))),automaticallyImplyLeading: false,),
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

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "退藥數量:",
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
                            child: Text("確認退藥"),                           ///上傳，預想發票條碼及批號每次皆不相同，所以上傳2是上傳的每筆資料皆以不同序號存放於資料庫，文件名稱為亂碼。
                            onPressed: (){
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