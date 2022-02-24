class TotalInvoiceCount{

  late int countInvoice;

//<editor-fold desc="Data Methods">

  TotalInvoiceCount({
    required this.countInvoice,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TotalInvoiceCount &&
          runtimeType == other.runtimeType &&
          countInvoice == other.countInvoice);

  @override
  int get hashCode => countInvoice.hashCode;

  @override
  String toString() {
    return 'TotalInvoiceCount{' + ' countInvoice: $countInvoice,' + '}';
  }

  TotalInvoiceCount copyWith({
    int? countInvoice,
  }) {
    return TotalInvoiceCount(
      countInvoice: countInvoice ?? this.countInvoice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countInvoice': this.countInvoice,
    };
  }

  factory TotalInvoiceCount.fromMap(Map<String, dynamic> map) {
    return TotalInvoiceCount(
      countInvoice: map['countInvoice'] as int,
    );
  }

//</editor-fold>
}