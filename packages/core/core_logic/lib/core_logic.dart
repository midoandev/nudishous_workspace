export 'package:core_logic/src/base_state.dart';
export 'package:core_logic/src/flavor_config.dart';

export 'package:equatable/equatable.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

export 'package:auto_route/auto_route.dart';

export 'package:get_it/get_it.dart';
export 'src/di/service_locator.dart';

// sembunyikan Order dari dartz karena konflik dengan injectable
export 'package:dartz/dartz.dart' hide order;

// atau sembunyikan dari injectable jika tidak pakai @Order
export 'package:injectable/injectable.dart' hide Order;