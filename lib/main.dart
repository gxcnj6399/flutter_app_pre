import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'stockin.dart';
import 'stockout.dart';
import 'DrugReceive.dart';
import 'DrugWithdrawal.dart';
import 'dart:async';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:firebase_database/firebase_database.dart';
import "OCR.dart";
import 'package:imagebutton/imagebutton.dart';
import 'package:flutter/services.dart';



void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
      appBar: AppBar(
        title: Center(child:Text("登入帳號",style: TextStyle(fontSize: 30.0),),),
        automaticallyImplyLeading: false,
      ),
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
              RaisedButton(
                child: new Text("Google登入"),
                onPressed: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new MainPage()),
                  );
                },
            ),
              RaisedButton(
                child: new Text("Google登出"),
                onPressed: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new MainPage()),
                  );
                },
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
  var image = "assets/images/4.JPG";
  var image2 = "assets/images/5.JPG";
  var image3 = "assets/images/6.JPG";
  var image4 = "assets/images/7.JPG";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title:
        Text("功能頁面",style: TextStyle(fontSize: 30.0),),
        leading: IconButton(onPressed:(){
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new MyHomePage()),
          );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: new Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child:Container(
                      height:125,
                      width:125,
                      child:IconButton(
                          icon: Image.asset(image),
                          onPressed: (){
                            Navigator.push(
                              context,
                              new MaterialPageRoute(builder: (context) => new DrugBank()),
                            );
                          }
                      ),
                    )),
                Expanded(
                    child:Container(
                      height:125,
                      width:125,
                      child:IconButton(
                          icon: Image.asset(image2),
                          onPressed: (){
                            Navigator.push(
                              context,
                              new MaterialPageRoute(builder: (context) => new DrugBankOut()),
                            );
                          }
                      ),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child:Container(
                      height:125,
                      width:125,
                      child:IconButton(
                          icon: Image.asset(image3),
                          onPressed: (){
                            Navigator.push(
                              context,
                              new MaterialPageRoute(builder: (context) => new DrugBankDrugTakeEdit()),
                            );
                          }
                      ),
                    )),
                Expanded(
                    child:Container(
                      height:125,
                      width:125,
                      child:IconButton(
                          icon: Image.asset(image4),
                          onPressed: (){
                            Navigator.push(
                              context,
                              new MaterialPageRoute(builder: (context) => new DrugBankDrugReturn()),
                            );
                          }
                      ),
                    )),
              ],
            ),
            Row(children: <Widget>[
              Expanded(child: Container(width:125,height:125,child: null,)),
              Expanded(child: Container(width:125,height:125,child: null,)),
            ],)
          ],
        ),
      ),
    );
  }
}

class DrugBankPicTest extends StatefulWidget {
  @override
  _DrugBankPicTestState createState() => _DrugBankPicTestState();
}

class _DrugBankPicTestState extends State<DrugBankPicTest> {

  var _currentItemSelected = "請選擇";
  Future getPosts() async {
    QuerySnapshot qn = await Firestore.instance
        .collection('DrugBank')
        .document("Clozaril ◎100mg")
        .collection('LotNumber')
        .orderBy('比較效期', descending: false ).limit(3).getDocuments();
    return qn.documents;
  }
  List<DropdownMenuItem<String>> list = [];
  List<DropdownMenuItem<String>> list2 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('DrugBank')
              .document("Clozaril ◎100mg")
              .collection('LotNumber')
              .orderBy('比較效期', descending: false ).limit(3).snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(child: Text("Loading"),);
            }
              return null;
          },
        ),
      ),
    );
  }
}

