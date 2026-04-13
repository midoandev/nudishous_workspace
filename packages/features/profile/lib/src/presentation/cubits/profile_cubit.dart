import 'package:core_logic/core_logic.dart';
import 'package:local_storage/local_storage.dart';
import '../../domain/usecases/get_profile_use_case.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileUpdated> {
  final GetProfileUseCase _getProfileUseCase;
  final PreferenceService _preferenceService;

  ProfileCubit(this._getProfileUseCase, this._preferenceService)
    : super(const ProfileInitial());

  // Dipanggil saat ProfilePage pertama dibuka
  Future<void> checkAndLoad() async {
    final token = await _preferenceService.getToken();

    if (token == null) {
      print('ladf $token');
      emit(const ProfileGuest());
      return;
    }

    await _loadProfile();
  }

  // Dipanggil setelah kembali dari AuthPage
  Future<void> onLoginSuccess() async {
    final token = await _preferenceService.getToken();

    if (token == null) return;
    await _loadProfile();
  }

  Future<void> _loadProfile() async {
    emit(const ProfileLoading());

    final result = await _getProfileUseCase.call();

    result.fold(
      (failure) => switch (failure) {
        UnauthorizedFailure() => emit(const ProfileGuest()),
        _ => emit(ProfileError(failure.message)),
      },
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> logout() async {
    await _preferenceService.clearToken();
    emit(const ProfileGuest());
  }
}
