import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/appcolors.dart';

class OCRPage extends StatefulWidget {
  final bool twice;
  const OCRPage({Key? key, this.twice = true}) : super(key: key);
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  bool twice = true;
  int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
  String _text = "Chosen text will appear here";
  @override
  initState() {
    twice = widget.twice;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.VERY_LIGHT_BLUE,
        appBar: AppBar(
            title: const Text('Scan Text',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Rationale")),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: 'go back',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: AppColors.LIGHT_BLUE),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: MaterialButton(
                    onPressed: _read,
                    color: AppColors.PURPLE,
                    textColor: Colors.white,
                    child: Text('Scanning', style: TextStyle(fontSize: 16)),
                    padding: EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    )),
              )),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, _text);
                      if (twice == true) {
                        Navigator.pop(context, _text);
                      }
                    },
                    color: AppColors.BLUE,
                    textColor: Colors.white,
                    child: Text('Confirm', style: TextStyle(fontSize: 16)),
                    padding: EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _ocrCamera,
        waitTap: true,
      );
      setState(() {
        _text = texts[0].value;
      });
    } on Exception {
      texts.add(OcrText('Failed to recognize text'));
    }
  }
}
