import 'package:core_logic/core_logic.dart';
import 'sandbox_state.dart';

@singleton
class SandboxCubit extends Cubit<SandboxUpdated> {
  SandboxCubit() : super(const SandboxUpdated([]));

  void tambahBahan(FoodItem item) {
    final newList = List<FoodItem>.from(state.piring)..add(item);
    emit(SandboxUpdated(newList));
  }

  void updatePorsi(String id, double grams) {
    final newList = state.piring.map((item) {
      return item.id == id ? item.copyWith(grams: grams) : item;
    }).toList();
    emit(SandboxUpdated(newList));
  }
}