import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, User>> currentUser();

  Future<Either<AppFailure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AppFailure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
