import 'package:auth/src/presentation/cubits/auth_state.dart';
import 'package:core_logic/core_logic.dart';

class AuthCubit extends Cubit<AuthUpdated> {
  AuthCubit() : super(AuthUpdated());
}
