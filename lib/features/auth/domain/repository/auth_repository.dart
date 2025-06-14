import 'package:blog_app/core/error/app_failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AppFailure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
