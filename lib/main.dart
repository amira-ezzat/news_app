
import 'package:chats_app/modules/setting/setting_screen.dart';
import 'package:chats_app/shared/bloc_observer.dart';
import 'package:chats_app/shared/compononse/constants.dart';
import 'package:chats_app/shared/cubit/cubit.dart';
import 'package:chats_app/shared/cubit/states.dart';
import 'package:chats_app/shared/network/local/cache_helper.dart';
import 'package:chats_app/shared/network/remote/dio_helpeer.dart';
import 'package:chats_app/shared/styles/colors/themes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_pro/home_screen.dart';

import 'package:hexcolor/hexcolor.dart';

import 'layout/news_app/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = (await CacheHelper.getData(key: 'isDark')) ?? false;
  String? token= await CacheHelper.getData(key: 'token');
  print(token);



  // uId=await CacheHelper.getData(key: 'uId');
  // if(uId != null)
  //   {
  //     widget=SocialLayoutScreen();
  //   }
  //   else {
  //   widget = SocialLoginScreen();
  // }
    runApp(MyApp(
      isDark:isDark

    ));
  }


class MyApp extends StatelessWidget {
  final bool isDark;


  MyApp({required this.isDark});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()),
        BlocProvider(
            create: (BuildContext context) =>
            AppCubit()..changeAppMode(fromShared: isDark)),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,
            darkTheme: darkTheme,
            themeMode:
            AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:SettingScreen(),
          );
        },
      ),
    );
  }
}
