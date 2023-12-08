import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

// credentials oluştur
const _credentials = r'''
{

//DONT FORGET YOUR PRİVATE KEY I delete my private key and some special things
  "type": "service_account",
  "project_id": "flutter-gsheets-407511",
  "client_email": "flutter-gsheets@flutter-gsheets-407511.iam.gserviceaccount.com",
  "client_id": "111564854801296389115",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutter-gsheets-407511.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

//spreadsheet id
const _spreadsheetid = 'Your İD';

void main() async {
  // Gsheets başlat
  final gsheets = GSheets(_credentials);

  //id ile dosyayı çek
  final ss = await gsheets.spreadsheet(_spreadsheetid);

  //gsheets başlığı ile al
  var sheet = ss.worksheetByTitle('Worksheet1');

  //hücrelerden veri çekme
  var getWords = await sheet!.values.allColumns();

  runApp(MyApp(getWords));
}

class MyApp extends StatelessWidget {
  final List<List<String>> getWords;

  const MyApp(this.getWords, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              for (var row in getWords)
                Row(
                  children: [
                    for (var cell in row)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(cell),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
