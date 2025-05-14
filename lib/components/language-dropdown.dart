import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class LanguageDropdown extends StatefulWidget {
  final SpeechToText speech;
  final Function(String localeId) onLocaleSelected;

  const LanguageDropdown({
    super.key,
    required this.speech,
    required this.onLocaleSelected,
  });

  @override
  LanguageDropdownState createState() => LanguageDropdownState();
}

class LanguageDropdownState extends State<LanguageDropdown> {
  List<LocaleName> _locales = [];
  String? _selectedLocaleId;

  @override
  void initState() {
    super.initState();
    _loadLocales();
  }

  Future<void> _loadLocales() async {
    if (!widget.speech.isAvailable) {
      await widget.speech.initialize();
    }

    final locales = await widget.speech.locales();
    setState(() {
      _locales = locales;
      _selectedLocaleId = locales.first.localeId;
    });

    widget.onLocaleSelected(_selectedLocaleId!);
  }

  @override
  Widget build(BuildContext context) {
    if (_locales.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Language:', style: TextStyle(fontSize: 16)),
          const Text("You just have one language in your system: English"),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Language:', style: TextStyle(fontSize: 16)),
        DropdownButton<String>(
          value: _selectedLocaleId,
          onChanged: (String? newValue) {
            setState(() {
              _selectedLocaleId = newValue!;
            });
            widget.onLocaleSelected(newValue!);
          },
          items:
              _locales.map<DropdownMenuItem<String>>((locale) {
                return DropdownMenuItem<String>(
                  value: locale.localeId,
                  child: Text(locale.name),
                );
              }).toList(),
        ),
      ],
    );
  }
}
