// core_logic.dart

// 1. Logic & Config
export 'package:core_logic/src/flavor_config.dart';

// Error handling — semua feature pakai ini
export 'src/error/failure.dart';
export 'src/error/exception.dart';

// Base classes
export 'src/base/base_state.dart';
export 'src/usecase/usecase.dart';
export 'src/constants/nav_constants.dart';
export 'src/entities/user_entity.dart';

// 2. State Management & Tooling
export 'package:equatable/equatable.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:auto_route/auto_route.dart';
export 'package:get_it/get_it.dart';
export 'src/di/service_locator.dart';

export 'package:dartz/dartz.dart' hide order, State;

// 4. DI (Injectable)
export 'package:injectable/injectable.dart' hide Order;