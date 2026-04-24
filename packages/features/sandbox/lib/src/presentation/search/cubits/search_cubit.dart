import 'package:core_logic/core_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'search_state.dart';


@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchFoodUseCase _searchFood;

  SearchCubit(this._searchFood) : super(SearchInitial());

  Future<void> onSearchChanged(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await _searchFood.execute(query);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}