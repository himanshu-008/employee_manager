import 'package:employment_manager/bloc/employee_bloc.dart';
import 'package:employment_manager/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './start_date_pick.dart' as dp;
import './end_date_pick.dart' as end_dp;

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  TextEditingController employeeName = TextEditingController();

  TextEditingController employeeRole = TextEditingController();

  TextEditingController addDate = TextEditingController();

  TextEditingController endDate = TextEditingController();

  DateTime? _changeDate = DateTime.now();

  var _startDate;

  var _endDate;



  DateTime? buttonDate;


 dp.DatePickerDialog start =    dp.DatePickerDialog(
   firstDate: DateTime(1970),
   lastDate: DateTime(2100),
   helpText: "",
   confirmText: "Save",
   cancelText: "Cancel",
   initialEntryMode:
   DatePickerEntryMode.calendarOnly,
   // initialDate: _changeDate,
   //  handleDate: buttonDate,

   // customWidgets:
   // Column(
   //   children: [
   //     Padding(
   //       padding: const EdgeInsets.only(
   //           top: 10, left: 20, right: 20),
   //       child: Row(
   //         children: [
   //           Expanded(
   //               child: ElevatedButton(
   //             onPressed: () {
   //                setState(() {
   //                  buttonDate = DateTime.now();
   //                });
   //              //  print(buttonDate);
   //             },
   //             style: const ButtonStyle(
   //                 // backgroundColor:
   //                 //     WidgetStatePropertyAll(
   //                 //         Color.fromRGBO(39,
   //                 //             176, 255, 0.15)),
   //                 shape: WidgetStatePropertyAll(
   //                     ContinuousRectangleBorder(
   //                         borderRadius:
   //                             BorderRadius.all(
   //                                 Radius.circular(
   //                                     10))))),
   //             child: const Text("Today"),
   //           )),
   //           const SizedBox(
   //             width: 50,
   //           ),
   //           Expanded(
   //             child: ElevatedButton(
   //               onPressed: () {
   //
   //               },
   //               style: const ButtonStyle(
   //                   // backgroundColor:
   //                   //     WidgetStatePropertyAll(
   //                   //         Color.fromRGBO(
   //                   //             39,
   //                   //             176,
   //                   //             255,
   //                   //             0.15)),
   //                   shape: WidgetStatePropertyAll(
   //                       ContinuousRectangleBorder(
   //                           borderRadius:
   //                               BorderRadius.all(
   //                                   Radius.circular(
   //                                       10))))),
   //               child:
   //                   const Text("Next Monday"),
   //             ),
   //           ),
   //         ],
   //       ),
   //     ),
   //     const SizedBox(
   //       height: 10,
   //     ),
   //     Padding(
   //       padding: const EdgeInsets.only(
   //           top: 10, left: 20, right: 20),
   //       child: Row(
   //         children: [
   //           Expanded(
   //               child: ElevatedButton(
   //                   onPressed: () {},
   //                   style: const ButtonStyle(
   //                       // backgroundColor:
   //                           // WidgetStatePropertyAll(
   //                           //     Color.fromRGBO(
   //                           //         39,
   //                           //         176,
   //                           //         255,
   //                           //         0.15)),
   //                       shape: WidgetStatePropertyAll(
   //                           ContinuousRectangleBorder(
   //                               borderRadius: BorderRadius
   //                                   .all(Radius
   //                                       .circular(
   //                                           10))))),
   //                   child: const Text(
   //                     "Next Tuesday",
   //                     style: TextStyle(),
   //                   ))),
   //           const SizedBox(
   //             width: 50,
   //           ),
   //           Expanded(
   //               child: ElevatedButton(
   //                   onPressed: () {},
   //                   style: const ButtonStyle(
   //                       // backgroundColor:
   //                           // WidgetStatePropertyAll(
   //                           //     Color.fromRGBO(
   //                           //         39,
   //                           //         176,
   //                           //         255,
   //                           //         0.15)),
   //                       shape: WidgetStatePropertyAll(
   //                           ContinuousRectangleBorder(
   //                               borderRadius:
   //                                   BorderRadius.all(
   //                                       Radius.circular(
   //                                           10))))),
   //                   child:
   //                       const Text("Next Week"))),
   //         ],
   //       ),
   //     ),
   //   ],
   // ),
 );


 end_dp.DatePickerDialog end = end_dp.DatePickerDialog(

   firstDate: DateTime.now(),
   lastDate: DateTime(2100),
   helpText: "",
   confirmText: "Save",
   cancelText: "Cancel",
   initialEntryMode:
   DatePickerEntryMode.calendarOnly,
   // initialDate: _changeDate,
   //  handleDate: buttonDate,

   // customWidgets:
   // Column(
   //   children: [
   //     Padding(
   //       padding: const EdgeInsets.only(
   //           top: 10, left: 20, right: 20),
   //       child: Row(
   //         children: [
   //           Expanded(
   //               child: ElevatedButton(
   //             onPressed: () {
   //                setState(() {
   //                  buttonDate = DateTime.now();
   //                });
   //              //  print(buttonDate);
   //             },
   //             style: const ButtonStyle(
   //                 // backgroundColor:
   //                 //     WidgetStatePropertyAll(
   //                 //         Color.fromRGBO(39,
   //                 //             176, 255, 0.15)),
   //                 shape: WidgetStatePropertyAll(
   //                     ContinuousRectangleBorder(
   //                         borderRadius:
   //                             BorderRadius.all(
   //                                 Radius.circular(
   //                                     10))))),
   //             child: const Text("Today"),
   //           )),
   //           const SizedBox(
   //             width: 50,
   //           ),
   //           Expanded(
   //             child: ElevatedButton(
   //               onPressed: () {
   //
   //               },
   //               style: const ButtonStyle(
   //                   // backgroundColor:
   //                   //     WidgetStatePropertyAll(
   //                   //         Color.fromRGBO(
   //                   //             39,
   //                   //             176,
   //                   //             255,
   //                   //             0.15)),
   //                   shape: WidgetStatePropertyAll(
   //                       ContinuousRectangleBorder(
   //                           borderRadius:
   //                               BorderRadius.all(
   //                                   Radius.circular(
   //                                       10))))),
   //               child:
   //                   const Text("Next Monday"),
   //             ),
   //           ),
   //         ],
   //       ),
   //     ),
   //     const SizedBox(
   //       height: 10,
   //     ),
   //     Padding(
   //       padding: const EdgeInsets.only(
   //           top: 10, left: 20, right: 20),
   //       child: Row(
   //         children: [
   //           Expanded(
   //               child: ElevatedButton(
   //                   onPressed: () {},
   //                   style: const ButtonStyle(
   //                       // backgroundColor:
   //                           // WidgetStatePropertyAll(
   //                           //     Color.fromRGBO(
   //                           //         39,
   //                           //         176,
   //                           //         255,
   //                           //         0.15)),
   //                       shape: WidgetStatePropertyAll(
   //                           ContinuousRectangleBorder(
   //                               borderRadius: BorderRadius
   //                                   .all(Radius
   //                                       .circular(
   //                                           10))))),
   //                   child: const Text(
   //                     "Next Tuesday",
   //                     style: TextStyle(),
   //                   ))),
   //           const SizedBox(
   //             width: 50,
   //           ),
   //           Expanded(
   //               child: ElevatedButton(
   //                   onPressed: () {},
   //                   style: const ButtonStyle(
   //                       // backgroundColor:
   //                           // WidgetStatePropertyAll(
   //                           //     Color.fromRGBO(
   //                           //         39,
   //                           //         176,
   //                           //         255,
   //                           //         0.15)),
   //                       shape: WidgetStatePropertyAll(
   //                           ContinuousRectangleBorder(
   //                               borderRadius:
   //                                   BorderRadius.all(
   //                                       Radius.circular(
   //                                           10))))),
   //                   child:
   //                       const Text("Next Week"))),
   //         ],
   //       ),
   //     ),
   //   ],
   // ),
 );



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
    return '${date.day} $month ${date.year}';
  }




@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: false,
        // backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          "Add Employee Details",
        ),
      ),
      body: BlocConsumer<EmployeeBloc,EmployeeState>(
        listener:(context,state){

          if(state is EmployeeAdded){

            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context)=> const HomePage())
                , (route) => false);

          }


    },
        builder:(context,state) {
          return Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: employeeName,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: Colors.blue,
                              ),
                              hintText: "Employee name",
                              hintStyle: TextStyle(color: Colors.grey),
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.zero)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: employeeRole,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue,
                              ),
                              prefixIcon: Icon(
                                Icons.card_travel,
                                color: Colors.blue,
                              ),
                              hintText: "Select role",
                              hintStyle: TextStyle(color: Colors.grey),
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.zero)),
                          onTap: () {
                            List<String?> roleList = [
                              "Product Designer",
                              "Flutter Developer",
                              "QA Tester",
                              "Product Owner"
                            ];
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.4,
                                    child: ListView(
                                      children: [
                                        for (int i = 0; i <
                                            roleList.length; i++) ...[
                                          ListTile(
                                            onTap: () {
                                              employeeRole.text = roleList[i]!;
                                              Navigator.of(context).pop();
                                            },
                                            title: Center(
                                                child: Text(roleList[i]!)),
                                            shape: const Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey)),
                                          ),
                                        ]
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                controller: addDate,
                                onTap: () async {
                                  _startDate = await showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (_) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          start,
                                        ],
                                      );
                                    },
                                  );

                                  if (_startDate != null) {
                                    addDate.text = formatShortDate(_startDate);
                                  }
                                },
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.blue,
                                    ),
                                    hintText: "Today",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero)),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                controller: endDate,
                                onTap: () async {
                                 _endDate = await showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (_) {
                                      return Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              end,
                                            ],
                                          )

                                      );
                                    },
                                  );

                                  if (_endDate != null) {
                                    endDate.text = formatShortDate(_endDate);
                                  }
                                },
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.blue,
                                    ),
                                    hintText: "No date",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),

                    padding: const EdgeInsets.all(10),
                    // height: MediaQuery.of(context).size.height*0.1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                                shape: const WidgetStatePropertyAll(
                                    ContinuousRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                                padding:
                                const WidgetStatePropertyAll(
                                    EdgeInsets.all(10)),
                                backgroundColor:
                                WidgetStatePropertyAll(
                                    Colors.lightBlue.shade100)),
                            child: const Text("Cancel")),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context.read<EmployeeBloc>().add(
                                  EmployeeAddRequest(
                                      name:employeeName.text.trim(),
                                      role: employeeRole.text.trim(),
                                    startDate: _startDate,
                                    endDate: _endDate
                                  )
                              );
                            },
                            style: const ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    ContinuousRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                                padding: WidgetStatePropertyAll(
                                    EdgeInsets.all(10)),
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.blue)),
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ],
              )
          );

        }
      ),
    );
  }
}


