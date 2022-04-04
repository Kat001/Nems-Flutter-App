import 'package:dartz/dartz.dart';
import 'package:nems/auth/models/auth_user_model.dart';
import 'package:nems/auth/models/verify_mrn_model.dart';
import 'package:nems/core/app_error.dart';

abstract class UserRepository {
  Future<Either<AppError, MrnData>> verifyMrn(Map<dynamic, dynamic> data);
  Future<Either<AppError, AuthUser>> loginUser(Map<dynamic, dynamic> data);
}
