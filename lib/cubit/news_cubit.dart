// ignore_for_file: avoid_print, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/helper/mode_helper.dart';

import '../helper/dio_helper.dart';
import '../modules/Business.dart';
import '../modules/Science.dart';
import '../modules/Sports.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsStateInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreens(),
    const SportsScreens(),
    const ScienceScreens(),
  ];

  void changingBottomNavBar(int index) {
    currentIndex = index;

    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(ChangingBottomNavBarState());
  }

  bool isDark = false;
  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode({required bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark)
          .then((value) => emit(AppChangeModeState()));
    }
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'top-headlines',
        query: {
          'country': 'us',
          'category': 'business',
          'apiKey': '24fbf4cc4524475997f4773dcaa6a55c',
        },
      ).then((value) {
        business = value.data['articles'];
        print(business[0]['title']);

        emit(NewsGetBusinessSuccessState());
      }).catchError((onError) {
        print(onError.toString());

        emit(NewsGetBusinessErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetBusinessLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        url: 'top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': '24fbf4cc4524475997f4773dcaa6a55c',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.length == 0) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: 'top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': '24fbf4cc4524475997f4773dcaa6a55c',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchingLoadingState());
    DioHelper.getData(
      url: 'everything',
      query: {
        'q': value,
        'apikey': '1fa8a8274fd94f14badadf38da9dd335',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchingSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchingErrorState(error.toString()));
    });
  }
}
