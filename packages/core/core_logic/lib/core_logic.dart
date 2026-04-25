export 'package:core_logic/src/config/flavor_config.dart';

// Base classes
export 'src/base/base_state.dart';
export 'src/constants/nav_constants.dart';
export 'src/di/service_locator.dart';
export 'src/di/logic_configurator.dart';
export 'src/error/exception.dart';
// Error handling — semua feature pakai ini
export 'src/error/failure.dart';

export 'src/domain/usecase/usecase.dart';
export 'src/domain/usecase/get_daily_nutrition_usecase.dart';
export 'src/domain/usecase/search_food_use_case.dart';
export 'src/domain/usecase/add_meal_use_case.dart';

export 'src/services/app_info_service.dart';

export 'src/domain/repositories/meal_repository.dart';
export 'src/domain/repositories/food_repository.dart';

export 'src/domain/entities/food_entity.dart';
export 'src/domain/entities/daily_nutrition_entity.dart';
export 'src/domain/entities/meal_log_entity.dart';
export 'src/domain/entities/user_entity.dart';
export 'src/domain/entities/meal_group.dart';
export 'src/domain/entities/meal_type.dart';
