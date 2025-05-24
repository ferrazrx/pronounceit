import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pronounceit/components/record-button.dart';
import 'package:pronounceit/pages/steps/context.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class Speak extends StatefulWidget with WizardStep {
  Speak({super.key});

  @override
  State<Speak> createState() => _SpeakState();
}

class _SpeakState extends State<Speak> {
  SpeechToText speechToText = SpeechToText();
  String phrase = "";
  bool isListening = false;
  bool speechEnabled = false;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    phrase = '';
    isListening = true;
    await speechToText.listen(
      onResult: onSpeechResult,
      localeId: Provider.of<ContextProvider>(context, listen: false).language,
    );
    setState(() {});
  }

  void stopListening() async {
    await speechToText.stop();
    widget.completeStep(true);
    isListening = false;
    setState(() {});
  }

  Future<void> onSpeechResult(SpeechRecognitionResult result) async {
    if (!mounted) return;
    phrase = result.recognizedWords;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appContext = context.watch<ContextProvider>();

    return Padding(
      padding: const EdgeInsets.all(32),
      child: ValueListenableBuilder<bool>(
        valueListenable: widget.isCompleteNotifier,
        builder: (context, isComplete, child) {
          return Container(
            height: 700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: Text("🤭", style: TextStyle(fontSize: 60)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green, // Vibrant blue
                        Colors.lightGreenAccent, // Cyan
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Let's Practice! Record yourself saying:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          appContext.phrase,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.only(top: 25),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: PlayButton(
                          onRecord: startListening,
                          onStop: () {
                            appContext.setSpeakedPhrase(phrase);
                            stopListening();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                AnimatedOpacity(
                  opacity: phrase != '' ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "You said:",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple, // Vibrant blue
                              Colors.pink, // Cyan
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ), // Rounded corners
                        ),
                        padding: EdgeInsets.all(20),
                        child: Text(
                          phrase,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
