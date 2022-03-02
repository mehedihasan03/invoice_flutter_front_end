import 'package:intl/intl.dart';

class Invoice{
  late int id;
  late String customerName;
  late String accountNumber;
  late double totalPrice;
  late String paymentDate;

//<editor-fold desc="Data Methods">

  Invoice({
    required this.id,
    required this.customerName,
    required this.accountNumber,
    required this.totalPrice,
    required this.paymentDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          customerName == other.customerName &&
          accountNumber == other.accountNumber &&
          totalPrice == other.totalPrice &&
          paymentDate == other.paymentDate);

  @override
  int get hashCode =>
      id.hashCode ^
      customerName.hashCode ^
      accountNumber.hashCode ^
      totalPrice.hashCode ^
      paymentDate.hashCode;

  @override
  String toString() {
    return 'Invoice{' +
        ' id: $id,' +
        ' customerName: $customerName,' +
        ' accountNumber: $accountNumber,' +
        ' totalPrice: $totalPrice,' +
        ' paymentDate: $paymentDate,' +
        '}';
  }

  Invoice copyWith({
    int? id,
    String? customerName,
    String? accountNumber,
    double? totalPrice,
    String? paymentDate,
  }) {
    return Invoice(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      accountNumber: accountNumber ?? this.accountNumber,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentDate: paymentDate ?? this.paymentDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'customerName': this.customerName,
      'accountNumber': this.accountNumber,
      'totalPrice': this.totalPrice,
      'paymentDate': this.paymentDate,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] as int,
      customerName: map['customerName'] as String,
      accountNumber: map['accountNumber'] as String,
      totalPrice: map['totalPrice'] as double,
      paymentDate: map['paymentDate'] as String,
    );
  }

//</editor-fold>
}