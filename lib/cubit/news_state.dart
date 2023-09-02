part of 'news_cubit.dart';

abstract class NewsState {}

class NewsStateInitial extends NewsState {}

class NewsBottomNavState extends NewsState {}

class ChangingBottomNavBarState extends NewsState {}

class AppChangeModeState extends NewsState {}

class NewsGetBusinessLoadingState extends NewsState {}

class NewsGetBusinessSuccessState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErrorState extends NewsState {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsState {}

class NewsGetScienceSuccessState extends NewsState {}

class NewsGetScienceErrorState extends NewsState {
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchingLoadingState extends NewsState {}

class NewsGetSearchingSuccessState extends NewsState {}

class NewsGetSearchingErrorState extends NewsState {
  final String error;

  NewsGetSearchingErrorState(this.error);
}
