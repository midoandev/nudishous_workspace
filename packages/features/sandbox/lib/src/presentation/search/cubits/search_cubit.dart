import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox/src/domain/usecase/search_food_use_case.dart';

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
      emit(results.isEmpty ? SearchEmpty(query) : SearchLoaded(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}