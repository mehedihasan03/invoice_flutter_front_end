class Product {
  late int pid;
  late String pname;
  late String cname;
  late double price;
  late int quantity;

//<editor-fold desc="Data Methods">

  Product({
    required this.pid,
    required this.pname,
    required this.cname,
    required this.price,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          pid == other.pid &&
          pname == other.pname &&
          cname == other.cname &&
          price == other.price &&
          quantity == other.quantity);

  @override
  int get hashCode =>
      pid.hashCode ^
      pname.hashCode ^
      cname.hashCode ^
      price.hashCode ^
      quantity.hashCode;

  @override
  String toString() {
    return 'Product{' +
        ' pid: $pid,' +
        ' pname: $pname,' +
        ' cname: $cname,' +
        ' price: $price,' +
        ' quantity: $quantity,' +
        '}';
  }

  Product copyWith({
    int? pid,
    String? pname,
    String? cname,
    double? price,
    int? quantity,
  }) {
    return Product(
      pid: pid ?? this.pid,
      pname: pname ?? this.pname,
      cname: cname ?? this.cname,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': this.pid,
      'pname': this.pname,
      'cname': this.cname,
      'price': this.price,
      'quantity': this.quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      pid: map['pid'] as int,
      pname: map['pname'] as String,
      cname: map['cname'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

//</editor-fold>
}
