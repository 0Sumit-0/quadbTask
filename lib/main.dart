import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_assignment/detail/screen/detail_screen.dart';
import 'package:quadb_assignment/navigation/build_screen/navigation_bar.dart';
import 'package:quadb_assignment/navigation/providers/navigation_provider.dart';
import 'package:quadb_assignment/search/provider/search_provider.dart';

import 'home/provider/home_provider.dart';
import 'home/screen/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieProvider()..fetchMovies()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
    );
  }
}
