import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogIn implements Usecase<User, UserLogInParams> {
  final AuthRepository authRepository;

  const UserLogIn(this.authRepository);

  @override
  Future<Either<AppFailure, User>> call(UserLogInParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLogInParams {
  final String email;
  final String password;

  UserLogInParams({required this.email, required this.password});
}
