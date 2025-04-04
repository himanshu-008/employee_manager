import 'package:employment_manager/bloc/employee_bloc.dart';
import 'package:employment_manager/employee_edit_page.dart';
import 'package:employment_manager/model/employee_model.dart';
import 'package:employment_manager/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:replay_bloc/replay_bloc.dart';

import 'employee_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

// final _newBloc = EmployeeBloc();

  static const List<String> shortMonths = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  String formatShortDate(DateTime date) {
    final String month = shortMonths[date.month - DateTime.january];
    return '${date.day} $month, ${date.year}';
  }
   List<EmployeeModel> emp = [];

  void openDatabase() async{
     await Hive.openBox<EmployeeModel>('employee');
     Box<EmployeeModel> employeeBox = Hive.box<EmployeeModel>("employee");  //instaance to open and work

     List<EmployeeModel> employeeModelList = employeeBox.values.toList();
     emp = employeeModelList;

  }

  @override
  void initState() {
    // TODO: implement initState
    //  _newBloc.add(EmployeeLoadRequest());
    openDatabase();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Employment List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
              listener: (context, state) {
                if (state is EmployeeDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(

                content: const Text(" Employee data has been deleted"),
                action: SnackBarAction(label: 'Undo',textColor: Colors.white, onPressed: context.read<EmployeeBloc>().undo),));
        }

        if(state is EmployeeAdded){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(" Employee Added")));
        }


      }, builder: (context, state) {
         if (state is EmployeeAdded) {

          //Key key = const Key("first");
          return Stack(
              // alignment: Alignment.bottomLeft,
              fit: StackFit.passthrough,

              children:[
                SingleChildScrollView(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.grey.shade100,child: const Text("Current employees",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                    for (int i = 0; i < state.employeeList.length; i++) ...[
                      if(state.employeeList[i].endDAte.isAfter(DateTime.now()) ) ...[
                        Dismissible(
                          confirmDismiss: (direction) async {
                            if(direction == DismissDirection.endToStart){
                              context
                                  .read<EmployeeBloc>()
                                  .add(EmployeeDeleteRequest(name: state.employeeList[i].name));
                            }
                            else{
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> EmployeeEditPage(
                                    argument: EmployeeModel(
                                      state.employeeList[i].name,
                                      state.employeeList[i].role,
                                      state.employeeList[i].startDate,
                                      state.employeeList[i].endDAte, ),))
                              );
                            }
                            return null;

                          },
                          background: Container(
                            color: Colors.green,
                            child: const Padding(
                              padding:  EdgeInsets.only(left: 10),
                              child:  Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.edit,color:Colors.white),

                              ),
                            ),
                          ),
                          secondaryBackground:Container(
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child:  Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete,color:Colors.white),

                              ),
                            ),
                          ),
                          key: Key(state.employeeList[i].name),
                          child: ListTile(
                            title: Text(state.employeeList[i].name),
                            isThreeLine: true,
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text(state.employeeList[i].role),
                                  Text("From ${formatShortDate(state.employeeList[i].startDate)}",style: const TextStyle(fontSize: 12),),
                                ] ),
                          ),

                        ),
                      ],
                    ],
                    Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.grey.shade100,child: const Text("Previous employees",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                    for (int i = 0; i < state.employeeList.length; i++) ...[
                      if(state.employeeList[i].endDAte.isBefore(DateTime.now()) ) ...[
                        Dismissible(
                          confirmDismiss: (direction) async {
                            if(direction == DismissDirection.endToStart){
                              context
                                  .read<EmployeeBloc>()
                                  .add(EmployeeDeleteRequest(name: state.employeeList[i].name));
                            }
                            else{
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> EmployeeEditPage(
                                    argument: EmployeeModel(
                                      state.employeeList[i].name,
                                      state.employeeList[i].role,
                                      state.employeeList[i].startDate,
                                      state.employeeList[i].endDAte, ),)
                                  )
                              );
                            }
                            return null;

                          },
                          background: Container(
                            color: Colors.green,
                            child: const Padding(
                              padding:  EdgeInsets.only(left: 10),
                              child:  Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.edit,color:Colors.white),

                              ),
                            ),
                          ),
                          secondaryBackground:Container(
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child:  Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete,color:Colors.white),

                              ),
                            ),
                          ),
                          key: Key(state.employeeList[i].name),
                          child: ListTile(
                            title: Text(state.employeeList[i].name),
                            isThreeLine: true,
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text(state.employeeList[i].role),
                                  Text("${formatShortDate(state.employeeList[i].startDate)} - ${formatShortDate(state.employeeList[i].endDAte)}",style: const TextStyle(fontSize: 12),),
                                ] ),
                          ),

                        ),
                      ],
                    ],


                  ],
                ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      padding: const EdgeInsets.all(10),
                      child: const Text('Swipe left to delete')
                  ),
                ),

              ]


          );
        }
        else if (state is EmployeeLoaded) {
          //Key key = const Key("first");
          if (state.employeeList.isNotEmpty){
            return Stack(
              // alignment: Alignment.bottomLeft,
                fit: StackFit.passthrough,

                children:[
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            padding: EdgeInsets.all(15),
                            color: Colors.grey.shade100,child: const Text("Current employees",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                        for (int i = 0; i < state.employeeList.length; i++) ...[
                          if(state.employeeList[i].endDAte.isAfter(DateTime.now()) ) ...[
                            Dismissible(
                              confirmDismiss: (direction) async {
                                if(direction == DismissDirection.endToStart){
                                  context
                                      .read<EmployeeBloc>()
                                      .add(EmployeeDeleteRequest(name: state.employeeList[i].name));
                                }
                                else{
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> EmployeeEditPage(
                                        argument: EmployeeModel(
                                          state.employeeList[i].name,
                                          state.employeeList[i].role,
                                          state.employeeList[i].startDate,
                                          state.employeeList[i].endDAte, ),))
                                  );
                                }
                                return null;

                              },
                              background: Container(
                                color: Colors.green,
                                child: const Padding(
                                  padding:  EdgeInsets.only(left: 10),
                                  child:  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.edit,color:Colors.white),

                                  ),
                                ),
                              ),
                              secondaryBackground:Container(
                                color: Colors.red,
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child:  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.delete,color:Colors.white),

                                  ),
                                ),
                              ),
                              key: Key(state.employeeList[i].name),
                              child: ListTile(
                                title: Text(state.employeeList[i].name),
                                isThreeLine: true,
                                subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Text(state.employeeList[i].role),
                                      Text("From ${formatShortDate(state.employeeList[i].startDate)}",style: const TextStyle(fontSize: 12),),
                                    ] ),
                              ),

                            ),
                          ],
                        ],
                        Container(
                            padding: EdgeInsets.all(15),
                            color: Colors.grey.shade100,child: const Text("Previous employees",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                        for (int i = 0; i < state.employeeList.length; i++) ...[
                          if(state.employeeList[i].endDAte.isBefore(DateTime.now()) ) ...[
                            Dismissible(
                              confirmDismiss: (direction) async {
                                if(direction == DismissDirection.endToStart){
                                  context
                                      .read<EmployeeBloc>()
                                      .add(EmployeeDeleteRequest(name: state.employeeList[i].name));
                                }
                                else{
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> EmployeeEditPage(
                                        argument: EmployeeModel(
                                          state.employeeList[i].name,
                                          state.employeeList[i].role,
                                          state.employeeList[i].startDate,
                                          state.employeeList[i].endDAte, ),)
                                      )
                                  );
                                }
                                return null;

                              },
                              background: Container(
                                color: Colors.green,
                                child: const Padding(
                                  padding:  EdgeInsets.only(left: 10),
                                  child:  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.edit,color:Colors.white),

                                  ),
                                ),
                              ),
                              secondaryBackground:Container(
                                color: Colors.red,
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child:  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.delete,color:Colors.white),

                                  ),
                                ),
                              ),
                              key: Key(state.employeeList[i].name),
                              child: ListTile(
                                title: Text(state.employeeList[i].name),
                                isThreeLine: true,
                                subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Text(state.employeeList[i].role),
                                      Text("${formatShortDate(state.employeeList[i].startDate)} - ${formatShortDate(state.employeeList[i].endDAte)}",style: const TextStyle(fontSize: 12),),
                                    ] ),
                              ),

                            ),
                          ],
                        ],


                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.grey.shade200),
                        padding: const EdgeInsets.all(10),
                        child: const Text('Swipe left to delete')
                    ),
                  ),

                ]


            );
        }
          else{

            return ListView(

              // mainAxisAlignment: MainAxisAlignment.center,
              children:  const [

                Image(image: AssetImage("./lib/assets/emp.png"),height: 400,width: 400,),
                Center(
                    child: Text(
                      "No employee records found",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),

              ],
            );
          }
        }
        else if (state is EmployeeDeleted) {
          //Key key = const Key("first");
          return Stack(
            // alignment: Alignment.bottomLeft,
              fit: StackFit.passthrough,

              children:[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          padding: EdgeInsets.all(15),
                          color: Colors.grey.shade100,child: const Text("Current employees",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                      for (int i = 0; i < state.employeeList.length; i++) ...[
                        if(state.employeeList[i].endDAte.isAfter(DateTime.now()) ) ...[
                          Dismissible(
                            confirmDismiss: (direction) async {
                              if(direction == DismissDirection.endToStart){
                                context
                                    .read<EmployeeBloc>()
                                    .add(EmployeeDeleteRequest(name: state.employeeList[i].name));
                              }
                              else{
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> EmployeeEditPage(
                                      argument: EmployeeModel(
                                        state.employeeList[i].name,
                                        state.employeeList[i].role,
                                        state.employeeList[i].startDate,
                                        state.employeeList[i].endDAte, ),))
                                );
                              }
                              return null;

                            },
                            background: Container(
                              color: Colors.green,
                              child: const Padding(
                                padding:  EdgeInsets.only(left: 10),
                                child:  Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.edit,color:Colors.white),

                                ),
                              ),
                            ),
                            secondaryBackground:Container(
                              color: Colors.red,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child:  Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete,color:Colors.white),

                                ),
                              ),
                            ),
                            key: Key(state.employeeList[i].name),
                            child: ListTile(
                              title: Text(state.employeeList[i].name),
                              isThreeLine: true,
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Text(state.employeeList[i].role),
                                    Text("From ${formatShortDate(state.employeeList[i].startDate)}",style: const TextStyle(fontSize: 12),),
                                  ] ),
                            ),

                          ),
                        ],
                      ],
                      Container(
                          padding: EdgeInsets.all(15),
                          color: Colors.grey.shade100,child: const Text("Previous employees",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                      for (int i = 0; i < state.employeeList.length; i++) ...[
                        if(state.employeeList[i].endDAte.isBefore(DateTime.now()) ) ...[
                          Dismissible(
                            confirmDismiss: (direction) async {
                              if(direction == DismissDirection.endToStart){
                                context
                                    .read<EmployeeBloc>()
                                    .add(EmployeeDeleteRequest(name: state.employeeList[i].name));
                              }
                              else{
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> EmployeeEditPage(
                                      argument: EmployeeModel(
                                        state.employeeList[i].name,
                                        state.employeeList[i].role,
                                        state.employeeList[i].startDate,
                                        state.employeeList[i].endDAte, ),)
                                    )
                                );
                              }
                              return null;

                            },
                            background: Container(
                              color: Colors.green,
                              child: const Padding(
                                padding:  EdgeInsets.only(left: 10),
                                child:  Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.edit,color:Colors.white),

                                ),
                              ),
                            ),
                            secondaryBackground:Container(
                              color: Colors.red,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child:  Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete,color:Colors.white),

                                ),
                              ),
                            ),
                            key: Key(state.employeeList[i].name),
                            child: ListTile(
                              title: Text(state.employeeList[i].name),
                              isThreeLine: true,
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Text(state.employeeList[i].role),
                                    Text("${formatShortDate(state.employeeList[i].startDate)} - ${formatShortDate(state.employeeList[i].endDAte)}",style: const TextStyle(fontSize: 12),),
                                  ] ),
                            ),

                          ),
                        ],
                      ],


                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      padding: const EdgeInsets.all(10),
                      child: const Text('Swipe left to delete')
                  ),
                ),

              ]


          );
        }
        else if (state is EmployeeInitial) {

          if(kIsWeb) {
            if (emp.isEmpty) {
              return ListView(

                // mainAxisAlignment: MainAxisAlignment.center,
                children:  const [

                  Image(image: AssetImage("./lib/assets/emp.png"),height: 400,width: 400,),
                  Center(
                      child: Text(
                        "No employee records found",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),

                ],
              );
            }
          }
          else {
            context
                .read<EmployeeBloc>()
                .add(EmployeeLoadRequest());
          }
        }
        return ListView(

          // mainAxisAlignment: MainAxisAlignment.center,
          children:  const [

            Image(image: AssetImage("./lib/assets/emp.png"),height: 400,width: 400,),
            Center(
                child: Text(
                  "No employee records found",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),


          ],
        );
        // return ListView(
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   children: const [
        //      Image(image: AssetImage("./lib/assets/emp.png")),
        //      Center(
        //         child: Text(
        //       "No employee records found",
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     )),
        //   ],
        // );
      }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteClass.employeeScreen);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),


    );
  }
}
