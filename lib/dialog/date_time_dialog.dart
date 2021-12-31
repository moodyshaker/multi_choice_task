import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_choice_task/widgets/input_field.dart';

class DateTimeDialog extends StatefulWidget {
  final Function onSearchCallback;

  DateTimeDialog({@required this.onSearchCallback});

  @override
  _DateTimeDialogState createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  String _dateFrom, _dateTo;
  TextEditingController _dateFromController, _dateToController;
  final GlobalKey<FormState> _formState = GlobalKey();

  @override
  void initState() {
    super.initState();
    _dateFromController = TextEditingController();
    _dateToController = TextEditingController();
  }

  @override
  void dispose() {
    _dateFromController.dispose();
    _dateToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formState,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(
                isRadiusBorder: true,
                readOnly: true,
                labelText: 'من التاريخ',
                controller: _dateFromController,
                isPassword: false,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'من فضلك أدخل من التاريخ';
                  }
                },
                onSaved: (String value) {
                  _dateFrom = value;
                },
                onTap: () async {
                  DateTime dt = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1919),
                    lastDate: DateTime.now(),
                    builder: (BuildContext ctx, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          dialogTheme: DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                            ),
                          ),
                          colorScheme: const ColorScheme.light(
                            primary: Colors.purple,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.purple,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child,
                      );
                    },
                  );
                  if (dt != null) {
                    final dateTime = DateTime(
                      dt.year,
                      dt.month,
                      dt.day,
                    );
                    _dateFrom = DateFormat('yyyy-MM-dd').format(dateTime);
                    _dateFromController.text = _dateFrom;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                isRadiusBorder: true,
                readOnly: true,
                labelText: 'الي التاريخ',
                controller: _dateToController,
                isPassword: false,
                validator: (String value) => (value.isEmpty)
                    ? 'من فضلك أدخل الي التاريخ'
                    : DateTime.parse(_dateFrom).isAfter(DateTime.parse(_dateTo))
                        ? 'تأكد الا يكون من التاريج اكبر من الي التاريخ'
                        : null,
                onSaved: (String value) {
                  _dateTo = value;
                },
                onTap: () async {
                  DateTime dt = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1919),
                    lastDate: DateTime.now(),
                    builder: (BuildContext ctx, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          dialogTheme: DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                            ),
                          ),
                          colorScheme: const ColorScheme.light(
                            primary: Colors.purple,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.purple,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child,
                      );
                    },
                  );
                  if (dt != null) {
                    final dateTime = DateTime(
                      dt.year,
                      dt.month,
                      dt.day,
                    );
                    _dateTo = DateFormat('yyyy-MM-dd').format(dateTime);
                    _dateToController.text = _dateTo;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (_formState.currentState.validate()) {
                    _formState.currentState.save();
                    widget.onSearchCallback(_dateFrom, _dateTo);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'بحث',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
