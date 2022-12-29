// ignore_for_file: prefer_const_constructors, avoid_print

// import 'dart:indexed_db';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shayari_app/Helper.dart';
import 'package:shayari_app/second.dart';
import 'package:sqflite/sqflite.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Map> ll = [];
  Database? db;
  bool st = false;
  bool st1 = false;

  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    viewdata();
    bannerSize = AdmobBannerSize.BANNER;
  }

  forads() async {
    final isLoaded = await interstitialAd.isLoaded;
    if (isLoaded ?? false) {
      interstitialAd.show();
    } else {}
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        st1 = true;
      });
    });
  }

  viewdata() async {
    DbHelp().insert().then((value) {
      setState(() {
        db = value;
      });
      DbHelp().viewdatas(db).then((value) {
        setState(() {
          ll = value;
          for (var v = 0; v < ll.length; v++) {
            debugPrint("${ll[v]['name']} === ${ll[v]['id']}");
          }
        });
      });
    });
    setState(() {
      st = true;
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
        title: Text("Hindi Shayari",
            style: GoogleFonts.inconsolata(
                fontSize: 30, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
      ),
      body: st1
          ? st
              ? Column(
                  children: [
                    Container(
                      color: Color(0xff11e3ff),
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          kToolbarHeight -
                          70,
                      width: MediaQuery.of(context).size.width,
                      child: AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ll.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SecondPage(index, ll),
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(5),
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(20))),
                                      height: 75,
                                      alignment: Alignment.center,
                                      width: double.infinity - 10,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 7),
                                      child: Text("${ll[index]['name']}",
                                          style: GoogleFonts.baloo2(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 25)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: AdmobBanner(
                        adUnitId: getBannerAdUnitId()!,
                        adSize: bannerSize!,
                        listener:
                            (AdmobAdEvent event, Map<String, dynamic>? args) {
                          handleEvent(event, args, 'Banner');
                        },
                        onBannerCreated: (AdmobBannerController controller) {},
                      ),
                    )
                  ],
                )
              : Center(child: CircularProgressIndicator())
          : Center(
              child: CupertinoActivityIndicator(
              radius: 20,
              color: Colors.black,
            )),
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
