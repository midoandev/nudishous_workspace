import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsUpdated> {
  SettingsCubit() : super(const ProfileInitial());
}
