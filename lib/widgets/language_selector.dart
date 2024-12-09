import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = "English"; // Default language

  final List<String> _languages = [
    "English",
    "አማርኛ",
    "Afaan Oromo",
    "عربي",
    'French',
    'Somali',
    'Swahili',
    'ትግርኛ',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.language, color: Color(0xFF4525A2)),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          onSelected: (String newValue) {
            setState(() {
              _selectedLanguage = newValue;
            });
          },
          itemBuilder: (BuildContext context) {
            return _languages.map((String language) {
              return PopupMenuItem<String>(
                value: language,
                child: Text(
                  language,
                  style: const TextStyle(
                    color: Color(0xFF4525A2),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            }).toList();
          },
          child: Row(
            children: [
              Text(
                _selectedLanguage,
                style: const TextStyle(
                  color: Color(0xFF4525A2),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xFF4525A2),
              ),
            ],
          ),
          color: Colors.white, // Optional: background color for popup
        ),
      ],
    );
  }
}
