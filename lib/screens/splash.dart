import 'package:flutter/material.dart';
import 'package:multi_choice_task/provider/main_provider.dart';
import 'package:multi_choice_task/screens/auth.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  static const String id = 'SPLASH';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  MainProvider _mainProvider;

  @override
  void initState() {
    super.initState();
    _mainProvider = Provider.of<MainProvider>(context, listen: false);
    _mainProvider.getRoles();
    init();
    Future.delayed(const Duration(seconds: 1), () {
      _mainProvider.token.isNotEmpty
          ? Navigator.pushReplacementNamed(context, Home.id)
          : Navigator.pushReplacementNamed(context, Auth.id);
    });
  }

  void init() async {
    await _mainProvider.initPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor, body: Container());
  }
}
