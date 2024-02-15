import 'package:boubyan_steps/bloc/boubyan_bloc.dart';
import 'package:boubyan_steps/ui/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
        designSize: Size(375, 812),
    builder: (BuildContext context, Widget? child) {
      return BlocProvider(
        create: (context) => BoubyanBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Registration(),
        ),
      );

    }
    );
  }
}