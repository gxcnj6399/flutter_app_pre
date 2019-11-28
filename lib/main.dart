import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'stockin.dart';
import 'stockout.dart';
import 'DrugReceive.dart';
import 'DrugWithdrawal.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomePageState();
  }
}


class MyHomePageState extends State<MyHomePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("登入帳號"),),
      body: new Center(
         child:Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          Expanded(
            flex:8,
            child:
             Container(
               margin: EdgeInsets.only(top:150.0),
               child:
                Text("藥庫系統",style: TextStyle(fontSize: 65.0),
              ),
             ),
          ),

          Expanded(
            flex: 3,
            child:
           Container(
             margin: EdgeInsets.only(top:30.0),
             width: 300,
             child :
             TextField(
             decoration: InputDecoration(
              //suffix: IconButton(icon: Icon(Icons.close), onPressed:(){
              //  FocusScope.of(context).requestFocus(FocusNode());
              //    }
              //  ),
              icon: Icon(Icons.account_circle),
              labelText: "帳號",
              contentPadding: EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
             ),
            ),
           ),
          ),
          Expanded(
            flex: 3,
            child:
            Container(
             margin: EdgeInsets.only(bottom: 30.0),
             width: 300,
             child:
             TextField(
              decoration: InputDecoration(
              //  suffix: IconButton(icon: Icon(Icons.close), onPressed:(){
              //    FocusScope.of(context).requestFocus(FocusNode());
              //  }
              //  ),
                icon: Icon(Icons.account_box),
                labelText: "密碼",
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
             ),
            ),
           ),
          ),
            Container(
             margin: EdgeInsets.only(bottom: 50.0),
             child:
              RaisedButton(
               child: new Text("登入"),
                onPressed: (){
                Navigator.push(
                 context,
                  new MaterialPageRoute(builder: (context) => new MainPage()),
               );
              },
             ),
            ),
          ],
        )
      ),
      resizeToAvoidBottomPadding: true,
    );
  }
}

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }
}

class MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("功能頁面"),),
      body: new Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left:25.0),
                  height:100.0, width:100.0,
                    child:
                    IconButton(
                      //padding: EdgeInsets.all(0.0),
                      icon: Icon(Icons.cloud_download,size: 100.0,),
                      onPressed: (){
                        Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) => new DrugBank()),
                        );
                      },
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  height:100.0, width:100.0,
                  child:
                  IconButton(
                    //padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.desktop_windows,size: 100.0,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new DrugBankOut()),
                      );
                    },
                    highlightColor: Colors.blue,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  height:100.0, width:100.0,
                  child:
                  IconButton(
                    //padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.drafts,size: 100.0,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new DrugBankDrugTake()),
                      );
                    },
                    highlightColor: Colors.blue,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left:25.0),
                  height:100.0, width:100.0,
                  child:
                  IconButton(
                    //padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.calendar_today,size: 100.0,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new DrugBankDrugReturn()),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  height:100.0, width:100.0,
                  child:
                  IconButton(
                    //padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.account_box,size: 100.0,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new DrugBankPicTest()),
                      );
                    },
                    highlightColor: Colors.blue,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  height:100.0, width:100.0,
                  child:
                  IconButton(
                    //padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.accessible,size: 100.0,),
                    onPressed: (){},
                    highlightColor: Colors.blue,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left:25.0),
                  height:100.0, width:100.0,
                  child:
                  IconButton(
                    //padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.edit,size: 100.0,),
                    onPressed: (){},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  height:100.0, width:100.0,
                  child:
                  IconButton(
                    //padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.settings,size: 100.0,),
                    onPressed: (){},
                    highlightColor: Colors.blue,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  height:100.0, width:100.0,
                  child:
                  IconButton(
                    //padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.account_box,size: 100.0,),
                    onPressed: (){},
                    highlightColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrugBankDrugTake extends StatefulWidget {
  @override
  _DrugBankDrugTakeState createState() => _DrugBankDrugTakeState();
}

class _DrugBankDrugTakeState extends State<DrugBankDrugTake> {
  TextEditingController resultInfoDrugTake = new TextEditingController(text:"");
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("客戶領藥資訊"),),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[

          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: resultInfoDrugTake.text).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData) return Text("loading...");
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
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
                                  text: "類型:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["類型"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "107項次:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["107項次"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

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
                                  text: "健保價:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["健保價"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "健保碼:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["健保碼"],
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
                                  text: "廠商:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["廠商"],
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
                        ],),
                        //trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: (){}),
                      );
                  }).toList(),
                );
              }
          ),
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
                }
                ),
                suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){})
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("下一步"),
                onPressed: (){
                  var route = new MaterialPageRoute(
                    builder:(BuildContext context) => DrugBankDrugTakeEdit(value:resultInfoDrugTake.text), ///將資料傳遞到下一個畫面
                  );
                  Navigator.of(context).push(route);                                       ///切換到下個畫面
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
  DrugBankDrugTakeEdit({Key key, this.value}):super(key:key);
  String value;
  @override
  _DrugBankDrugTakeEditState createState() => _DrugBankDrugTakeEditState();
}

class _DrugBankDrugTakeEditState extends State<DrugBankDrugTakeEdit> {

  TextEditingController resultNumber3 = TextEditingController(text:"");   //數量輸入框資料
  TextEditingController resultReceipt3 = TextEditingController(text:"");  //發票號碼輸入框資料
  TextEditingController resultPeriod3 = TextEditingController(text:"");   //效期輸入框資料
  TextEditingController resultLotNumber3 = TextEditingController(text:"");//批號輸入框資料
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("客戶領藥資訊上傳"),),
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
                                text: "類型:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["類型"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "107項次:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["107項次"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

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
                                text: "健保價:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["健保價"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "健保碼:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["健保碼"],
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
                                text: "廠商:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["廠商"],
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
                                text: "數量:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: resultNumber3.text,
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
                                text: resultLotNumber3.text,
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
                          controller: resultNumber3,
                          onEditingComplete: (){
                            print(resultNumber3.text);
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

                        TextField(
                          controller: resultLotNumber3,
                          onEditingComplete: (){
                            print(resultLotNumber3.text);
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

                        RaisedButton(                                            ///退庫與入庫1功能相同，在退庫時每次上傳都會在相同效期的文件內扣除藥品數量
                            child: Text("確認領藥"),
                            onPressed: (){
                              DocumentReference dr = Firestore.instance.collection("DrugBank").document(document.documentID)
                                  .collection("LotNumber")
                                  .document(resultLotNumber3.text);
                              dr.get().then((datasnapshot){
                                final fin = (double.parse(datasnapshot.data["數量"]) - double.parse(resultNumber3.text.toString())).toString(); ///此處先讀取資料庫藥品數量在扣除輸入的藥品數量
                                Firestore.instance.collection("DrugBank").document(document.documentID)
                                    .collection("LotNumber")
                                    .document(resultLotNumber3.text)
                                    .updateData(                                ///上傳運算後以及輸入框內的資料並完成退庫動作
                                  {"數量":fin,
                                  },
                                );
                              });
                            }),
                        RaisedButton(
                            child: Text("返回領藥"),
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


class DrugBankDrugReturn extends StatefulWidget {
  @override
  _DrugBankDrugReturnState createState() => _DrugBankDrugReturnState();
}

class _DrugBankDrugReturnState extends State<DrugBankDrugReturn> {
  TextEditingController resultInfoDrugReturn = new TextEditingController(text:"");
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("客戶退藥資訊"),),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[

          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: resultInfoDrugReturn.text).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData) return Text("loading...");
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
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
                                  text: "類型:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["類型"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "107項次:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["107項次"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

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
                                  text: "健保價:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["健保價"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                                ),
                              ],
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text: "健保碼:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["健保碼"],
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
                                  text: "廠商:",
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),
                                ),
                                TextSpan(
                                  text: document["廠商"],
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
                        ],), //trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: (){}),
                      );
                  }).toList(),
                );
              }
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("下一步"),
                onPressed: (){
                  var route = new MaterialPageRoute(
                    builder:(BuildContext context) => DrugBankDrugReturnEdit(value:resultInfoDrugReturn.text), ///將資料傳遞到下一個畫面
                  );
                  Navigator.of(context).push(route);                                       ///切換到下個畫面
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
  DrugBankDrugReturnEdit({Key key, this.value}):super(key:key);
  String value;
  @override
  _DrugBankDrugReturnEditState createState() => _DrugBankDrugReturnEditState();
}

class _DrugBankDrugReturnEditState extends State<DrugBankDrugReturnEdit> {
  TextEditingController resultNumber4 = TextEditingController(text:"");   //數量輸入框資料
  TextEditingController resultReceipt4 = TextEditingController(text:"");  //發票號碼輸入框資料
  TextEditingController resultPeriod4 = TextEditingController(text:"");   //效期輸入框資料
  TextEditingController resultLotNumber4 = TextEditingController(text:"");//批號輸入框資料
  String period = "";
  String lotnumber = "";
  String receipt = "";
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("客戶退藥資訊上傳"),),
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
                      .document(resultLotNumber4.text);
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
                                text: "類型:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["類型"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "107項次:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["107項次"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

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
                                text: "健保價:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["健保價"],
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "健保碼:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["健保碼"],
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
                                text: "廠商:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["廠商"],
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
                                text: "入庫時效期:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: period,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "入庫時批號:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: lotnumber,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                        TextField(
                          controller: resultNumber4,
                          onEditingComplete: (){
                            print(resultNumber4.text);
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

                        TextField(
                          controller: resultLotNumber4,
                          onEditingComplete: (){
                            print(resultLotNumber4.text);
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.desktop_windows),
                            labelText: "批號",
                            suffix: IconButton(icon: Icon(Icons.file_download), onPressed:() {
                              dr.get().then((datasnapshot){
                                period = datasnapshot.data["效期"];
                                lotnumber = datasnapshot.data["批號"];
                                receipt = datasnapshot.data["發票條碼"];
                              });
                              FocusScope.of(context).requestFocus(new FocusNode());
                            }
                            ),
                            suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){}),
                          ),
                        ),
                        RaisedButton(
                            child: Text("確認退藥"),                           ///上傳，預想發票條碼及批號每次皆不相同，所以上傳2是上傳的每筆資料皆以不同序號存放於資料庫，文件名稱為亂碼。
                            onPressed: (){
                              dr.get().then((datasnapshot){
                                final fin = (double.parse(datasnapshot.data["數量"]) + double.parse(resultNumber4.text.toString())).toString(); ///此處先讀取資料庫藥品數量在扣除輸入的藥品數量
                                Firestore.instance.collection("DrugBank").document(document.documentID)
                                    .collection("LotNumber")
                                    .document(resultLotNumber4.text)
                                    .updateData(                                ///上傳運算後以及輸入框內的資料並完成退庫動作
                                  {"數量":fin,
                                  },
                                );
                              });
                            }),
                        RaisedButton(
                            child: Text("返回退藥"),
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

class DrugBankPicTest extends StatefulWidget {
  @override
  _DrugBankPicTestState createState() => _DrugBankPicTestState();
}

class _DrugBankPicTestState extends State<DrugBankPicTest> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Total:")),
    );
  }
}

