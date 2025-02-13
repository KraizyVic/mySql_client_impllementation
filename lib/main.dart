import 'dart:ui';

import 'package:django1/database/mysql_client.dart';
import 'package:django1/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mysql Client',
      home: HomePage(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*var settings =  ConnectionSettings(
    host: '10.0.2.2',
    port: 3306,
    user: 'root',
    password: 'Exralabs@20',
    db: 'mysqlbbse'
);
Future <void> fromMySql() async{
    try {
      var conn = await MySqlConnection.connect(settings);
      print("Connected to the database");
      var results = await conn.query('SELECT bro_name FROM bros ;');
      if (results.isEmpty) {
        print("No data found");
      } else {
        for (var row in results) {
          print('Name: ${row[0]}');
        }
      }

      await conn.close();
    } catch (e) {
      print('Error: $e');
    }

}*/
/*
PageView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/96be2987-0a06-4942-bb5e-e05a5164759d/devzgw3-5e7cefac-d28c-4abc-a9e4-38ac906a967f.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzk2YmUyOTg3LTBhMDYtNDk0Mi1iYjVlLWUwNWE1MTY0NzU5ZFwvZGV2emd3My01ZTdjZWZhYy1kMjhjLTRhYmMtYTllNC0zOGFjOTA2YTk2N2YuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.8rbXZJKtOZ1Vml2ERJnGaq0LkHGoOeiFX-K7F0rfC4A",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://cdn.aibooru.download/sample/59/54/__matsumoto_rangiku_bleach_generated_by_detoai__sample-59544e466264d85b58cb70b55f8aa340.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://cdn.aibooru.download/sample/d5/d8/__matsumoto_rangiku_bleach_generated_by_lucyla_nenelulucy__sample-d5d826e3a17119366f20eb8289584ae3.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://cdn.aibooru.download/sample/25/46/__matsumoto_rangiku_bleach_generated_by_edosynf__sample-2546ba8627ec826da7a85acb30324761.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
*/