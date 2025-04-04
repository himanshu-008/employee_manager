import 'package:flutter/material.dart';

import 'employee_screen.dart';


class RouteClass {

  static const String  employeeScreen= "/employeeDetailsScreen";
  RouteClass._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case employeeScreen:
      //var notificationArgument = settings.arguments;
        return MaterialPageRoute(builder: (_) => const EmployeeScreen());
      default:
        throw const FormatException("Route not Found");
    }
  }
}
