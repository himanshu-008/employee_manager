
part of 'employee_bloc.dart';

sealed class EmployeeEvent extends ReplayEvent{}

final class EmployeeAddRequest extends EmployeeEvent{

  final String name;
  final String role;
  final DateTime startDate;
  final DateTime endDate;

  EmployeeAddRequest({
    required this.name,
    required this.role,
    required this.startDate,
    required this.endDate
  });

}

final class EmployeeDeleteRequest extends EmployeeEvent{

  final String name;
  EmployeeDeleteRequest({
    required this.name,
  });

}

final class EmployeeEditRequest extends EmployeeEvent{

  final String name;
  final String role;
  final DateTime startDate;
  final DateTime endDate;

  EmployeeEditRequest({
    required this.name,
    required this.role,
    required this.startDate,
    required this.endDate
  });

}

final class EmployeeLoadRequest extends EmployeeEvent{

}
