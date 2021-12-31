import 'dataset.dart';

class Payment {
  int responseCode;
  String responseMessage;
  List<DateSet> dateSet;

  Payment({this.responseCode, this.responseMessage, this.dateSet});

  Payment.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    if (json['dateSet'] != null) {
      dateSet = [];
      json['dateSet'].forEach((v) {
        dateSet.add(DateSet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    if (this.dateSet != null) {
      data['dateSet'] = this.dateSet.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
