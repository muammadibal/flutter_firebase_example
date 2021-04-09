import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_login/models/models.dart';
import 'package:firebase_login/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signUp(String email, String password,String name, String address) async {
    ResultValue result = await AuthServices.signUp(email, password, name, address);

    if(result.value != null) {
      emit(UserLoaded(user: result.value));
    } else {
      emit(UserLoadingFailed(message: result.message));
    }
  }

  Future<void> signIn(String email, String password) async {
    ResultValue result = await AuthServices.signIn(email, password);

    if(result.value != null) {
      emit(UserLoaded(user: result.value));
    } else {
      emit(UserLoadingFailed(message: result.message));
    }

  }

  Future<void> signOut() async {
    await AuthServices.signOut();
  }
}
