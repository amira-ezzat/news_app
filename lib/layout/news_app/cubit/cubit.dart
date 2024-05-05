import 'package:chats_app/layout/news_app/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/scienceScreen.dart';
import '../../../modules/news_app/sports/sportScreen.dart';
import '../../../modules/setting/setting_screen.dart';
import '../../../shared/network/remote/dio_helpeer.dart';

class NewsCubit extends Cubit<NewsState>
{
NewsCubit():super(NewsInitialState());

static NewsCubit get(context)=>BlocProvider.of(context);
int currentIndex=0;
List<BottomNavigationBarItem> bottomItem=[
  BottomNavigationBarItem (
      icon: Icon(
        Icons.business_outlined
      ),
    label: 'Business',
  ),
  BottomNavigationBarItem (
    icon: Icon(
        Icons.sports
    ),
    label: 'Sports',
  ),
  BottomNavigationBarItem (
    icon: Icon(
        Icons.science_outlined,
    ),
    label: 'Science',
  ),


];
List<Widget> screens=[
  BusinessScreen(),
  SportScreen(),
  ScienceScreen(),

];
void changeBottomNavBar(int index)
{
  currentIndex=index;
  if(index==1)
    getSports();
  if(index==2)
    getScience();
  emit(NewsBottomNavState());

}
List<dynamic> business=[];
void getBusiness()
{
  emit(NewsBusinessLoadingState());
  DioHelper.getData(
    url: 'v2/top-headlines',
    query:{
      'country':'us',
      'category':'business',
      'apiKey':'5e7aeee60166446182f634efbd43fe3d',
    },
  ).then((value) {
    // print(value.data['articles'][0]['lite le']);
    business=value.data['articles'];
    print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());

  }).catchError( (error){
    print(error.toString());
    emit(NewsGetBusinessErorrState(error.toString()));

  });
}

List<dynamic> sports=[];
void getSports()
{
  emit(NewsSportsLoadingState());
  if(sports.length==0){
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:{
        'country':'us',
        'category':'sports',
        'apiKey':'5e7aeee60166446182f634efbd43fe3d',
      },
    ).then((value) {
      // print(value.data['articles'][0]['lite le']);
      sports=value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());

    }).catchError( (error){
      print(error.toString());
      emit(NewsGetSportsErorrState(error.toString()));

    });
  }else{
    emit(NewsGetSportsSuccessState());
  }

}

List<dynamic> science=[];
void getScience()
{
  emit(NewsScienceLoadingState());
  if(science.length==0){
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:{
        'country':'us',
        'category':'science',
        'apiKey':'5e7aeee60166446182f634efbd43fe3d',
      },
    ).then((value) {
      // print(value.data['articles'][0]['lite le']);
      science=value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());

    }).catchError( (error){
      print(error.toString());
      emit(NewsGetScienceErorrState(error.toString()));

    });
  }else{
    emit(NewsGetScienceSuccessState());
  }

}

List<dynamic> search=[];
void getSearch(String value)
{
  emit(NewsSearchLoadingState());

  DioHelper.getData(
    url: 'v2/everything',
    query:{
      'q':'$value',
      'apiKey':'5e7aeee60166446182f634efbd43fe3d',
    },
  ).then((value) {
    // print(value.data['articles'][0]['lite le']);
    search=value.data['articles'];
    print(search[0]['title']);
    emit(NewsGetSearchSuccessState());

  }).catchError( (error){
    print(error.toString());
    emit(NewsGetSearchErorrState(error.toString()));

  });

}
}

