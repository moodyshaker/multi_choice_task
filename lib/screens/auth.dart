import 'package:flutter/material.dart';
import 'package:multi_choice_task/provider/main_provider.dart';
import 'package:multi_choice_task/utilits/network_state_enum.dart';
import 'package:multi_choice_task/widgets/account_type.dart';
import 'package:multi_choice_task/widgets/input_field.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Auth extends StatefulWidget {
  static const String id = 'AUTH';

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool _isLogin = true;
  int _selectedItem;
  String _email, _password, _fullName, _accountType;
  TextEditingController _accountTypeController;
  MainProvider _mainProvider;

  @override
  void initState() {
    super.initState();
    _mainProvider = Provider.of<MainProvider>(context, listen: false);
    _accountTypeController = TextEditingController();
  }

  @override
  void dispose() {
    _accountTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100.0,
              width: 100.0,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formState,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InputField(
                          isRadiusBorder: false,
                          key: const ValueKey('email'),
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'البريد الإلكتروني',
                          validator: (String v) => v.isEmpty || v.length < 7
                              ? 'أدخل البريد الإلكتروني بطريقة صحيحة'
                              : null,
                          onSaved: (String v) {
                            _email = v;
                          },
                        ),
                        if (!_isLogin)
                          const SizedBox(
                            height: 12,
                          ),
                        if (!_isLogin)
                          InputField(
                            isRadiusBorder: false,
                            key: const ValueKey('username'),
                            labelText: 'الأسم',
                            keyboardType: TextInputType.text,
                            validator: (String v) => v.isEmpty
                                ? 'أدخل الأسم بطريقة صحيحة'
                                : null,
                            onSaved: (String v) {
                              _fullName = v;
                            },
                          ),
                        const SizedBox(
                          height: 12,
                        ),
                        InputField(
                          isRadiusBorder: false,
                          key: const ValueKey('password'),
                          keyboardType: TextInputType.visiblePassword,
                          labelText: 'كلمة السر',
                          onSaved: (String v) {
                            _password = v;
                          },
                          validator: (String v) => v.isEmpty || v.length < 7
                              ? 'أدخل كلمة السر بطريقة صحيحة'
                              : null,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (!_isLogin)
                          InputField(
                            controller: _accountTypeController,
                            isRadiusBorder: false,
                            key: const ValueKey('accountType'),
                            readOnly: true,
                            labelText: 'نوع الحساب',
                            onSaved: (String v) {
                              _accountType = v;
                            },
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25.0),
                                  topLeft: Radius.circular(25.0),
                                )),
                                builder: (ctx) {
                                  return AccountTypeBottomSheet(
                                    onItemClick: (String item, int i) {
                                      setState(() {
                                        _selectedItem = i;
                                        _accountTypeController.text = item;
                                        Navigator.pop(ctx);
                                      });
                                    },
                                    types: _mainProvider.roles,
                                    selectedItem: _selectedItem,
                                  );
                                },
                              );
                            },
                            validator: (String v) => v.isEmpty
                                ? 'أدخل نوع الحساب'
                                : null,
                            isPassword: false,
                          ),
                        if (!_isLogin)
                          const SizedBox(
                            height: 12,
                          ),
                        Consumer<MainProvider>(
                          builder: (ctx, data, ch) =>
                              data.authState == NetworkState.waiting
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () async {
                                        final FormState currentState =
                                            _formState.currentState;
                                        if (currentState.validate()) {
                                          currentState.save();
                                          if (_isLogin) {
                                            await data.login(
                                                email: _email,
                                                password: _password,
                                                context: context);
                                            if (data.authState ==
                                                NetworkState.success) {
                                              Navigator.pushReplacementNamed(
                                                  context, Home.id);
                                            }
                                          } else {
                                            await data.createNewUser(
                                                context: context,
                                                email: _email,
                                                password: _password,
                                                fullName: _fullName,
                                                roles: [_accountType]);
                                            if (data.authState ==
                                                NetworkState.success) {
                                              setState(() {
                                                _isLogin = true;
                                              });
                                            }
                                          }
                                        }
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: Text(_isLogin ? 'Login' : 'signup'),
                                      // style: ,
                                    ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create new account'
                              : 'already have account'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
