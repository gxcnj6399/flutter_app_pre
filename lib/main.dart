import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
                        new MaterialPageRoute(builder: (context) => new DrugBank2()),
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
                     // Navigator.push(
                     //   context,
                      //  new MaterialPageRoute(builder: (context) => new DrugIn()),
                     // );
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
                    onPressed: (){},
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


class DrugBank extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // 1TODO: implement createState
    return DrugBankState();
  }
}

class DrugBankState extends State<DrugBank>{
  TextEditingController resultInfo = new TextEditingController(text:"");
  Future getdata() async {
      Firestore.instance.collection("DrugBank")
          .where("國際條碼", isEqualTo: resultInfo.text)
          .snapshots().listen((data) => data.documents.forEach((doc) => print(doc["中文"])));
  }

  Future getdata2()  {
    final ref = FirebaseStorage.instance.ref().child('123');
    var url =   ref.getDownloadURL();
    print(url);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("藥庫資訊"),),
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
                  suffix: IconButton(icon: Icon(Icons.close), onPressed:() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  }
                 ),
              ),
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              RaisedButton(
                child: Text("讀取"),
                onPressed: (){
                  var route = new MaterialPageRoute(
                      builder:(BuildContext context) => DrugBankEdit(value:resultInfo.text),
                  );
                  Navigator.of(context).push(route);
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
                RaisedButton(
                  child: Text("讀取"),
                  onPressed: (){
                    getdata2();
                  },
                ),
            ],),

            //Text(resultInfo.text,style: TextStyle(fontSize: 20.0),),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: resultInfo.text).snapshots(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData) return Text("loading...");
                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: snapshot.data.documents.map((DocumentSnapshot document){
                      return
                          ListTile(
                            title: Center(child:Text(document["中文"],style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),),
                            subtitle:
                            Column(children: <Widget>[
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
                                      text: document["藥名"],
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
                            ],),
                            //trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: (){}),
                          );
                    }).toList(),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}

class DrugBankEdit extends StatefulWidget {
  DrugBankEdit({Key key, this.value}):super(key:key);
  String value;
  @override
  _DrugBankEditState createState() => _DrugBankEditState();
}


class _DrugBankEditState extends State<DrugBankEdit> {

  TextEditingController resultNumber = TextEditingController(text:"");
  TextEditingController resultReceipt = TextEditingController(text:"");
  TextEditingController resultPeriod = TextEditingController(text:"");
  TextEditingController resultLotNumber = TextEditingController(text:"");




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("上傳"),),
        body: SingleChildScrollView(
      child:Column(children: <Widget>[
          //Text("${widget.value}"),
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: widget.value).snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData) return Text("loading...");
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data.documents.map((DocumentSnapshot document){
                  return
                    ListTile(
                      title: Center(child:Text(document["中文"],style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),),
                      subtitle:
                      Column(children: <Widget>[
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
                                text: document["藥名"],
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
                                text: "代碼:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: document["代碼"],
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
                                text: resultNumber.text,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "發票條碼:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: resultReceipt.text,
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
                                text: resultPeriod.text,
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
                                text: resultLotNumber.text,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                        RaisedButton(
                            child: Text("確認上傳"),
                            onPressed: (){
                              Firestore.instance.collection("DrugBank").document(document.documentID).updateData(
                                {"數量":resultNumber.text,
                                  "發票條碼":resultReceipt.text,
                                  "效期":resultPeriod.text,
                                  "批號":resultLotNumber.text,
                                },
                              );
                              Navigator.push(
                                context,
                                new MaterialPageRoute(builder: (context) => DrugBank()),
                              );
                            }),
                        RaisedButton(
                            child: Text("掃描"),
                            onPressed: (){}),
                      ],),
                      //trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: (){}),
                    );
                }).toList(),
              );
            }
        ),

          TextField(
            controller: resultNumber,
            onEditingComplete: (){
              print(resultNumber.text);
            },
            decoration: InputDecoration(
              icon: Icon(Icons.desktop_windows),
              labelText: "輸入數量",
              suffix: IconButton(icon: Icon(Icons.close), onPressed:() {
                FocusScope.of(context).requestFocus(new FocusNode());
              }
              ),
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
              suffix: IconButton(icon: Icon(Icons.close), onPressed:() {
                FocusScope.of(context).requestFocus(new FocusNode());
              }
              ),
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
              suffix: IconButton(icon: Icon(Icons.close), onPressed:() {
                FocusScope.of(context).requestFocus(new FocusNode());
              }
              ),
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
              suffix: IconButton(icon: Icon(Icons.close), onPressed:() {
                FocusScope.of(context).requestFocus(new FocusNode());
              }
              ),
            ),
          ),

          ],),
        ),
      ),
    );
  }
}

class DrugBank2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DrugBank2State();
  }
}

class DrugBank2State extends State<DrugBank2>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("藥庫2"),),
      body: ListView(
        scrollDirection: Axis.horizontal,
          children: <Widget>[
          DataTable(
              columns: [
                DataColumn(
                  label: Container(
                    width: 30,
                    child: Text("樣式",style: TextStyle(fontSize: 15.0),),
                  ),
                ),
                DataColumn(
                  label: Text("系統代碼",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("107項次",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("藥名",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("健保",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("健保碼",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("成分",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("健保價",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("廠商",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("中文",style: TextStyle(fontSize: 15.0),),
                ),
                DataColumn(
                  label: Text("國際碼",style: TextStyle(fontSize: 15.0),),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Container(
                      width: 30,
                      child:Text("年月日",style: TextStyle(fontSize: 15.0),),
                      ),
                    ),
                    DataCell(Text("EFOCUS",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("F1125.2",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("Focus Gel 1% 40gm",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("TUB",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("AC43214345",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("Piroxicam 10mg/gm",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("35.00",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("US永信",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("伏加斯凝膠",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("4715168106155",style: TextStyle(fontSize: 15.0),)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Container(
                      width: 30,
                      child:Text("年月日",style: TextStyle(fontSize: 15.0),),
                    ),
                    ),
                    DataCell(Text("EFOCUS",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("F1125.2",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("Focus Gel 1% 40gm",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("TUB",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("AC43214345",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("Piroxicam 10mg/gm",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("35.00",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("US永信",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("伏加斯凝膠",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("4715168106155",style: TextStyle(fontSize: 15.0),)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Container(
                      width: 30,
                      child:Text("年月日",style: TextStyle(fontSize: 15.0),),
                    ),
                    ),
                    DataCell(Text("EFOCUS",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("F1125.2",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("Focus Gel 1% 40gm",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("TUB",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("AC43214345",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("Piroxicam 10mg/gm",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("35.00",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("US永信",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("伏加斯凝膠",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("4715168106155",style: TextStyle(fontSize: 15.0),)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Container(
                      width: 30,
                      child:Text("年月日",style: TextStyle(fontSize: 15.0),),
                    ),
                    ),
                    DataCell(Text("EFOCUS",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("F1125.2",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("Focus Gel 1% 40gm",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("TUB",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("AC43214345",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("Piroxicam 10mg/gm",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("35.00",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("US永信",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("伏加斯凝膠",style: TextStyle(fontSize: 15.0),)),
                    DataCell(Text("4715168106155",style: TextStyle(fontSize: 15.0),)),
                  ],
                ),
              ],
          )
        ],
      )
    );
  }
}

