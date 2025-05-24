import 'package:flutter/material.dart';

class ContextProvider extends ChangeNotifier {
  String language = "";
  String phrase = "";
  String speakedPhrase = "";

  void setLanguage(String lang) {
    language = lang;
    notifyListeners();
  }

  void setPhrase(String value) {
    phrase = value;
    notifyListeners();
  }

  void setSpeakedPhrase(String value) {
    speakedPhrase = value;
    notifyListeners();
  }
}
