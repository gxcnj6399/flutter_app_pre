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
                    icon: Icon(Icons.drafts,size: 100.0,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new DrugBankOut()),
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

class DrugBank extends StatefulWidget{                                            ///進庫
  @override
  State<StatefulWidget> createState() {
    // 1TODO: implement createState
    return DrugBankState();
  }
}

class DrugBankState extends State<DrugBank>{                                      ///進庫
  TextEditingController resultInfo = new TextEditingController(text:"");
  //Future getdata2()  {
  //  final ref = FirebaseStorage.instance.ref().child('123');
  //  var url =   ref.getDownloadURL();
  //  print(url);
  //}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("進貨藥庫資訊"),),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[

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
                suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){})
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("讀取"),
                onPressed: (){
                  var route = new MaterialPageRoute(
                    builder:(BuildContext context) => DrugBankEdit(value:resultInfo.text), ///將資料傳遞到下一個畫面
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
              RaisedButton(
                child: Text("讀取"),
                onPressed: (){
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
  DrugBankEdit({Key key, this.value}):super(key:key);
  String value;
  @override
  _DrugBankEditState createState() => _DrugBankEditState();
}

class _DrugBankEditState extends State<DrugBankEdit> {

  TextEditingController resultNumber = TextEditingController(text:"");   //數量輸入框資料
  TextEditingController resultReceipt = TextEditingController(text:"");  //發票號碼輸入框資料
  TextEditingController resultPeriod = TextEditingController(text:"");   //效期輸入框資料
  TextEditingController resultLotNumber = TextEditingController(text:"");//批號輸入框資料

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("上傳"),),
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
                        RaisedButton(
                            child: Text("掃描"),
                            onPressed: (){}
                            ),
                        RaisedButton(                                           ///上傳1，上傳1是先前討論的上傳形式，以效期當作文件名稱，在入庫時每次上傳都會在相同效期的文件內增加藥品數量
                            child: Text("確認上傳"),
                            onPressed: (){
                              DocumentReference dr = Firestore.instance.collection("DrugBank").document(document.documentID)
                                  .collection("number")
                                  .document(resultPeriod.text);
                              dr.get().then((datasnapshot){
                                final fin = (double.parse(datasnapshot.data["數量"]) + double.parse(resultNumber.text.toString())).toString();  ///此處先讀取資料庫藥品數量在與輸入數量相加
                                Firestore.instance.collection("DrugBank").document(document.documentID)
                                    .collection("number")
                                    .document(resultPeriod.text)
                                    .updateData(                                ///上傳運算後以及輸入框內的資料並完成入庫
                                  {"數量":fin,
                                    "發票條碼":resultReceipt.text,
                                    "效期":resultPeriod.text,
                                    "批號":resultLotNumber.text,
                                  },
                                );
                              });
                            }),
                        RaisedButton(
                            child: Text("確認上傳2"),                           ///上傳2，預想發票條碼及批號每次皆不相同，所以上傳2是上傳的每筆資料皆以不同序號存放於資料庫，文件名稱為亂碼。
                            onPressed: (){
                              Firestore.instance.collection("DrugBank").document(document.documentID)
                                  .collection("number")
                                  .document()
                                  .setData(
                                {"數量":resultNumber.text,
                                  "發票條碼":resultReceipt.text,
                                  "效期":resultPeriod.text,
                                  "批號":resultLotNumber.text,
                                },
                              );
                            }),
                        RaisedButton(
                            child: Text("返回主畫面"),
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

class DrugBankOut extends StatefulWidget {
  @override
  _DrugBankOutState createState() => _DrugBankOutState();
}

class _DrugBankOutState extends State<DrugBankOut> {
  TextEditingController resultInfo2 = new TextEditingController(text:"");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("退庫藥庫資訊"),),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[

          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: resultInfo2.text).snapshots(),
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
          TextField(
            controller: resultInfo2,
            onEditingComplete: (){
              print(resultInfo2.text);
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
                child: Text("讀取"),
                onPressed: (){
                  var route = new MaterialPageRoute(
                    builder:(BuildContext context) => DrugBankOutEdit(value2:resultInfo2.text), ///將資料傳遞到下一個畫面
                  );
                  Navigator.of(context).push(route);                             ///切換到下個畫面
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
                },
              ),
            ],),
        ],
        ),
      ),
    );
  }
}

class DrugBankOutEdit extends StatefulWidget {
  DrugBankOutEdit({Key key, this.value2}):super(key:key);
  String value2;
  @override
  _DrugBankOutEditState createState() => _DrugBankOutEditState();
}

class _DrugBankOutEditState extends State<DrugBankOutEdit> {
  TextEditingController resultNumber2 = TextEditingController(text:"");   //數量輸入框資料
  TextEditingController resultReceipt2 = TextEditingController(text:"");  //發票號碼輸入框資料
  TextEditingController resultPeriod2 = TextEditingController(text:"");   //效期輸入框資料
  TextEditingController resultLotNumber2 = TextEditingController(text:"");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("退庫"),),
        body:
        //Text("${widget.value}"),
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('DrugBank').where("國際條碼",isEqualTo: widget.value2).snapshots(),
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
                        Text.rich(
                          TextSpan(
                            children:[
                              TextSpan(
                                text: "數量:",
                                style: TextStyle(fontSize: 20.0,color: Colors.black),
                              ),
                              TextSpan(
                                text: resultNumber2.text,
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
                                text: resultReceipt2.text,
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
                                text: resultPeriod2.text,
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
                                text: resultLotNumber2.text,
                                style: TextStyle(fontSize: 20.0,color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                        TextField(
                          controller: resultNumber2,
                          onEditingComplete: (){
                            print(resultNumber2.text);
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
                          controller: resultReceipt2,
                          onEditingComplete: (){
                            print(resultReceipt2.text);
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
                          controller: resultLotNumber2,
                          onEditingComplete: (){
                            print(resultLotNumber2.text);
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
                          controller: resultPeriod2,
                          onEditingComplete: (){
                            print(resultPeriod2.text);
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
                        RaisedButton(
                            child: Text("掃描"),
                            onPressed: (){}
                        ),
                        RaisedButton(                                            ///退庫與入庫1功能相同，在退庫時每次上傳都會在相同效期的文件內扣除藥品數量
                            child: Text("確認退庫"),
                            onPressed: (){
                              DocumentReference dr = Firestore.instance.collection("DrugBank").document(document.documentID)
                                  .collection("number")
                                  .document(resultPeriod2.text);
                              dr.get().then((datasnapshot){
                                final fin = (double.parse(datasnapshot.data["數量"]) - double.parse(resultNumber2.text.toString())).toString(); ///此處先讀取資料庫藥品數量在扣除輸入的藥品數量
                                Firestore.instance.collection("DrugBank").document(document.documentID)
                                    .collection("number")
                                    .document(resultPeriod2.text)
                                    .updateData(                                ///上傳運算後以及輸入框內的資料並完成退庫動作
                                  {"數量":fin,
                                    "發票條碼":resultReceipt2.text,
                                    "效期":resultPeriod2.text,
                                    "批號":resultLotNumber2.text,
                                  },
                                );
                              });
                            }),
                        RaisedButton(
                            child: Text("返回主畫面"),
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

