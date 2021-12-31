import 'package:flutter/material.dart';
import 'package:multi_choice_task/provider/main_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String id = 'HOME';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MainProvider _mainProvider;

  @override
  void initState() {
    super.initState();
    _mainProvider = Provider.of<MainProvider>(context, listen: false);
    _mainProvider.getHalaPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
