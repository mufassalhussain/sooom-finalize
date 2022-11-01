class CheckoutCalculate {
  int? statusCode;
  String? msg;
  double? amount;
  double? spipping;
  double? subTotal;
  double? tax;

  CheckoutCalculate(
      {this.statusCode,
      this.msg,
      this.amount,
      this.spipping,
      this.subTotal,
      this.tax});

  CheckoutCalculate.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    msg = json['msg'];
    amount = double.parse(json['amount'].toString());
    spipping = double.parse(json['spipping'].toString());
    subTotal = double.parse(json['sub_total'].toString());
    tax = double.parse(json['tax'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['msg'] = this.msg;
    data['amount'] = this.amount;
    data['spipping'] = this.spipping;
    data['sub_total'] = this.subTotal;
    data['tax'] = this.tax;
    return data;
  }
}
