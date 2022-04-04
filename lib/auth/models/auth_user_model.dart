import 'package:nems/auth/models/user_model.dart';

class AuthUser {
  String? refresh;
  String? access;
  User? user;

  AuthUser({this.refresh, this.access, this.user});

  AuthUser.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
