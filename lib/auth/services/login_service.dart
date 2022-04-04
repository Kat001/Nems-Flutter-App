import 'package:nems/auth/models/auth_user_model.dart';
import 'package:nems/auth/models/verify_mrn_model.dart';
import 'package:nems/core/api_client.dart';

abstract class LoginUser {
  Future<MrnData> verifyMrn(Map<dynamic, dynamic> data);
  Future<AuthUser> loginUser(Map<dynamic, dynamic> data);
}

class LoginUserImpl extends LoginUser {
  final ApiClient _client;

  LoginUserImpl(this._client);

  @override
  Future<MrnData> verifyMrn(Map<dynamic, dynamic> data) async {
    final response = await _client.post('/auth/verify-mrn/', params: data);
    final mrnData = MrnData.fromJson(response);
    return mrnData;
  }

  @override
  Future<AuthUser> loginUser(Map<dynamic, dynamic> data) async {
    final response = await _client.post('/auth/verify-otp/', params: data);
    final user = AuthUser.fromJson(response);
    return user;
  }
}
