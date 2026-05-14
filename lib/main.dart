import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'pages/login_page.dart';

void main() {

  runApp(

    DevicePreview(

      enabled: true,

      builder: (context) =>
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      useInheritedMediaQuery: true,

      locale:
      DevicePreview.locale(context),

      builder:
      DevicePreview.appBuilder,

      title: 'PBM App',

      theme: ThemeData(

        useMaterial3: true,

        scaffoldBackgroundColor:
        const Color(0xFFF6F7FB),

        fontFamily: 'Poppins',

        colorScheme:
        ColorScheme.fromSeed(

          seedColor:
          const Color(0xFF5B67F1),
        ),
      ),

      home: const LoginPage(),
    );
  }
}