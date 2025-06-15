import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  const AuthRepositoryImp({required this.remoteDatasource});

  @override
  Future<Either<AppFailure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(AppFailure(e.message));
    }
  }
}
