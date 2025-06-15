import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  const AuthRepositoryImp({required this.remoteDatasource});

  @override
  Future<Either<AppFailure, User>> currentUser() async {
    try {
      final user = await remoteDatasource.getCurrentUserData();
      if (user == null) {
        return left(AppFailure("User not logged in!"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(AppFailure(e.message));
    }
  }

  @override
  Future<Either<AppFailure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDatasource.loginWithEmailPassword(
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(AppFailure(e.message));
    }
  }

  @override
  Future<Either<AppFailure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(AppFailure(e.message));
    }
  }
}
