import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const GoogleTranslate());
}

class GoogleTranslate extends StatefulWidget {
  const GoogleTranslate({super.key});

  @override
  State<GoogleTranslate> createState() => _GoogleTranslateState();
}

class _GoogleTranslateState extends State<GoogleTranslate> {
  String translated = 'Translation';
  String apiKey = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            title: const Text(
              'Translation',
            ),
            leading: const Icon(Icons.translate),
            centerTitle: true,
          ),
          body: Card(
            margin: EdgeInsets.all(8),
            color: Colors.white60,
            child: ListView(
              children: [
                const Text('English'),
                TextField(
                  decoration: const InputDecoration(hintText: 'Enter Text'),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (text) async {
                    const apiKey = 'Your Api Key';
                    const to = 'tr';
                    final url = Uri.parse(
                      'https://translation.googleapis.com/language/translate/v2'
                      '?q=$text&target=$to&key=$apiKey',
                    );
                    final response = await http.post(url);

                    if (response.statusCode == 200) {
                      final body = json.decode(response.body);
                      final translations = body['data']['translations'] as List;
                      final translation = HtmlEscape().convert(
                        translations.first['translatedText'],
                      );

                      setState(() {
                        translated = translation;
                      });
                    }
                  },
                ),
                const Divider(
                  height: 32,
                  color: Colors.white,
                ),
                Text(
                  translated,
                  style: const TextStyle(fontSize: 30),
                )
              ],
            ),
          )),
    );
  }
}
