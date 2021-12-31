import 'trx_details.dart';

class DateSet {
  int id;
  String trxRef;
  int fromEntityId;
  int toEntityId;
  double amount;
  String trxDate;
  String mobileNumber;
  String fullNameAR;
  String fullNameEN;
  String corporateFullNameAR;
  String corporateFullNameEN;
  TrxDetails trxDetails;

  DateSet(
      {this.id,
        this.trxRef,
        this.fromEntityId,
        this.toEntityId,
        this.amount,
        this.trxDate,
        this.mobileNumber,
        this.fullNameAR,
        this.fullNameEN,
        this.corporateFullNameAR,
        this.corporateFullNameEN,
        this.trxDetails});

  DateSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trxRef = json['trxRef'];
    fromEntityId = json['fromEntityId'];
    toEntityId = json['toEntityId'];
    amount = json['amount'];
    trxDate = json['trxDate'];
    mobileNumber = json['mobileNumber'];
    fullNameAR = json['fullNameAR'];
    fullNameEN = json['fullNameEN'];
    corporateFullNameAR = json['corporateFullNameAR'];
    corporateFullNameEN = json['corporateFullNameEN'];
    trxDetails = json['trxDetails'] != null
        ? new TrxDetails.fromJson(json['trxDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trxRef'] = this.trxRef;
    data['fromEntityId'] = this.fromEntityId;
    data['toEntityId'] = this.toEntityId;
    data['amount'] = this.amount;
    data['trxDate'] = this.trxDate;
    data['mobileNumber'] = this.mobileNumber;
    data['fullNameAR'] = this.fullNameAR;
    data['fullNameEN'] = this.fullNameEN;
    data['corporateFullNameAR'] = this.corporateFullNameAR;
    data['corporateFullNameEN'] = this.corporateFullNameEN;
    if (this.trxDetails != null) {
      data['trxDetails'] = this.trxDetails.toJson();
    }
    return data;
  }
}