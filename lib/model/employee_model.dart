


import 'package:hive/hive.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 0)  // an annotation class model , so that generator knows this should be a TypeAdapter
class EmployeeModel{

  /// Annnote each field you wnat to save with [@HiveField(index)] , the index is an int and each index
  /// should appear once and you shouldn't change it after registering them
  /// In case you change the field name or its datatype or add new field -- rereun the app to see change
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String role;

  @HiveField(2)
  final DateTime startDate;

  @HiveField(3)
  final DateTime endDAte;

  const EmployeeModel(this.name,this.role,this.startDate,this.endDAte);
}