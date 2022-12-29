// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, avoid_print, unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari_app/four.dart';

class ThirdPage extends StatefulWidget {
  List ll;
  int index;

  ThirdPage(this.ll, this.index);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  PageController pageController = PageController();
  AdmobBannerSize? bannerSize;
  bool st = false;
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;
    pageController = PageController(initialPage: widget.index);
    print("=${widget.index}");
    print("======${widget.ll}");
    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) {
          interstitialAd.load();
        }
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
    Future.delayed(Duration(seconds: 4)).then((value) {
      forads();
    });
  }

  forads() async {
    final isLoaded = await interstitialAd.isLoaded;
    if (isLoaded ?? false) {
      interstitialAd.show();
    } else {}
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        st = true;
      });
    });
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        break;
      case AdmobAdEvent.opened:
        break;
      case AdmobAdEvent.closed:
        break;
      case AdmobAdEvent.failedToLoad:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.ll[widget.index]['Shayari']}",
            maxLines: 1,
            style: GoogleFonts.inconsolata(
                fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: st
          ? Column(
              children: [
                Expanded(
                    child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      print("==${value}");
                      print("===${widget.index}");
                      print("====${widget.ll[widget.index]}");
                      widget.index = value;
                    });
                  },
                  controller: pageController,
                  itemCount: widget.ll.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.red,
                              width: 4,
                              style: BorderStyle.solid),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: AutoSizeText(
                        "😀 😃 😄 😁 😆 \n${widget.ll[widget.index]['Shayari']}\n😀 😃 😄 😁 😆 ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    );
                  },
                )),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          iconSize: MediaQuery.of(context).size.width * 0.1,
                          onPressed: () {
                            FlutterClipboard.copy(
                                    widget.ll[widget.index]['Shayari'])
                                .then((value) => print(Fluttertoast.showToast(
                                    msg: "Text Copied",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 15.0)));
                          },
                          icon: Icon(Icons.copy)),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          iconSize: MediaQuery.of(context).size.width * 0.1,
                          onPressed: () {
                            if (widget.index > 0) {
                              setState(() {
                                widget.index--;
                              });
                            } else {
                              FlutterClipboard.copy(
                                      widget.ll[widget.index]['Shayari'])
                                  .then((value) => print(Fluttertoast.showToast(
                                      msg: "Front page no more",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 15.0)));
                            }
                          },
                          icon: Icon(Icons.arrow_back)),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          iconSize: MediaQuery.of(context).size.width * 0.1,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return FourthPage(widget.ll, widget.index);
                              },
                            ));
                          },
                          icon: Icon(Icons.edit)),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          iconSize: MediaQuery.of(context).size.width * 0.1,
                          onPressed: () {
                            if (widget.ll.length - 1 > widget.index) {
                              setState(() {
                                widget.index++;
                              });
                            } else {
                              FlutterClipboard.copy(widget.ll[widget.index])
                                  .then((value) => print(Fluttertoast.showToast(
                                      msg: "Backpage no more",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 15.0)));
                            }
                          },
                          icon: Icon(Icons.arrow_forward)),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          iconSize: MediaQuery.of(context).size.width * 0.1,
                          onPressed: () {
                            Share.share(
                                "😀 😃 😄 😁 😆 \n${widget.ll[widget.index]['Shayari']}\n😀 😃 😄 😁 😆 ");
                          },
                          icon: Icon(Icons.share)),
                    ))
                  ],
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: AdmobBanner(
                    adUnitId: getBannerAdUnitId()!,
                    adSize: bannerSize!,
                    listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
                      handleEvent(event, args, 'Banner');
                    },
                    onBannerCreated: (AdmobBannerController controller) {},
                  ),
                )
              ],
            )
          : Center(child: spinkit),
    );
  }
}

String? getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2934735716';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/6300978111';
  }
  return null;
}

String? getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/4411468910';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/1033173712';
  }
  return null;
}

final spinkit = SpinKitSpinningLines(
  size: 70,
  itemCount: 14,
  duration: Duration(seconds: 4),
  color: Colors.blueAccent,
);
