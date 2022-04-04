class User {
  final String? message;
  final Data? data;
  final int? preferredLocation;
  final String? locationAddress;

  User({this.message, this.data, this.preferredLocation, this.locationAddress});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      message: json['message'],
      data: json['data'] != null ? new Data.fromJson(json['data']) : null,
      preferredLocation: json['preferred_location'],
      locationAddress: json['location_address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['preferred_location'] = this.preferredLocation;
    data['location_address'] = this.locationAddress;
    return data;
  }
}

class Data extends User {
  String? id;
  String? mrn;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  Data(
      {this.id,
      this.mrn,
      this.firstName,
      this.lastName,
      this.email,
      this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mrn = json['mrn'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mrn'] = this.mrn;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
