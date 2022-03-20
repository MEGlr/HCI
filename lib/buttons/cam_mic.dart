import 'package:first_app/ocr_page.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:first_app/Screens/product_add.dart';

class cam_and_mic extends StatefulWidget {
  @override
  cam_and_mic_state createState() => cam_and_mic_state();
}

class cam_and_mic_state extends State<cam_and_mic> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text =
      'Press the first button and start speaking\n or the second button to scan text';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(
          horizontal: 50.0,
          vertical: 100.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: AppColors.BLUETOOTH.withOpacity(0.7),
        //backgroundColor: Colors.transparent,
        //title: const Text('Add a product to your list',
        //    style: TextStyle(color: Colors.white)),
        content: Flexible(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: AvatarGlow(
                        animate: _isListening,
                        glowColor: Theme.of(context).primaryColor,
                        endRadius: 75.0,
                        duration: const Duration(milliseconds: 2000),
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        repeat: true,
                        child: MaterialButton(
                          onPressed: _listen,
                          color: AppColors.PURPLE,
                          textColor: Colors.white,
                          child: Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            size: 80,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        )))),
            Flexible(
                child: Padding(
                    padding: EdgeInsets.only(top: 10, right: 80),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OCRPage()),
                        );
                      },
                      color: AppColors.PURPLE,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.camera,
                        size: 80,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ))),
            SingleChildScrollView(
                reverse: true,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
                    child: Text(_text,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        )))),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Flexible(
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context, '');
                        /*MaterialPageRoute(
                            builder: (context) => const product_add_page(),
                            settings: RouteSettings(arguments: _text)),
                      );*/
                      },
                      color: AppColors.LIGHT_BLUE,
                      textColor: Colors.white,
                      child: Text('Cancel'),
                      padding: EdgeInsets.all(10))),
              Flexible(
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context, _text);
                        /*MaterialPageRoute(
                            builder: (context) => const product_add_page(),
                            settings: RouteSettings(arguments: _text)),
                      );*/
                      },
                      color: AppColors.BLUE,
                      textColor: Colors.white,
                      child: Text('Confirm Text'),
                      padding: EdgeInsets.all(10))),
            ])
          ],
        )));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
