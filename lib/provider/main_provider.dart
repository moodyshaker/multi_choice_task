import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multi_choice_task/dialog/action_dialog.dart';
import 'package:multi_choice_task/models/dataset.dart';
import 'package:multi_choice_task/models/payment.dart';
import 'package:multi_choice_task/storage/shared_preference.dart';
import 'package:multi_choice_task/utilits/const.dart';
import 'package:multi_choice_task/utilits/network_state_enum.dart';

class MainProvider with ChangeNotifier {
  final Dio dio = Dio();
  NetworkState _state;
  NetworkState _authState;
  String _message;
  List<String> _roles;
  Preferences _preferences;
  List<DateSet> _dataSet;
  bool _dataSetIsEmpty;
  int _total;

  List<String> get roles => _roles;

  bool get dataSetIsEmpty => _dataSetIsEmpty;

  List<DateSet> get dataSet => _dataSet;

  NetworkState get state => _state;

  NetworkState get authState => _authState;

  Future<void> initPreferences() async {
    _preferences = Preferences.instance;
    await _preferences.initPref();
  }

  String get token => _preferences.getAccessToken;

  Future<void> logout() async => await _preferences.clearUser();

  Future<void> createNewUser({
    @required String fullName,
    @required String email,
    @required String password,
    @required List<String> roles,
    @required BuildContext context,
  }) async {
    try {
      _authState = NetworkState.waiting;
      notifyListeners();
      _message = '';
      Response r = await dio.post('$baseUrl/api/User/RegisterUser', data: {
        "fullName": fullName,
        "email": email,
        "password": password,
        "roles": roles
      });
      if (r.data['dateSet'] == null) {
        _authState = NetworkState.success;
      } else {
        _authState = NetworkState.error;
        (r.data['dateSet'] as List).forEach((i) => _message += '* $i\n');
        showDialog(
            context: context,
            builder: (context) => ActionDialog(
                  content: _message,
                  approveAction: 'OK',
                  onApproveClick: () {
                    Navigator.pop(context);
                  },
                ));
      }
    } catch (e) {}
    notifyListeners();
  }

  Future<void> login({
    @required String email,
    @required String password,
    @required BuildContext context,
  }) async {
    try {
      _authState = NetworkState.waiting;
      notifyListeners();
      Response r = await dio.post('$baseUrl/api/User/Login', data: {
        "email": email,
        "password": password,
      });
      if (r.data['responseMessage'] != 'invalid Email or password') {
        await _preferences.setAccessToken(r.data['dateSet']['token']);
        _authState = NetworkState.success;
      } else {
        _authState = NetworkState.error;
        showDialog(
            context: context,
            builder: (context) => ActionDialog(
                  content: r.data['responseMessage'],
                  approveAction: 'OK',
                  onApproveClick: () {
                    Navigator.pop(context);
                  },
                ));
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> getHalaPayment() async {
    try {
      _state = NetworkState.waiting;
      Response r = await dio.get('$baseUrl/api/Reports/HalaPayments',
          options: Options(headers: {
            'authorization': 'Bearer ${_preferences.getAccessToken}',
          }));
      if (r.statusCode >= 200 && r.statusCode < 300) {
        _state = NetworkState.success;
        Payment payment = Payment.fromJson(r.data);
        _dataSet = payment.dateSet;
        _dataSetIsEmpty = dataSet.isEmpty;
      } else {
        _state = NetworkState.error;
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  int get total => _total;

  Future<void> getPayment() async {
    _total = 0;
    try {
      _state = NetworkState.waiting;
      Response r = await dio.get('$baseUrl/api/Payment/GetPayment',
          options: Options(headers: {
            'authorization': 'Bearer ${_preferences.getAccessToken}',
          }));
      if (r.statusCode >= 200 && r.statusCode < 300) {
        print(r.data);
        Payment payment = Payment.fromJson(r.data);
        _dataSet = payment.dateSet;
        _dataSet.forEach((t) => _total += t.amount.toInt());
        _dataSetIsEmpty = dataSet.isEmpty;
        _state = NetworkState.success;
      } else {
        _state = NetworkState.error;
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> getRoles() async {
    try {
      _state = NetworkState.waiting;
      Response r = await dio.get(
        '$baseUrl/api/User/GetRoles',
      );
      if (r.statusCode >= 200 && r.statusCode < 300) {
        _state = NetworkState.success;
        print(r.data);
        print(r.data['dateSet']);
        _roles = (r.data['dateSet'] as List).map<String>((e) => e).toList();
      } else {
        _state = NetworkState.error;
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
