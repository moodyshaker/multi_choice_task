import 'package:flutter/material.dart';
import 'package:multi_choice_task/screens/splash.dart';
import 'package:provider/provider.dart';
import 'provider/main_provider.dart';
import 'screens/home.dart';
import 'screens/auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainProvider(),
      child: MaterialApp(
        title: 'MultiChoiceTask',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Splash.id,
        debugShowCheckedModeBanner: false,
        routes: {
          Home.id: (context) => Home(),
          Splash.id: (context) => Splash(),
          Auth.id: (context) => Auth(),
        },
      ),
    );
  }
}
