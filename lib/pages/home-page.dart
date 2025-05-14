import 'package:flutter/material.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';
import 'package:pronounceit/components/language-dropdown.dart';
import 'package:pronounceit/requests.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  SpeechToText speechToText = SpeechToText();
  Stream<String>? responseStream;
  bool isListening = false;
  bool speechEnabled = false;
  String phrase = '';
  String locale = "en_US";
  StringBuffer buffer = StringBuffer();
  TextEditingController text1Controller = TextEditingController(
    text: "The flu clinic had seen many cases of infectious disease.",
  );
  TextEditingController text2Controller = TextEditingController(text: "");

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
    buffer.clear();
    isListening = true;
    await speechToText.listen(onResult: onSpeechResult, localeId: locale);
    setState(() {});
  }

  void stopListening() async {
    await speechToText.stop();
    responseStream = await fetchComparison(
      "The flu clinic had seen many cases of infectious disease.",
      phrase,
      locale,
    );
    isListening = false;
    setState(() {});
  }

  Future<void> onSpeechResult(SpeechRecognitionResult result) async {
    phrase = result.recognizedWords;
    text2Controller.text = result.recognizedWords;
    setState(() {});
  }

  void onLocaleSelected(String newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LanguageDropdown(
              speech: speechToText,
              onLocaleSelected: onLocaleSelected,
            ),
            Divider(),
            Container(
              child: Text("Say the following phrase:"),
              padding: EdgeInsets.only(bottom: 10),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: text1Controller,
                    maxLines: 5,
                    onChanged: (string) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: "Correct Phrase:",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Container(width: 5),
                Expanded(
                  child: TextField(
                    controller: text2Controller,
                    maxLines: 5,
                    onChanged: (string) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: "You said:",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Center(
              child: PrettyDiffText(
                textAlign: TextAlign.center,
                oldText: text1Controller.text,
                newText: text2Controller.text,
              ),
            ),
            Divider(),
            Visibility(
              visible: !isListening,
              child: StreamBuilder<String>(
                stream: responseStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    buffer.write(snapshot.data);
                  }
                  return SingleChildScrollView(child: Text(buffer.toString()));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: speechToText.isNotListening ? startListening : stopListening,
        tooltip: 'Listen',
        child: Icon(speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
