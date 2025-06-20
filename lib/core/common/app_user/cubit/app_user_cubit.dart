import 'package:blog_app/core/common/entities/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user) {
    user == null ? emit(AppUserInitial()) : emit(AppUserLoggedIn(user));
  }
}
