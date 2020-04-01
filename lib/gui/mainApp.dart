import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animals/Service/admobService.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'ttsFlutter.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePageApp extends StatefulWidget {
  @override
  _HomePageAppState createState() => _HomePageAppState();
}

class _HomePageAppState extends State<HomePageApp> {
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
  bool falseAnswer = false;
  int rightAnswerCount = 0;
  int wrongAnswerCount = 0;
  int currentLevel = 0;
  int nextLevel = 1;

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

  Future next() async {
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
    initTts();
    next();
    showBanaerAds();
    readDataLevel();
  }

  readDataLevel() async {
    var data = await readData();
    if (!data.contains('No')) {
      currentLevel = int.parse(data);
      nextLevel = currentLevel + 1;
    } else {
      currentLevel = 0;
      nextLevel = 1;
    }
  }

  BannerAd bannerAd;

  void showBanaerAds() {
    bannerAd = AdmobService().myBanner;
    bannerAd
      ..load()
      ..show();
  }

  InterstitialAd interstitialAd;
  void showInteAds() {
    interstitialAd = AdmobService().myInterstitial;
    interstitialAd
      ..load()
      ..show();
  }

  void loseFunction() {
    Alert(
      context: context,
      title: "خطأ",
      desc: "الاختيار خطأ",
      style: AlertStyle(
          titleStyle: TextStyle(fontFamily: 'ballo'),
          descStyle: TextStyle(fontFamily: 'ballo'),
          alertBorder: Border(
            bottom: BorderSide(
              color: Colors.green,
              width: 3.0,
            ),
          ),
          animationDuration: Duration(seconds: 1),
          animationType: AnimationType.grow,
          isCloseButton: false),
      image: Image(image: AssetImage('asset/image/sadCat.gif')),
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(20.0),
          child: Text(
            "المحاولة مرة ثانية",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'ballo'),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red.shade700,
        ),
      ],
    ).show();
  }

  void rightAnswerCall() {
    Alert(
      context: context,
      style: AlertStyle(
          titleStyle: TextStyle(fontFamily: 'ballo'),
          alertBorder: Border(
            bottom: BorderSide(
              color: Colors.green,
              width: 3.0,
            ),
          ),
          animationType: AnimationType.grow,
          isCloseButton: false,
          overlayColor: Colors.black45,
          isOverlayTapDismiss: false),
      type: AlertType.success,
      title: "الاجابة صحيحة",
      buttons: [
        DialogButton(
          child: Text(
            "التالي",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'ballo'),
          ),
          onPressed: () {
            Navigator.pop(context);

            next();
            setState(() {
              nextLevel += 1;
              currentLevel += 1;
            });
            writeData(nextLevel.toString());
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
/////////////  End Functions  /////////////////
////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////

  Widget imageForm1(BuildContext context, var data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            if (data[index]['image'] == image) {
              setState(() {
                wrongAnswerCount = 0;
                rightAnswer = true;
                rightAnswerCount += 1;
              });
              _speak(data[index]['enName']);

              Future.delayed(const Duration(seconds: 1), rightAnswerCall);

              if (rightAnswerCount == 3) {
                showInteAds();
                rightAnswerCount = 0;
              }
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
              setState(() {
                rightAnswer = false;
                wrongAnswerCount += 1;

                if (wrongAnswerCount >= 2) {
                  loseFunction();
                }
              });
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
              setState(() {
                rightAnswer = false;
                wrongAnswerCount += 1;

                if (wrongAnswerCount >= 2) {
                  loseFunction();
                }
              });
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
              setState(() {
                rightAnswer = false;
                wrongAnswerCount += 1;

                if (wrongAnswerCount >= 2) {
                  loseFunction();
                }
              });
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
              setState(() {
                rightAnswer = false;
                wrongAnswerCount += 1;

                if (wrongAnswerCount >= 2) {
                  loseFunction();
                }
              });
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
                wrongAnswerCount = 0;
                rightAnswer = true;
                rightAnswerCount += 1;
              });
              _speak(data[index]['enName']);
              Future.delayed(const Duration(seconds: 1), rightAnswerCall);

              if (rightAnswerCount == 3) {
                showInteAds();
                rightAnswerCount = 0;
              }
            } else {
              setState(() {
                rightAnswer = false;
                wrongAnswerCount += 1;

                if (wrongAnswerCount >= 2) {
                  loseFunction();
                }
              });
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
              setState(() {
                rightAnswer = false;
                wrongAnswerCount += 1;

                if (wrongAnswerCount >= 2) {
                  loseFunction();
                }
              });
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
                wrongAnswerCount = 0;
                rightAnswer = true;
                rightAnswerCount += 1;
              });
              _speak(data[index]['enName']);
              Future.delayed(const Duration(seconds: 1), rightAnswerCall);

              if (rightAnswerCount == 3) {
                showInteAds();
                rightAnswerCount = 0;
              }
            } else {
              setState(() {
                rightAnswer = false;
                wrongAnswerCount += 1;

                if (wrongAnswerCount >= 2) {
                  loseFunction();
                }
              });
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
              setState(() {
                rightAnswer = false;
                wrongAnswerCount += 1;

                if (wrongAnswerCount >= 2) {
                  loseFunction();
                }
              });
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
      backgroundColor: Colors.green,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'الرئيسية',
          style: TextStyle(fontFamily: 'ballo'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(500),
            topRight: Radius.circular(500),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade800,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Text(
                    currentLevel.toString(),
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(50.0)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.green.shade800,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Text(
                    nextLevel.toString(),
                    style: TextStyle(color: Colors.white, fontFamily: 'ballo'),
                  ),
                ),
              ],
            ),

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
                  : wrongAnswerCount == 1
                      ? Image.asset(
                          "$image",
                          color: Colors.red.shade500,
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

            // rightAnswer
            //     ? Directionality(
            //         textDirection: TextDirection.rtl,
            //         child: Container(
            //           width: MediaQuery.of(context).size.width * 0.5,
            //           height: 60.0,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10.0),
            //             gradient: LinearGradient(
            //                 colors: [
            //                   Color(0xff5879fb),
            //                   Color(0xff841dde),
            //                 ],
            //                 begin: Alignment.centerLeft,
            //                 end: Alignment.centerRight),
            //           ),
            //           child: OutlineButton.icon(
            //               textColor: Colors.white,
            //               borderSide: BorderSide(color: Colors.transparent),
            //               label: Text(
            //                 'التالي',
            //                 style: TextStyle(fontFamily: 'ballo'),
            //               ),
            //               icon: Icon(Icons.arrow_back),
            //               onPressed: next),
            //         ),
            //       )
            //     : Offstage()
          ],
        ),
      ),
    );
  }

  TtsState ttsState = TtsState.stopped;
  FlutterTts flutterTts;
  dynamic languages;
  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage('en-UA');
  }

  Future _speak(String _newVoiceText) async {
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setPitch(1.2);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
//////////////////// Read And Write Level Data ////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////

  Future<String> get localPath async {
    final path = await getApplicationDocumentsDirectory();
    return path.path;
  }

  Future<File> get localFile async {
    final file = await localPath;
    return new File('$file/levelData.txt');
  }

  Future<File> writeData(String level) async {
    final file = await localFile;
    return file.writeAsString(level);
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String data = await file.readAsString();
      return data;
    } catch (e) {
      print('No');
      return e.toString();
    }
  }
}
