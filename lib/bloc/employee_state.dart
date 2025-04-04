part of 'employee_bloc.dart';


sealed class EmployeeState{}

final class EmployeeInitial extends EmployeeState{}

final class EmployeeAdded extends EmployeeState{
  final List<EmployeeModel> employeeList;
 EmployeeAdded({
    required this.employeeList
  });

}

final class EmployeeEdited extends EmployeeState{
  final String uid;
  EmployeeEdited({
    required this.uid
  });

}

final class EmployeeDeleted extends EmployeeState{
  final List<EmployeeModel> employeeList;
  EmployeeDeleted({
    required this.employeeList
  });
}


final class EmployeeFailure extends EmployeeState{
  final String uid;
  EmployeeFailure(this.uid);
}

final class EmployeeLoaded extends EmployeeState{
  final List<EmployeeModel> employeeList;
  EmployeeLoaded({
    required this.employeeList
  });

}

// final class EmployeeLoading extends EmployeeState{
//
// }