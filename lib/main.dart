import 'package:hadafo/controller/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hadafo/screen/onboarding.dart';
import 'package:xml2json/xml2json.dart';

void main() async {
  await GetStorage.init();

  const bookshelfXml = '''<?xml version="1.0"?>
    <bookshelf>
      <book>
        <title lang="en">Growing a Language</title>
        <price>29.99</price>
      </book>
      <book>
        <title lang="en">Learning XML</title>
        <price>39.95</price>
      </book>
      <price>132.00</price>
    </bookshelf>''';
    // final document = XmlDocument.parse(bookshelfXml);
    // print(document.toString());
    // print(document.toXmlString(pretty: true, indent: '\t'));

     // Create a client transformer
    final myTransformer = Xml2Json();

    // Parse a simple XML string

    myTransformer.parse(bookshelfXml);

    // Transform to JSON using Badgerfish
    var json = myTransformer.toBadgerfish();
    print('Badgerfish');
    print('');
    print(json);
    print('');
  runApp(const MyApp());
}

// ThemeData darkTheme = ThemeData(
//     accentColor: Colors.red,
//     brightness: Brightness.dark,
//     primaryColor: Colors.amber,
//     buttonTheme: ButtonThemeData(
//       buttonColor: Colors.amber,
//       disabledColor: Colors.grey,
//     ));

// ThemeData lightTheme = ThemeData(
//     accentColor: Colors.pink,
//     brightness: Brightness.light,
//     primaryColor: Colors.blue,
//     buttonTheme: ButtonThemeData(
//       buttonColor: Colors.blue,
//       disabledColor: Colors.grey,
//     ));

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const OnBoarding(),
          binding: AppBinding(),
        )
      ],
    );
  }
}

