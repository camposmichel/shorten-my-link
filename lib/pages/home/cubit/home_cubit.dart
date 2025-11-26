import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorten_my_link/models/link_model.dart';
import 'package:shorten_my_link/services/api_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;

  HomeCubit({ApiService? apiService})
    : apiService = apiService ?? ApiService(),
      super(HomeState()) {
    loadInitialData();
  }

  void loadInitialData() {
    final links = apiService.getLinks();
    emit(state.copyWith(aliasList: links));
  }

  void addLink(String link) async {
    emit(HomeLoadingState(aliasList: state.aliasList));
    final response = await apiService.registerShortLink(link);
    response.fold(_handleError, _handleAliasList);
  }

  void _handleAliasList(AliasModel aliasModel) {
    final List<AliasModel> aliasList = [aliasModel, ...state.aliasList];
    emit(state.copyWith(aliasList: aliasList));
  }

  void _handleError(String message) {
    emit(HomeErrorState(aliasList: state.aliasList, message: message));
  }

  void deleteLink(int index) {
    apiService.deleteLink(state.aliasList[index]);
    final List<AliasModel> updatedList = List.from(state.aliasList)
      ..removeAt(index);
    emit(state.copyWith(aliasList: updatedList));
  }
}
