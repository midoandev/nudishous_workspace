import 'package:core_logic/core_logic.dart';
import 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsUpdated> {
  SettingsCubit() : super(const ProfileInitial());
}
