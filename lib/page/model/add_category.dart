class AddCategory{
  late String cname;

//<editor-fold desc="Data Methods">

  AddCategory({
    required this.cname,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddCategory &&
          runtimeType == other.runtimeType &&
          cname == other.cname);

  @override
  int get hashCode => cname.hashCode;

  @override
  String toString() {
    return 'AddCategory{' + ' cname: $cname,' + '}';
  }

  AddCategory copyWith({
    String? cname,
  }) {
    return AddCategory(
      cname: cname ?? this.cname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cname': this.cname,
    };
  }

  factory AddCategory.fromMap(Map<String, dynamic> map) {
    return AddCategory(
      cname: map['cname'] as String,
    );
  }

//</editor-fold>
}