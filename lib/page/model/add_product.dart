class AddProduct{
  late String pname;
  late String cname;
  late double price;

//<editor-fold desc="Data Methods">

  AddProduct({
    required this.pname,
    required this.cname,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddProduct &&
          runtimeType == other.runtimeType &&
          pname == other.pname &&
          cname == other.cname &&
          price == other.price);

  @override
  int get hashCode => pname.hashCode ^ cname.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'AddProduct{' +
        ' pname: $pname,' +
        ' cname: $cname,' +
        ' price: $price,' +
        '}';
  }

  AddProduct copyWith({
    String? pname,
    String? cname,
    double? price,
  }) {
    return AddProduct(
      pname: pname ?? this.pname,
      cname: cname ?? this.cname,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pname': this.pname,
      'cname': this.cname,
      'price': this.price,
    };
  }

  factory AddProduct.fromMap(Map<String, dynamic> map) {
    return AddProduct(
      pname: map['pname'] as String,
      cname: map['cname'] as String,
      price: map['price'] as double,
    );
  }

//</editor-fold>
}