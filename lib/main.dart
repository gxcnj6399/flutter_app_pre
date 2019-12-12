import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'stockin.dart';
import 'stockout.dart';
import 'DrugReceive.dart';
import 'DrugWithdrawal.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
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

class DrugBankPicTest extends StatefulWidget {
  @override
  _DrugBankPicTestState createState() => _DrugBankPicTestState();
}

class _DrugBankPicTestState extends State<DrugBankPicTest> {
  var image = "assets/images/OAMAR.jpg";
  var image2 = "assets/images/OAMAR---2.jpg";
  var image3 = "assets/images/OAMAR---3.jpg";
  var imagelist = [
  "assets/images/OAMAR.jpg",
  "assets/images/OAMAR---2.jpg",
  "assets/images/OAMAR---3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            child:
            PhotoViewGallery.builder(
              itemCount: imagelist.length,
              builder: (context,index){
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(
                      imagelist[index]
                  ),
                  maxScale: PhotoViewComputedScale.covered * 2,
                  minScale: PhotoViewComputedScale.contained * 0.8
                );
              },
            ),
            width: 280,
            height: 280,
          ),
      ),
    );
  }
}

