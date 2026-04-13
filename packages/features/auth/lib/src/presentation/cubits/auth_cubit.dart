import 'package:core_logic/core_logic.dart';
import 'package:local_storage/local_storage.dart';

import '../../../auth.dart';
import '../../domain/usecases/login_usecase.dart';

@singleton
class AuthCubit extends Cubit<AuthUpdated> {
  final LoginUseCase _loginUseCase;
  final PreferenceService _preferenceService;

  AuthCubit(
      this._loginUseCase,
      this._preferenceService,
      ) : super(const AuthLoginInitial());

  String get title => state == AuthLoginInitial() ? 'Masuk' : 'Daftar';

  void changePage() {
    emit(state == AuthRegisterInitial() ? const AuthLoginInitial() : const AuthRegisterInitial());
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await _loginUseCase.call(
      email: email,
      password: password,
    );
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(const AuthAuthenticated()), // token sudah disimpan di repo
    );
  }

  Future<void> logout() async {
    await _preferenceService.clearToken();
    emit(const AuthUnauthenticated());
  }
}