import 'package:auth/src/presentation/cubits/auth_state.dart';
import 'package:core_logic/core_logic.dart';

@singleton
class AuthCubit extends Cubit<AuthUpdated> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading()); // ← dari BaseState

    // final result = await _loginUseCase(email: email, password: password);
    //
    // result.fold(
    //       (failure) => emit(AuthError(failure.message)), // ← dari BaseState
    //       (user) => emit(AuthAuthenticated()),         // ← spesifik auth
    // );
  }

  Future<void> logout() async {
    // await _logoutUseCase();
    emit(const AuthUnauthenticated()); // ← spesifik auth
  }
}
