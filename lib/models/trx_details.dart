class TrxDetails {
  String pOSID;
  String phoneNumber;
  String memo;
  String appliedCharge;
  String appliedVat;
  String totalAmount;

  TrxDetails(
      {this.pOSID,
      this.phoneNumber,
      this.memo,
      this.appliedCharge,
      this.appliedVat,
      this.totalAmount});

  TrxDetails.fromJson(Map<String, dynamic> json) {
    pOSID = json['POSID'];
    phoneNumber = json['Phone Number'];
    memo = json['Memo'];
    appliedCharge = json['AppliedCharge'];
    appliedVat = json['AppliedVat'];
    totalAmount = json['TotalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['POSID'] = this.pOSID;
    data['Phone Number'] = this.phoneNumber;
    data['Memo'] = this.memo;
    data['AppliedCharge'] = this.appliedCharge;
    data['AppliedVat'] = this.appliedVat;
    data['TotalAmount'] = this.totalAmount;
    return data;
  }
}
