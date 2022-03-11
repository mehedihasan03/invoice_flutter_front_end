class Category {
  late int cid;
  late String cname;

//<editor-fold desc="Data Methods">

  Category({
    required this.cid,
    required this.cname,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          runtimeType == other.runtimeType &&
          cid == other.cid &&
          cname == other.cname);

  @override
  int get hashCode => cid.hashCode ^ cname.hashCode;

  @override
  String toString() {
    return 'Category{' + ' cid: $cid,' + ' cname: $cname,' + '}';
  }

  Category copyWith({
    int? cid,
    String? cname,
  }) {
    return Category(
      cid: cid ?? this.cid,
      cname: cname ?? this.cname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cid': this.cid,
      'cname': this.cname,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      cid: map['cid'] as int,
      cname: map['cname'] as String,
    );
  }

//</editor-fold>
}
