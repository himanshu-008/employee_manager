import 'package:employment_manager/bloc/employee_bloc.dart';
import 'package:employment_manager/model/employee_model.dart';
import 'package:employment_manager/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/adapters.dart';
import 'home_page.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeModelAdapter()); // register type adapter

  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create:(context)=> EmployeeBloc(),
        child: SafeArea(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: Colors.blue,
              textTheme: const TextTheme(
                  displayLarge: TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold)),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blue, brightness: Brightness.light),
              useMaterial3: true,
              datePickerTheme: const DatePickerThemeData(
                // yearBackgroundColor: WidgetStatePropertyAll(Colors.amber),

                backgroundColor: Colors.white,
               dividerColor: Colors.white,

                inputDecorationTheme: InputDecorationTheme(),
                confirmButtonStyle:  ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(38, 144, 255, 0.77)),
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))))),
                cancelButtonStyle:
                ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(39, 176, 255, 0.15)),
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))))),

              )),
          home: const HomePage(),
          onGenerateRoute: RouteClass.generateRoute,
        ),
            ),
      );
  }
}
