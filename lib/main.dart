import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'browser_screen.dart';
import 'browser_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BrowserModel()),
      ],
      child: MaterialApp(
        title: 'JustinBrowser',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BrowserScreen(),
      ),
    );
  }
}
