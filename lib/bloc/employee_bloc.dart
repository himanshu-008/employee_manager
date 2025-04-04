import 'dart:convert';
// import 'package:appcms/data/dataprovider/logindata.dart';
// import 'package:appcms/data/repository/login_repositort.dart';
import 'package:employment_manager/model/employee_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:replay_bloc/replay_bloc.dart';

import '../entities/employee.dart';
part 'employee_event.dart';
part 'employee_state.dart';


class EmployeeBloc extends ReplayBloc<EmployeeEvent,EmployeeState>{
  EmployeeBloc(): super(EmployeeInitial()){
    on<EmployeeAddRequest>(_onEmployeeAddRequested);
    on<EmployeeDeleteRequest>(_onEmployeeDeleteRequested);
    on<EmployeeEditRequest>(_onEmployeeEditRequested);
    on<EmployeeLoadRequest>(_onEmployeeLoadRequested);
  }

  // @override
  // void onChange(Change<AuthState> change) {
  //   super.onChange(change);
  //   print(change);
  // }


  @override
  void onTransition(Transition<ReplayEvent,EmployeeState> transition){
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error,StackTrace stackTrace){
    super.onError( error, stackTrace);
    // print('$error - $stackTrace');
  }




  Future<void> _onEmployeeAddRequested(
      EmployeeAddRequest event,
      Emitter<EmployeeState> emit,
      )
  async{
      // emit(EmployeeLoading());

    // try{
      final name = event.name;
      final role = event.role;
      final start = event.startDate;
      final end = event.endDate;

      await Hive.openBox<EmployeeModel>('employee');//cretea a box which is same as table in sql
      //
      Box<EmployeeModel> employeeBox = Hive.box<EmployeeModel>("employee");  //instaance to open and work

      var employeeModelDetails = EmployeeModel(name, role, start, end);

      await employeeBox.put(employeeModelDetails.name, employeeModelDetails);

      List<EmployeeModel> employeeModelList = employeeBox.values.toList();


     return emit(EmployeeAdded(employeeList: employeeModelList));


      // var response = await http.post(Uri.parse(Constant.login),body:{
      //   'name':email,
      //   'password':password
      // });

    //   var data = jsonDecode(response.body);
    //
    //   if(data['name'] == email){
    //     return emit(EmployeeAdd(uid: '${data['name']} - ${data['type']}'));
    //   }
    //   else{
    //     return emit(AuthFailure('Wrong user name and password'));
    //   }
    //
    //   // await Future.delayed(const Duration(seconds: 2),(){
    //   //   return emit (AuthSuccess(uid: '$email-$password'));
    //   // });
    // }catch(e) {
    //   return emit(AuthFailure(e.toString()));
    //  }
  }

  void _onEmployeeDeleteRequested(
      EmployeeDeleteRequest event,
      Emitter<EmployeeState> emit,
      )
  async{
    // emit(EmployeeLoading());

    final name = event.name;
    try{
      await Hive.openBox<EmployeeModel>('employee');//create a box which is same as table in sql
      //
      Box<EmployeeModel> employeeBox = Hive.box<EmployeeModel>("employee");  //instance to open and work



      await employeeBox.delete(name);

      List<EmployeeModel> employeeModelList = employeeBox.values.toList();

    if(employeeModelList.isNotEmpty) {
      return emit(EmployeeDeleted(employeeList: employeeModelList));
    }
    else{

      return emit(EmployeeInitial());
    }
    }catch(e) {
      return emit(EmployeeFailure(e.toString()));
    }
  }

  void _onEmployeeLoadRequested(
      EmployeeLoadRequest event,
      Emitter<EmployeeState> emit,
      )
  async{
    // emit(EmployeeLoading());


    try{
      await Hive.openBox<EmployeeModel>('employee');//create a box which is same as table in sql
      //
      Box<EmployeeModel> employeeBox = Hive.box<EmployeeModel>("employee");  //instance to open and work

      List<EmployeeModel> employeeModelList = employeeBox.values.toList();


      return emit(EmployeeLoaded(employeeList: employeeModelList));

    }catch(e) {
      return emit(EmployeeFailure(e.toString()));
    }
  }

  void _onEmployeeEditRequested(
      EmployeeEditRequest event,
      Emitter<EmployeeState> emit,
      ) async{
    try{
      return emit (EmployeeEdited(uid: "Edited"));
    }
    catch(e){
      return emit(EmployeeFailure(e.toString()));
    }

  }

}