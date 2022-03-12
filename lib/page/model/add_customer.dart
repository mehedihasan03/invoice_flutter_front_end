class AddCustomer {
  late String name;
  late String email;
  late String phone;
  late String address;

//<editor-fold desc="Data Methods">

  AddCustomer({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddCustomer &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          address == other.address);

  @override
  int get hashCode =>
      name.hashCode ^ email.hashCode ^ phone.hashCode ^ address.hashCode;

  @override
  String toString() {
    return 'AddCustomer{' +
        ' name: $name,' +
        ' email: $email,' +
        ' phone: $phone,' +
        ' address: $address,' +
        '}';
  }

  AddCustomer copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return AddCustomer(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'address': this.address,
    };
  }

  factory AddCustomer.fromMap(Map<String, dynamic> map) {
    return AddCustomer(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
    );
  }

//</editor-fold>
}
