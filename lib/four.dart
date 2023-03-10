// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, avoid_print, null_argument_to_non_null_type, prefer_const_declarations, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unnecessary_import, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:share_plus/share_plus.dart';

class FourthPage extends StatefulWidget {
  List ll;
  int index;

  FourthPage(this.ll, this.index);

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  AdmobBannerSize? bannerSize;
  List Myemoji = [
    "๐ ๐ ๐ ๐ ๐",
    "๐ ๐ ๐คฃ ๐ฅฒ โบ",
    "๐ ๐ ๐ ๐ ๐",
    "๐ ๐ ๐ฅฐ ๐ ๐",
    "๐ ๐ ๐ ๐ ๐",
    "๐ ๐คช ๐คจ ๐ง ๐ค",
    "๐ ๐ฅธ ๐คฉ ๐ฅณ ๐",
    "๐ ๐ ๐ ๐ ๐",
    "๐ โน ๐ฃ ๐ ๐ซ",
    "๐ฉ ๐ฅบ ๐ข ๐ญ ๐ค",
    "๐  ๐ก ๐คฌ ๐คฏ ๐ณ",
    "๐ฅต ๐ฅถ ๐ฑ ๐จ ๐ฐ",
    "๐ฅ ๐ ๐ค ๐ค ๐คญ ",
    "๐คซ ๐คฅ ๐ถ ๐ ๐",
    "๐ฌ ๐ ๐ฏ ๐ฆ ๐ง",
    "๐ฎ ๐ฒ ๐ฅฑ ๐ด ๐คค",
    "๐ช ๐ต ๐ค ๐ฅด ๐คข",
    "๐คฎ ๐คง ๐ท ๐ค ๐ค",
    "๐ค ๐ค  ๐ ๐ฟ ๐น",
    "๐บ ๐คก ๐ฉ ๐ป ๐",
    "โ  ๐ฝ ๐พ ๐ค ๐",
    "๐บ ๐ธ ๐น ๐ป ๐ผ",
    "๐ ๐ ๐ ๐ ๐",
    "๐ ๐ ๐คฃ ๐ ๐",
    "๐ ๐ ๐ โบ ๐",
    "๐ ๐ ๐ฅฐ ๐ ๐",
    "๐ ๐ ๐ฅฒ ๐คช ๐",
    "๐ ๐ ๐ค ๐ ๐ค",
    "๐ฅธ ๐ง ๐ค  ๐ฅณ ๐คก",
    "๐ ๐ถ ๐ซฅ ๐ ๐ซค ๐",
    "๐ ๐ ๐คจ ๐ค ๐คซ",
    "๐คญ ๐ซข ๐ซก ๐ค ๐ซฃ ๐คฅ",
    "๐ณ ๐ ๐ ๐ค ๐ ",
    "๐ก ๐คฌ ๐ ๐ ๐",
    "โน ๐ฌ ๐ฅบ ๐ฃ ๐",
    "๐ซ ๐ฉ ๐ฅฑ ๐ช ๐ฎ",
    "๐ฎ ๐ฑ ๐จ ๐ฐ ๐ฅ",
    "๐ ๐ฏ ๐ฆ ๐ง ๐ข",
    "๐ญ ๐คค ๐คฉ ๐ต ๐ตโ",
    "๐ฅด ๐ฒ ๐คฏ ๐ค",
    "๐ท ๐ค ๐ค ๐คฎ ๐คข ",
    "๐คง ๐ฅต ๐ฅถ ๐ถโ ๐ด",
    " ๐ค ๐ ๐ฟ ๐น ๐บ",
    " ๐ฉ ๐ป ๐ โ  ๐ฝ ",
    "๐ค ๐ ๐บ ๐ธ ๐น",
    " ๐ป ๐ผ ๐ฝ ๐ ๐ฟ "
  ];

  List MyFontFamily = [
    'RobotoMono',
    'Roboto',
    'Yanone_Kaffeesatz',
    'Ubuntu',
    'Murecho',
    'Titillium_Web',
    'Raleway',
    'Inconsolata',
    'Nunito'
  ];

  String currentfont = "๐ ๐ ๐ ๐ ๐ ";
  Color currentbg = Color(0xff000000);
  Color currenttc = Color(0xffffffff);
  Color currentbordercolor = Color(0xffff1100);
  double bordersize = 4;
  double borderradius = 50;
  double currentSliderValue = 16.0;
  String currentfontfamily = 'RobotoMono';
  var now = DateTime.now();
  late AdmobInterstitial interstitialAd;

  //Random().nextInt(10000)
  GlobalKey globalKey = GlobalKey();
  bool st = false;

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary? boundary = globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createFolder();
    bannerSize = AdmobBannerSize.BANNER;
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

  String folderpath = "";

  _createFolder() async {
    final folderName = "nitesh";
    final path = Directory("storage/emulated/0/download/$folderName");
    if ((await path.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");
      path.create();
    }
    folderpath = path.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.ll[widget.index]['Shayari']}",
            maxLines: 1,
            style: TextStyle(
                fontFamily: currentfontfamily,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: st
          ? Column(
              children: [
                Expanded(
                  child: RepaintBoundary(
                    key: globalKey,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: currentbordercolor,
                              width: bordersize,
                              style: BorderStyle.solid),
                          color: currentbg,
                          borderRadius: BorderRadius.circular(borderradius)),
                      child: Text(
                        "${currentfont} \n${widget.ll[widget.index]['Shayari']}\n${currentfont}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: currentfontfamily,
                            fontWeight: FontWeight.bold,
                            fontSize: currentSliderValue,
                            color: currenttc),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showDialog(
                            builder: (context) {
                              return AlertDialog(
                                titlePadding: const EdgeInsets.all(0),
                                contentPadding: const EdgeInsets.all(0),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ColorPicker(
                                        colorPickerWidth: 300,
                                        pickerAreaHeightPercent: 0.7,
                                        pickerAreaBorderRadius:
                                            const BorderRadius.only(
                                          topLeft: Radius.circular(2),
                                          topRight: Radius.circular(2),
                                        ),
                                        pickerColor: currentbordercolor,
                                        onColorChanged: (Color value) {
                                          setState(() {
                                            currentbordercolor = value;
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok"))
                                    ],
                                  ),
                                ),
                              );
                            },
                            context: context);
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            "Border Color",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState1) {
                                return Container(
                                  color: Colors.black,
                                  height: 150,
                                  child: Slider(
                                    value: bordersize,
                                    min: 2,
                                    max: 15,
                                    divisions: 5,
                                    label: bordersize.toString(),
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.red,
                                    onChanged: (value) {
                                      setState(() {
                                        setState1(() {
                                          bordersize = value;
                                        });
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            "Border Size",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState1) {
                                return Container(
                                  color: Colors.black,
                                  height: 150,
                                  child: Slider(
                                    value: borderradius,
                                    min: 10,
                                    max: 180,
                                    label: borderradius.toString(),
                                    divisions: 10,
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.red,
                                    onChanged: (value) {
                                      setState(() {
                                        setState1(() {
                                          borderradius = value;
                                        });
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            "Border Radius",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showDialog(
                            builder: (context) {
                              return AlertDialog(
                                titlePadding: const EdgeInsets.all(0),
                                contentPadding: const EdgeInsets.all(0),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ColorPicker(
                                        colorPickerWidth: 300,
                                        pickerAreaHeightPercent: 0.7,
                                        pickerAreaBorderRadius:
                                            const BorderRadius.only(
                                          topLeft: Radius.circular(2),
                                          topRight: Radius.circular(2),
                                        ),
                                        pickerColor: currentbg,
                                        onColorChanged: (Color value) {
                                          setState(() {
                                            currentbg = value;
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok"))
                                    ],
                                  ),
                                ),
                              );
                            },
                            context: context);
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            "Background",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showDialog(
                            builder: (context) {
                              return AlertDialog(
                                titlePadding: const EdgeInsets.all(0),
                                contentPadding: const EdgeInsets.all(0),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ColorPicker(
                                        colorPickerWidth: 300,
                                        pickerAreaHeightPercent: 0.7,
                                        pickerAreaBorderRadius:
                                            const BorderRadius.only(
                                          topLeft: Radius.circular(2),
                                          topRight: Radius.circular(2),
                                        ),
                                        pickerColor: currenttc,
                                        onColorChanged: (Color value) {
                                          setState(() {
                                            currenttc = value;
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok"))
                                    ],
                                  ),
                                ),
                              );
                            },
                            context: context);
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            "Text Color",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        _capturePng().then((value) {
                          print(value);
                          String iimagename =
                              "nitesh${now.toString().substring(0, 19)}.jpg";
                          String iimagpath = "$folderpath/$iimagename";
                          File file = File(iimagpath);
                          file.writeAsBytes(value);
                          Share.shareFiles(['${file.path}'],
                              text: 'Great picture');
                        });
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            "Share",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Colors.black,
                              height: 200,
                              child: ListView.builder(
                                itemCount: MyFontFamily.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentfontfamily =
                                              MyFontFamily[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.cyanAccent,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            MyFontFamily[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 20),
                                          )));
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            "Font",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Colors.white,
                              height: 200,
                              child: ListView.builder(
                                itemCount: Myemoji.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentfont = Myemoji[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.cyanAccent,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            Myemoji[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17),
                                          )));
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            "Emoji",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState1) {
                                return Container(
                                  color: Colors.black,
                                  height: 150,
                                  child: Slider(
                                    value: currentSliderValue,
                                    min: 10,
                                    max: 30,
                                    divisions: 10,
                                    label: currentSliderValue.toString(),
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.red,
                                    onChanged: (value) {
                                      setState(() {
                                        setState1(() {
                                          currentSliderValue = value;
                                        });
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: AutoSizeText("Text size",
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ))),
                    )),
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
          : Center(
              child: Container(
              height: 150,
              width: 150,
              child: LoadingIndicator(
                indicatorType: Indicator.pacman,
                colors: [Colors.black, Colors.red],
                strokeWidth: 2,
              ),
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
