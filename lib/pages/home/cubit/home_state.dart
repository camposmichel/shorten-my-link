part of 'home_cubit.dart';

class HomeState {
  final List<AliasModel> aliasList;

  HomeState({this.aliasList = const []});

  HomeState copyWith({List<AliasModel>? aliasList}) {
    return HomeState(aliasList: aliasList ?? this.aliasList);
  }
}

class HomeLoadingState extends HomeState {
  HomeLoadingState({required super.aliasList});
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required super.aliasList, required this.message});
}
