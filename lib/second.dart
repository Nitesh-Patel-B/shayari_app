// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, avoid_print

import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shayari_app/Helper.dart';
import 'package:shayari_app/third.dart';
import 'package:sqflite/sqflite.dart';

class SecondPage extends StatefulWidget {
  int index;
  List<Map> ll;

  @override
  State<SecondPage> createState() => _SecondPageState();

  SecondPage(this.index, this.ll);
}

class _SecondPageState extends State<SecondPage> {
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

  viewdata() {
    DbHelp().insert().then((value) {
      setState(() {
        db = value;
      });
      DbHelp().viewdatas1(db, widget.index).then((value) {
        setState(() {
          ll = value;
          for (var v = 0; v < ll.length; v++) {
            print("${ll[v]['Shayari']} === ${ll[v]['Cat_id']}");
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
        title: Text("${widget.ll[widget.index]['name']}",
            style: GoogleFonts.inconsolata(
                fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: st1
          ? st
              ? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          kToolbarHeight -
                          70,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xff11e3ff),
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: ll.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ThirdPage(ll, index),
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight:
                                                  Radius.circular(20))),
                                      height: 75,
                                      alignment: Alignment.center,
                                      width: double.infinity - 10,
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(10),
                                      child: Text("${ll[index]['Shayari']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: GoogleFonts.baloo2(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 20)),
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

final spinkit = SpinKitWave(
  itemBuilder: (context, index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
  size: 60,
  itemCount: 14,
  duration: Duration(milliseconds: 750),
);
