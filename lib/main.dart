import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LinearGradient> leniarColor = [
    LinearGradient(
        colors: [Color(0xffa29bfe), Color(0xff5352ed)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    LinearGradient(
        colors: [Color(0xffD980FA), Color(0xff5758BB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    LinearGradient(colors: [
      Color(0xffFDA7DF),
      Color(0xffbe2edd),
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
  ];

  String image = "asset/image/lion.png";

  int index = 0;
  int index2 = 0;
  int index3 = 0;
  int length = 0;

  bool showForm1 = true;
  bool showFrom2 = false;

  bool rightAnswer = false;

  generateRandomBool() {
    var ranBool = new Random();
    var ranBool2 = new Random();
    setState(() {
      showForm1 = ranBool.nextBool();
      showFrom2 = ranBool2.nextBool();
    });
  }

  randomNumber(int length) {
    var rng = new Random();
    var rng2 = new Random();
    var rng3 = new Random();
    generateRandomBool();
    setState(() {
      index = rng.nextInt(length - 1);
      setState(() {
        image = data2[index]['image'];
        index2 = rng2.nextInt(length - 1);
        index3 = rng3.nextInt(length - 1);
      });
    });
  }

  var data2;

  Future getImageJsonLength() async {
    setState(() {
      rightAnswer = false;
    });
    var data = await DefaultAssetBundle.of(context)
        .loadString('asset/json/image.json');
    data2 = jsonDecode(data);
    length = data2.length;
    randomNumber(length);
  }

  @override
  void initState() {
    super.initState();
    getImageJsonLength();
  }

  Widget imageForm1(BuildContext context, var data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            if (data[index]['image'] == image) {
              setState(() {
                rightAnswer = true;
              });
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[0],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (data[index2]['image'] == image) {
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[1],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index2]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index2]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (data[index3]['image'] == image) {
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[2],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index3]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index3]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget imageForm2(BuildContext context, var data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            if (data[index3]['image'] == image) {
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[2],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index3]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index3]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (data[index2]['image'] == image) {
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[1],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index2]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index2]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (data[index]['image'] == image) {
              setState(() {
                rightAnswer = true;
              });
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[0],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget imageForm3(BuildContext context, var data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            if (data[index3]['image'] == image) {
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[2],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index3]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index3]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (data[index]['image'] == image) {
              setState(() {
                rightAnswer = true;
              });
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[0],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (data[index2]['image'] == image) {
              print('Right');
            } else {
              print('Wrong');
            }
          },
          child: Container(
            width: 100.0,
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                gradient: leniarColor[1],
                borderRadius: BorderRadius.circular(300.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    data[index2]['image'],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(300.0),
                          bottomRight: Radius.circular(300.0))),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7.0),
                  child: Text(
                    data[index2]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الرئيسية',
          style: TextStyle(fontFamily: 'ballo'),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: rightAnswer
                  ? Image.asset(
                      "$image",
                    )
                  : Image.asset(
                      "$image",
                      color: Colors.green,
                    ),
            ),
            Container(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  var data = jsonDecode(snapshot.data);
                  return showForm1
                      ? imageForm1(context, data)
                      : showFrom2
                          ? imageForm2(context, data)
                          : imageForm3(context, data);
                },
                future: DefaultAssetBundle.of(context)
                    .loadString('asset/json/image.json'),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(colors: [
                    Color(0xff5879fb),
                    Color(0xff841dde),
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                ),
                child: OutlineButton.icon(
                    textColor: Colors.white,
                    borderSide: BorderSide(color: Colors.transparent),
                    label: Text(
                      'التالي',
                      style: TextStyle(fontFamily: 'ballo'),
                    ),
                    icon: Icon(Icons.arrow_back),
                    onPressed: getImageJsonLength),
              ),
            )
          ],
        ),
      ),
    );
  }
}
