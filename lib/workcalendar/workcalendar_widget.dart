import 'package:flutter/scheduler.dart';
import 'package:hos_windown/app_state.dart';
import 'package:hos_windown/flutter_flow/flutter_flow_util.dart';
import 'package:hos_windown/model/dutysave.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../custom_code/actions/index.dart' as actions;

import '../custom_code/actions/notifica.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../model/all_me_model.dart';
import 'package:flutter/services.dart';

class WorkcalendarWidget extends StatefulWidget {
  const WorkcalendarWidget({Key? key}) : super(key: key);

  @override
  _WorkcalendarWidgetState createState() => _WorkcalendarWidgetState();
}

class _WorkcalendarWidgetState extends State<WorkcalendarWidget> {
  late EmployeeDataSource1 _employeeDataSource;
  List<List<Employee1>> _employees = <List<Employee1>>[];
  var num = 1;
  int? a;
  List day = [1, 2];
  var numberGridColumn = 0;
  // จำนวนวันกำหนดแล้วค่าจะเปลี่ยน
  int numberItem = 30;
  int numberObject = 0;
  List getMeAll = [];
  Future<List<AllMeModel>>? futureAllMe;
  List<List<Employee1>> items = [];
  List<List<Employee1>> tar1 = [];
  bool loadSave = false;
  bool loadgroupmange = false;
  bool loadclear = false;
  late ApiCallResponse updataschedule;
  late Map<String, double> columnWidths = {
    'name': double.nan,
    "average": double.nan,
    "median": double.nan,
    "popular_base": double.nan
  };
  late Future<String> getMall;
  @override
  void dispose() {
    // TODO: implement dispose
    _employees.clear();
    day.clear();
    getMeAll.clear();
    items.clear();
    tar1.clear();
    columnWidths.clear();
    super.dispose();
  }

  Future<String> resetduty() async {
    if (mounted) {
      setState(() {});
    }
    try {
      final res = await http.get(
        Uri.parse("$url/api/group/schedule/me/all/AAA-บ้านม่วง"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "${FFAppState().tokenStore}"
        },
      );
      // print("res type ${res.body.runtimeType}");
      // print("res ${res.body}");

      // เอา string ไปแล้ว decode เป็น json เอาไปเก็บในตัวแปร
      // final resBody = convert.jsonDecode(res.body);

      // print("res type ${resBody.runtimeType}");
      // print("resBody ${resBody["_id"]}");
      print("res.body ${res.body}");
      if (res.statusCode == 200) {
        FFAppState().itemsduty = res.body;
        await notifica(context, "เลิกทำที่แก้แล้ว", color: Colors.green);
        return res.body;
      } else {
        await notifica(context, "เลิกทำไม่สำเร็จ");
      }
    } catch (e) {
      print("error $e");
      getMeallpubileinClass(token: FFAppState().tokenStore);
    }
    return "";
  }

  Future updataSchedule() async {
    // List<dynamic> terst = convert.jsonDecode(FFAppState().itemsduty);
    // print('type ${terst.runtimeType}');
    // print('data${terst}');

    final res = await http
        .patch(Uri.parse("$url/api/schedule/update/schedule"), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
    }, body: {
      "duties": "บักโบต",
    });
    // print("res.body ${res.body}");
    if (res.statusCode == 200) {
      //  print("ผ่าน ${res.body}");
      return res.body;
    } else {
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<List<AllMeModel>> getMeallpubileinClass(
      {required String token}) async {
    // final body = convert.json.decode(res.body) as List<dynamic>;
    // print("body: ** ${body.length}");

    final futureAllMe = allMeModelFromJson(FFAppState().itemsduty as String);

    List<Employee1> ter = [];

    for (int dutyNamenumber = 0;
        dutyNamenumber < futureAllMe.length;
        dutyNamenumber++) {
      if (futureAllMe[dutyNamenumber].duty!.length > 0) {
        for (int dutyDaynumber = 0;
            dutyDaynumber < futureAllMe[dutyNamenumber].duty!.length;
            dutyDaynumber++) {
          // print("${futureAllMe[dutyNamenumber].duty![dutyDaynumber].id}");
          ter.add(
            Employee1(
                "${futureAllMe[dutyNamenumber].duty![dutyDaynumber].id}",
                "${futureAllMe[dutyNamenumber].user!.fristName} ${futureAllMe[dutyNamenumber].user!.lastName}",
                futureAllMe[dutyNamenumber].duty![dutyDaynumber].morning != 0
                    ? "เช้า"
                    : "ว่าง",
                futureAllMe[dutyNamenumber].duty![dutyDaynumber].noon != 0
                    ? "บ่าย"
                    : "ว่าง",
                futureAllMe[dutyNamenumber].duty![dutyDaynumber].night != 0
                    ? "ดึก"
                    : "ว่าง",
                "${futureAllMe[dutyNamenumber].group}",
                "${futureAllMe[dutyNamenumber].user!.id}",
                "${futureAllMe[dutyNamenumber].id}",
                "${futureAllMe[dutyNamenumber].duty![dutyDaynumber].year}",
                "${futureAllMe[dutyNamenumber].duty![dutyDaynumber].month}",
                "${futureAllMe[dutyNamenumber].duty![dutyDaynumber].day}",
                "${futureAllMe[dutyNamenumber].duty![dutyDaynumber].group}",
                "${futureAllMe[dutyNamenumber].duty![dutyDaynumber].count}"),
          );
        }
      } else {
        try {
          for (int dutyDaynumber = 0;
              dutyDaynumber < futureAllMe[0].duty!.length;
              dutyDaynumber++) {
            ter.add(
              Employee1(
                  "เวรว่าง",
                  "${futureAllMe[dutyNamenumber].user!.fristName} ${futureAllMe[dutyNamenumber].user!.lastName}",
                  "เวรว่าง",
                  "เวรว่าง",
                  "เวรว่าง",
                  "${futureAllMe[dutyNamenumber].group}",
                  "${futureAllMe[dutyNamenumber].user!.id}",
                  "${futureAllMe[dutyNamenumber].id}",
                  "เวรว่าง",
                  "เวรว่าง",
                  "เวรว่าง",
                  "เวรว่าง",
                  "เวรว่าง"),
            );
          }
        } catch (error) {
          print("ข้ามเนื่องจาก สมาชิกในกลุ่มคนแรกหรือคนที่ 2 error ${error}");
        }
      }

      tar1.add(ter as List<Employee1>);

      ter = [];
      // Employee1("khachen kunwong", "ช", "ว่าง", "ว่าง");

    }
    // await notifica(context, "โหลดตารางแล้ว", color: Colors.green);
    // if (mounted) {
    setState(() {
      items = tar1;
    });
    // }

    // print("itemss ${items.length}");
    // var tar2 = tar1.toString();
    // print("print ${tar2}");
    // print("type ${tar2.runtimeType}");
    // List tar3 = tar2.split(",");
    // print("tar3 ${tar3}");
    // print("tar3 type${tar3.runtimeType}");
    // print("tar3 length ${tar3.length}");
    // tar2 = tar2.t;
    // print("to list${tar2.toList()}");
    // print("name ${tar2[0].first.name}");

    // print("getMeAll ${getMeAll.first["_id"]}getMeAll");
    // final futureMeAll = _futureMeAll.duty as List<DutyAllMeModel>;

    return futureAllMe;
  }

  //
  List<GridColumn> getColumns(int number, columnWidths) {
    List<GridColumn> columnsName;
    List<GridColumn> columnsduty;
    List<GridColumn> columnSum = [];
    List<GridColumn> columnsDutyNameSum = [];

    columnsName = <GridColumn>[
      GridColumn(
          columnName: 'name',
          width: columnWidths['name'],
          label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'name',
                overflow: TextOverflow.ellipsis,
              ))),
    ];

    columnsDutyNameSum = <GridColumn>[
      GridColumn(
          columnName: 'average',
          width: columnWidths['average'],
          label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'ค่าเฉลี่ย',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'median',
          width: columnWidths['median'],
          label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'มัธยฐาน',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'popular_base',
          width: columnWidths['popular_base'],
          label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'ฐานนิยม',
                overflow: TextOverflow.ellipsis,
              ))),
    ];

    for (int i = 1; i <= number; i++) {
      columnsduty = <GridColumn>[
        GridColumn(
            columnName: 'เช้า $i',
            label: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text(
                  'เช้า',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'บ่าย $i',
            label: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text(
                  'บ่าย',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'ดึก $i',
            label: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text(
                  'ดึก',
                  overflow: TextOverflow.ellipsis,
                ))),
      ];
      if (i == 1) {
        columnSum = columnsName + columnsduty;
      } else {
        columnSum = columnSum + columnsduty;
      }
    }

    columnSum = columnSum + columnsDutyNameSum;
    // print(columnSum.length);

    return columnSum;
  }

//
  List<StackedHeaderCell> _getStackedHeaderCell(int number) {
    List<StackedHeaderCell> stackedHeaderCell = [];
    List<StackedHeaderCell> stackedHeaderCellSum = [];
    List<StackedHeaderCell> stackedHeaderSum = [];

    stackedHeaderSum = <StackedHeaderCell>[
      StackedHeaderCell(
          columnNames: ['average', 'median', 'popular_base'],
          child: Container(
              color: const Color(0xFFF1F1F1),
              child: Center(child: Text('สรุป')))),
    ];

    for (int i = 1; i <= number; i++) {
      stackedHeaderCell = <StackedHeaderCell>[
        StackedHeaderCell(
            columnNames: ['เช้า $i', 'บ่าย $i', "ดึก $i"],
            child: Container(
                color: const Color(0xFFF1F1F1),
                child: Center(child: Text('วันที่ $i')))),
      ];
      if (i == 1) {
        stackedHeaderCellSum = stackedHeaderCell;
      } else {
        stackedHeaderCellSum = stackedHeaderCellSum + stackedHeaderCell;
      }
    }
    stackedHeaderCellSum = stackedHeaderCellSum + stackedHeaderSum;
    return stackedHeaderCellSum;
  }
//

  // StackedHeaderCell(
  //               columnNames: ['เช้า', 'บ่าย', "night"],
  //               child: Container(
  //                   color: const Color(0xFFF1F1F1),
  //                   child: Center(child: Text('วันที่ $i')))),
  EmployeeDataSource1? currentPage;

  Future<String> getMeallpubileinClass2({required String token}) async {
    if (mounted) {
      setState(() {});
    }
    try {
      final res = await http.get(
        Uri.parse("$url/api/group/schedule/me/all/AAA"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      // print("res type ${res.body.runtimeType}");
      // print("res ${res.body}");

      // เอา string ไปแล้ว decode เป็น json เอาไปเก็บในตัวแปร
      // final resBody = convert.jsonDecode(res.body);

      // print("res type ${resBody.runtimeType}");
      // print("resBody ${resBody["_id"]}");
      print("res.body ${res.body}");
      if (res.statusCode == 200) {
        await notifica(context, "โหลดตารางสำเร็จ", color: Colors.green);
        return res.body;
      } else {
        await notifica(context, "โหลดตารางไม่สำเร็จ");
        // setState(() {});
      }
    } catch (e) {
      print("error $e");
      getMeallpubileinClass(token: FFAppState().tokenStore);
    }
    return "";
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      getMall = getMeallpubileinClass2(token: FFAppState().tokenStore);
      await getMall.then((getMeAllThen) {
        print("ค่าวางไหม ${getMeAllThen.isEmpty}");

        print("บันทึกข้อมูล");
        FFAppState().itemsduty = getMeAllThen;
      });

      await getMeallpubileinClass(token: FFAppState().tokenStore);
    });
    super.initState();
  }

  // Items = [
  //   // มี 2 คน 4 วัน
  //   [
  //     Employee1("khachen kunwong", "ช", "ว่าง", "ว่าง"),
  //     Employee1("khachen kunwong", "ว่าง", "บ", "ว่าง"),
  //     Employee1("khachen kunwong", "ว่าง", "ว่าง", "ด"),
  //     Employee1("khachen kunwong", "ช", "บ", "ด"),
  //     Employee1("khachen kunwong", "ว่าง", "บ", "ด"),
  //   ],
  //   [
  //     Employee1("xxxxxx", "ว่าง", "ว่าง", "ด"),
  //     Employee1("xxxxxx", "ว่าง", "บ", "ด"),
  //     Employee1("xxxxxx", "ช", "บ", "ว่าง"),
  //     Employee1("xxxxxx", "ว่าง", "บ", "ว่าง"),
  //     Employee1("xxxxxx", "ว่าง", "บ", "ด"),
  //   ],
  //   [
  //     Employee1("ten", "ว่าง", "ว่าง", "ด"),
  //     Employee1("ten", "ว่าง", "ว่าง", "ด"),
  //     Employee1("ten", "ว่าง", "ว่าง", "ว่าง"),
  //     Employee1("ten", "ว่าง", "บ", "ว่าง"),
  //     Employee1("ten", "ว่าง", "บ", "ด"),
  //   ]
  // ];

  // List<Employee1> test() {
  //   return [
  //     Employee1(10001, 'James',"nigth", 20000, 'Project Lead'),
  //     Employee1(10002, 'Kathryn',"nigth", 30000, 'Manager'),
  //     Employee1(10003, 'Lara',"nigth", 15000, 'Developer'),
  //     Employee1(10004, 'Michael',"nigth", 15000, 'Designer'),
  //     Employee1(10005, 'Martin',"nigth", 15000, 'Developer'),
  //     Employee1(10006, 'Newberry',"nigth", 15000, 'Developer'),
  //     Employee1(10007, 'Balnc',"nigth", 15000, 'Developer'),
  //     Employee1(10008, 'Perry',"nigth", 15000, 'Developer'),
  //     Employee1(10009, 'Gable',"nigth", 15000, 'Developer'),
  //     Employee1(10010, 'Grimes',"nigth", 15000, 'Developer')
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    //  print('รี หน้าใหม่');
    // items = getEmployeeData();
    try {
      if (items.isNotEmpty || items.length > 0) {
        // print("tar1$tar1");
        // print("item len ${items.first.length}");

        _employeeDataSource =
            EmployeeDataSource1(items, items.first.length - 1);
        currentPage = _employeeDataSource;
      } else {
        _employeeDataSource =
            EmployeeDataSource1(items, items.first.length - 1);
        return Center(child: CircularProgressIndicator());
      }
    } catch (error) {
      print("error $error");
      return Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () async {
                      // ยังกดไม่ได้จนกว่าจะแก้เอาเวรว่างออก
                      setState(() {
                        loadSave = true;
                      });
                      updataschedule = await UpdateSchedule.call();
                      final gg = UpdateSchedule.resUpdateSchedule(
                          updataschedule.jsonBody);
                      print("ooo" + gg.toString());
                      if (updataschedule.statusCode == 200) {
                        if (mounted) {
                          setState(() {
                            loadSave = false;
                          });
                        }
                        await actions.notifica(
                          context,
                          'บันทึกแล้ว',
                        );
                      } else {
                        if (mounted) {
                          setState(() {
                            loadSave = false;
                          });
                        }
                        await actions.notifica(
                          context,
                          'บันทึกไม่สำเร็จ',
                        );
                      }
                    },
                    backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                    elevation: 10,
                    label: loadSave == true
                        ? SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.white))
                        : Text("บันทึก"),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      //  print('FloatingActionButton pressed ...');
                      setState(() {
                        loadclear = true;
                      });
                      resetduty();
                      if (mounted) {
                        setState(() {
                          loadclear = false;
                        });
                      }

                      print("ล้างแล้ว");
                    },
                    backgroundColor: FlutterFlowTheme.of(context).primaryRed,
                    elevation: 10,
                    label: loadclear == false
                        ? Text("ล้าง")
                        : CircularProgressIndicator(
                            backgroundColor: Colors.white),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      //  print('FloatingActionButton pressed ...');
                      setState(() {
                        loadgroupmange = true;
                      });
                      final getStoteData =
                          allMeModelFromJson(FFAppState().itemsduty);

                      await AutoDutyCall.call(
                          groupID: "${getStoteData.first.group}");

                      print("จัดกลุ่มแล้ว");
                      if (mounted) {
                        setState(() {
                          loadgroupmange = false;
                        });
                      }
                      await notifica(context, "จัดกลุ่มแล้ว",
                          color: Colors.green);
                    },
                    backgroundColor: FlutterFlowTheme.of(context).primaryGreen,
                    elevation: 10,
                    label: loadgroupmange == false
                        ? Text("จัดเวรของกลุ่มนี้")
                        : CircularProgressIndicator(),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      //  print('FloatingActionButton pressed ...');
                      // setState(() {
                      //   loadclear = true;
                      // });
                      // resetduty();
                      // setState(() {
                      //   loadclear = false;
                      // });
                      // getMall = getMeallpubileinClass2(
                      //     token: FFAppState().tokenStore);
                      // await getMall.then((getMeAllThen) {
                      //   print("ค่าวางไหม ${getMeAllThen.isEmpty}");

                      //   print("บันทึกข้อมูล");
                      //   FFAppState().itemsduty = getMeAllThen;
                      // });

                      // await getMeallpubileinClass(
                      //     token: FFAppState().tokenStore);
                      if (mounted) {
                        setState(() {});
                      }

                      print("โหลดหน้าใหม่");
                    },
                    backgroundColor: FlutterFlowTheme.of(context).primaryRed,
                    elevation: 10,
                    label: loadclear == false
                        ? Text("รีโหลดหน้า")
                        : CircularProgressIndicator(
                            backgroundColor: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 75.0,
                width: 75.0,
              ),
            ],
          ),
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: Color(0xFF00A2FD),
            ),
          )));
    }

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: () async {
                  // ยังกดไม่ได้จนกว่าจะแก้เอาเวรว่างออก
                  setState(() {
                    loadSave = true;
                  });
                  updataschedule = await UpdateSchedule.call();
                  final gg =
                      UpdateSchedule.resUpdateSchedule(updataschedule.jsonBody);
                  print("ooo" + gg.toString());
                  if (updataschedule.statusCode == 200) {
                    // final getmeall =
                    //     getMeallpubileinClass2(token: FFAppState().tokenStore);
                    //   getmeall.then((getMeAllThen2) {
                    //   FFAppState().itemsduty = getMeAllThen2;
                    // });
                    if (mounted) {
                      setState(() {
                        // getMeallpubileinClass(token: FFAppState().tokenStore);
                        loadSave = false;
                      });
                    }
                    await actions.notifica(
                      context,
                      'บันทึกแล้ว',
                    );
                  } else {
                    if (mounted) {
                      setState(() {
                        loadSave = false;
                      });
                    }
                    await actions.notifica(
                      context,
                      'บันทึกไม่สำเร็จ',
                    );
                  }
                },
                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                elevation: 10,
                label: loadSave == true
                    ? SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.white))
                    : Text("บันทึก"),
              ),
              SizedBox(
                width: 10.0,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  //  print('FloatingActionButton pressed ...');
                  setState(() {
                    loadclear = true;
                  });
                  resetduty();
                  if (mounted) {
                    setState(() {
                      loadclear = false;
                    });
                  }

                  print("ล้างแล้ว");
                },
                backgroundColor: FlutterFlowTheme.of(context).primaryRed,
                elevation: 10,
                label: loadclear == false
                    ? Text("ล้าง")
                    : CircularProgressIndicator(backgroundColor: Colors.white),
              ),
              SizedBox(
                width: 10.0,
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  //  print('FloatingActionButton pressed ...');
                  setState(() {
                    loadgroupmange = true;
                  });
                  final getStoteData =
                      allMeModelFromJson(FFAppState().itemsduty);

                  await AutoDutyCall.call(
                      groupID: "${getStoteData.first.group}");

                  print("จัดกลุ่มแล้ว");
                  if (mounted) {
                    setState(() {
                      loadgroupmange = false;
                    });
                  }
                  await notifica(context, "จัดกลุ่มแล้ว", color: Colors.green);
                },
                backgroundColor: FlutterFlowTheme.of(context).primaryGreen,
                elevation: 10,
                label: loadgroupmange == false
                    ? Text("จัดเวรของกลุ่มนี้")
                    : CircularProgressIndicator(),
              ),
              SizedBox(
                width: 10.0,
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  //  print('FloatingActionButton pressed ...');
                  // setState(() {
                  //   loadclear = true;
                  // });
                  // resetduty();
                  // setState(() {
                  //   loadclear = false;
                  // });
                  // getMall =
                  //     getMeallpubileinClass2(token: FFAppState().tokenStore);
                  // await getMall.then((getMeAllThen) {
                  //   print("ค่าวางไหม ${getMeAllThen.isEmpty}");

                  //   print("บันทึกข้อมูล");
                  //   FFAppState().itemsduty = getMeAllThen;
                  // });

                  // await getMeallpubileinClass(token: FFAppState().tokenStore);
                  if (mounted) {
                    setState(() {});
                  }

                  print("โหลดหน้าใหม่");
                },
                backgroundColor: FlutterFlowTheme.of(context).primaryRed,
                elevation: 10,
                label: loadclear == false
                    ? Text("รีโหลดหน้า")
                    : CircularProgressIndicator(backgroundColor: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 75.0,
            width: 75.0,
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryWhite,
        automaticallyImplyLeading: false,
        actions: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'Jonh Liam',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: FlutterFlowTheme.of(context).title2Family,
                    fontSize: 24,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 5),
            child: Container(
              width: 53,
              height: 53,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://picsum.photos/seed/492/600',
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SfDataGrid(
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          allowColumnsResizing: true,
          onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
            print("details.width ${details.width}");
            setState(() {
              columnWidths[details.column.columnName] = details.width;
            });
            return true;
          },
          // ยืดให้เต็มจอ
          // columnWidthMode: ColumnWidthMode.lastColumnFill,
          // highlightRowOnHover: true,
          // 2 ตัวด้านล่าง ทำให้สามารถกดเลือกได้แค่เเค่ตัวเดียว
          allowEditing: true,
          editingGestureType: EditingGestureType.tap,
          selectionMode: SelectionMode.single,
          navigationMode: GridNavigationMode.cell,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          frozenColumnsCount: 1,
          footerFrozenColumnsCount: 3,
          source: _employeeDataSource,
          // ตัวนี้ ถ้าจำนวนไม่ตรงตามที่กำหนดไม่ว่าจะใส่ column name ถูกไหมก็จะ DataGridRowAdapter.cells.length: is not true
          // ถ้าใส่ไม่ตรงstackedHeaderRows ก้จะเป็นครอปตารางไปเลย
          // ทดสอบเพิ่มคอรัม
          // ห้ามใส่เป็น 0
          columns: getColumns(items.first.length - 1, columnWidths),
          stackedHeaderRows: <StackedHeaderRow>[
            // ห้ามใส่เป็น 0
            StackedHeaderRow(
                cells: _getStackedHeaderCell(items.first.length - 1)
                // ตัวนี้อาจจะไม่มีผลในการสร้างตารางซ้อน

                // StackedHeaderCell(
                //     columnNames: ['productId', 'product'],
                //     child: Container(
                //         color: const Color(0xFFF1F1F1),
                //         child: Center(child: Text('Product Details'))))
                )
          ]),
    );
  }
}

class Employee1 {
  Employee1(
      this.dutyID,
      this.name,
      this.morning,
      this.afternoon,
      this.night,
      this.groupID,
      this.userID,
      this.id,
      this.year,
      this.month,
      this.day,
      this.group,
      this.count);
  final String dutyID;
  final String name;
  final String morning;
  final String afternoon;
  final String night;
  final String groupID;
  final String userID;
  final String id;
  final String year;
  final String month;
  final String day;
  final String group;
  final String count;
}

class EmployeeDataSource1 extends DataGridSource {
  /// Creates the employee data source class with required details.
  List day = [1, 2];
  var d = 0;
  late List<DataGridRow> dataGridRows = [];
  var counttime = 0;

// เริ่ม fution ข้างใน
  List<DataGridCell> _getDataGridCall(
      {required List<Employee1> dataGridRow, required int number}) {
    try {
      List<DataGridCell> dataGridCall = [];
      List<DataGridCell> dataGridName = [];
      // ตัวนี้คือ การอินพูดค่าซ้ำ
      List<DataGridCell> dataGridSum = [];
      List<DataGridCell> dataGridSumdata = [];

      dataGridName = [
        DataGridCell<String>(
            columnName: 'name', value: "${dataGridRow[0].name}"),
      ];

      dataGridSumdata = [
        DataGridCell<String>(columnName: 'average', value: "48ชั่วโมง/6พัด"),
        DataGridCell<String>(columnName: 'median', value: "40ชั่วโมง/5พัด"),
        DataGridCell<String>(
            columnName: 'popular_base', value: "32ชั่วโมง/4พัด"),
      ];
      // _%${dataGridRow[i - 1].groupID}_%${dataGridRow[i - 1].id}_%${dataGridRow[i - 1].year}_%${dataGridRow[i - 1].month}_%${dataGridRow[i - 1].day}_%${dataGridRow[i - 1].group}_%${dataGridRow[i - 1].count}
      for (int i = 1; i <= number; i++) {
        dataGridCall = [
          DataGridCell<String>(
              columnName: 'เช้า $i',
              value:
                  "${dataGridRow[i - 1].dutyID}_%${dataGridRow[i - 1].morning}_%${dataGridRow[i - 1].userID}_%${dataGridRow[i - 1].groupID}_%${dataGridRow[i - 1].id}_%${dataGridRow[i - 1].year}_%${dataGridRow[i - 1].month}_%${dataGridRow[i - 1].day}_%${dataGridRow[i - 1].group}_%${dataGridRow[i - 1].count}"),
          DataGridCell<String>(
              columnName: 'บ่าย $i',
              value:
                  "${dataGridRow[i - 1].dutyID}_%${dataGridRow[i - 1].afternoon}_%${dataGridRow[i - 1].userID}_%${dataGridRow[i - 1].groupID}_%${dataGridRow[i - 1].id}_%${dataGridRow[i - 1].year}_%${dataGridRow[i - 1].month}_%${dataGridRow[i - 1].day}_%${dataGridRow[i - 1].group}_%${dataGridRow[i - 1].count}"),
          DataGridCell<String>(
              columnName: 'ดึก $i',
              value:
                  "${dataGridRow[i - 1].dutyID}_%${dataGridRow[i - 1].night}_%${dataGridRow[i - 1].userID}_%${dataGridRow[i - 1].groupID}_%${dataGridRow[i - 1].id}_%${dataGridRow[i - 1].year}_%${dataGridRow[i - 1].month}_%${dataGridRow[i - 1].day}_%${dataGridRow[i - 1].group}_%${dataGridRow[i - 1].count}"),
        ];
        if (i == 1) {
          // รอบแรกใส่ข้อมูลถูกต้อง ตรงหมด
          dataGridSum = dataGridName + dataGridCall;
        } else {
          // เริ่มผิดตรงนีัที่ใส่ข้อมูลเดิม
          dataGridSum = dataGridSum + dataGridCall;
        }
      }
      dataGridSum = dataGridSum + dataGridSumdata;

      // รีเทน 1 ครั้งคือ 1
      return dataGridSum;
    } catch (error) {
      List<DataGridCell> dataGridCall = [];
      List<DataGridCell> dataGridName = [];
      // ตัวนี้คือ การอินพูดค่าซ้ำ
      List<DataGridCell> dataGridSum = [];
      List<DataGridCell> dataGridSumdata = [];
      print('ค่า duty ว่างหรือ errorอย่างอื้น รายละเอียด${error}');
      dataGridName = [
        DataGridCell<String>(columnName: 'name', value: "null"),
      ];

      dataGridSumdata = [
        DataGridCell<String>(columnName: 'average', value: "null"),
        DataGridCell<String>(columnName: 'median', value: "null"),
        DataGridCell<String>(columnName: 'popular_base', value: "null"),
      ];
      // _%${dataGridRow[i - 1].groupID}_%${dataGridRow[i - 1].id}_%${dataGridRow[i - 1].year}_%${dataGridRow[i - 1].month}_%${dataGridRow[i - 1].day}_%${dataGridRow[i - 1].group}_%${dataGridRow[i - 1].count}
      for (int i = 1; i <= number; i++) {
        dataGridCall = [
          DataGridCell<String>(columnName: 'เช้า $i', value: "null"),
          DataGridCell<String>(columnName: 'บ่าย $i', value: "null"),
          DataGridCell<String>(columnName: 'ดึก $i', value: "null"),
        ];
        if (i == 1) {
          // รอบแรกใส่ข้อมูลถูกต้อง ตรงหมด
          dataGridSum = dataGridName + dataGridCall;
        } else {
          // เริ่มผิดตรงนีัที่ใส่ข้อมูลเดิม
          dataGridSum = dataGridSum + dataGridCall;
        }
      }
      dataGridSum = dataGridSum + dataGridSumdata;

      // รีเทน 1 ครั้งคือ 1
      return dataGridSum;
    }
  }

  // สิ้นสุด funtion
// เริ่ม class
  EmployeeDataSource1(
    List<List<Employee1>> employees,
    int number,
  ) {
    var dataGridCall;
    var bb = 1;

    // print("_employeeData $_employeeData");
    buildDataGridRows(employees, number);
    // print("dataGridRows1 $dataGridRows");
  }
// สิ้นสุด class

  // @override
  // bool onCellBeginEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
  //     GridColumn column) {
  //   if (column.columnName.split(" ")[0] == 'เช้า') {
  //     // Return false, to restrict entering into the editing.
  //   //  print("ตรงเงื่อนไข");
  //     return false;
  //   } else {
  //   //  print("ไม่ตรง");
  //     return true;
  //   }
  // }
  void buildDataGridRows(List<List<Employee1>> employees, int number) {
    dataGridRows = employees.map((dataGridRowName) {
      DataGridRow DataGridrows;

      DataGridrows = DataGridRow(
        cells: _getDataGridCall(dataGridRow: dataGridRowName, number: number),
        // ถ้าใส่จำนวนไม่ตรงกันก็จะ error
        // ทดสอบเพิ่ม คอรัม
        // DataGridCell<String>(
        //     columnName: 'เช้า1', value: dataGridRow.morning),
        // DataGridCell<String>(
        //     columnName: 'บ่าย1', value: dataGridRow.afternoon),
        // DataGridCell<String>(
        //     columnName: 'ดึก', value: dataGridRow.night),
      );

      return DataGridrows;
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  String showvalue = "";

  List<List<Employee1>> tar1 = [];

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((valus) {
      // print(object))
      // valus.columnName ใช้ชื่อ คอรัมเปลียบเทียบได้ valus.columnName == 'designation'
      // print("row.getCells().first.value ${rows.length}");
      // print(
      //     "valus 159 ${valus.value} - ${valus.value.toString().split("-")[0]}");
      try {
        Color getColor() {
          if (valus.columnName.split(" ")[0] == 'เช้า') {
            if (valus.value.toString().split("_%")[1] == 'เช้า') {
              return Color(0xFFFF9EDFF3);
            } else if (valus.value.toString().split("_%")[1] == 'ว่าง') {
              return Colors.white;
            }
          } else if (valus.columnName.split(" ")[0] == 'บ่าย') {
            if (valus.value.toString().split("_%")[1] == 'บ่าย') {
              return Color(0xFFFFFF8A22);
            } else if (valus.value.toString().split("_%")[1] == 'ว่าง') {
              return Colors.white;
            }
          } else if (valus.columnName.split(" ")[0] == 'ดึก') {
            if (valus.value.toString().split("_%")[1] == 'ดึก') {
              return Color(0xFFFF005BD7);
            } else if (valus.value.toString().split("_%")[1] == 'ว่าง') {
              return Colors.white;
            }
          }

          return Colors.transparent;
        }

        if (valus.value.toString().split("_%").length >= 2) {
          showvalue = valus.value.toString().split("_%")[1].toString();
        } else {
          showvalue = valus.value.toString();
        }
        // print(valus.columnName);
        //     //  print("${valus.value.toString().split("-")[0]}");
        //     //  print("${valus.value.toString().split("-")[1]}");
        //     //  print("value arm${valus.value}");

        //     //  print("arm ${futureAllMe.first.duty!.first.morning}");
        //       futureAllMe.first.duty!.first.morning = 1;
        //     //  print("arm1 ${futureAllMe.first.duty!.first.morning}");
        //       final futuretoJson = allMeModelToJson(futureAllMe);
        //       FFAppState().itemsduty = futuretoJson;
        // dataGridRows[rowColumnIndex.rowIndex]
        //           .getCells()[rowColumnIndex.columnIndex] =
        //           DataGridCell<String>(
        //       columnName: "${column.columnName}", value: "${id}-บ่าย");
        // print("tt ${}");

        return Container(
          color: getColor(),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(showvalue),
        );
      } catch (error) {
        print("เกิดข้อผิดพลาดตอนนำตารางมาแสดง ${error}");

        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(showvalue),
        );
      }
    }).toList());
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // ทำงานเมื่อ เข้า โหมดแก้ไข

    var splitValueDuty = dataGridRow
        .getCells()[rowColumnIndex.columnIndex]
        .value
        .toString()
        .split("_%");
    //  print('splitValueDuty ${splitValueDuty}');
    String dutyId = splitValueDuty[0];
    String duty = splitValueDuty[1];
    String userId = splitValueDuty[2];
    String groupId = splitValueDuty[3];
    String id = splitValueDuty[4];
    String year = splitValueDuty[5];
    String month = splitValueDuty[6];
    String day = splitValueDuty[7];
    String group = splitValueDuty[8];
    String count = splitValueDuty[9];

    // print(
    //     "buildEditWidget 000 ${column.columnName} ${rowColumnIndex.columnIndex} ${rowColumnIndex.rowIndex}");
    // print(
    //     "dataGridRow.getCells() ${dataGridRow.getCells()[2].value} len = ${dataGridRow.getCells().length}");
    String coloumNameString = column.columnName.split(" ")[0];
    // print("coloumNameString $coloumNameString $coloumid");
    //  print("id duty $dutyId $duty");
    //  print("tt ${dataGridRow.getCells()[rowColumnIndex.columnIndex].value}");
    // ทำงาน if  เมื่อ รู้ร่างเมาส์เปลี่ยนไป
    if (coloumNameString == 'เช้า') {
      //  print("buildEditWidget ว่าง");
      return _buildDatamoorning(
          submitCell: submitCell,
          dataGridRow: dataGridRow,
          rowColumnIndex: rowColumnIndex,
          column: column,
          dutyId: dutyId,
          duty: duty,
          userId: userId,
          groupId: groupId,
          id: id,
          year: year,
          month: month,
          day: day,
          group: group,
          count: count);
    }
    if (coloumNameString == 'บ่าย') {
      //  print("buildEditWidget บ่าย");
      return _buildDatanoon(
          submitCell: submitCell,
          dataGridRow: dataGridRow,
          rowColumnIndex: rowColumnIndex,
          column: column,
          dutyId: dutyId,
          duty: duty,
          userId: userId,
          groupId: groupId,
          id: id,
          year: year,
          month: month,
          day: day,
          group: group,
          count: count);
    }
    if (coloumNameString == 'ดึก') {
      //  print("buildEditWidget ดึก");
      return _buildDatanight(
          submitCell: submitCell,
          dataGridRow: dataGridRow,
          rowColumnIndex: rowColumnIndex,
          column: column,
          dutyId: dutyId,
          duty: duty,
          userId: userId,
          groupId: groupId,
          id: id,
          year: year,
          month: month,
          day: day,
          group: group,
          count: count);
    }

    submitCell();
  }

  // @override
  // void onCellSubmit(
  //   DataGridRow dataGridRow,
  //   RowColumnIndex rowColumnIndex,
  //   GridColumn column,
  // ) {
  //   // print(rowColumnIndex.rowIndex);
  //   String id = dataGridRow.getCells()[1].value.toString().split("-")[0];
  //   String duty = dataGridRow.getCells()[1].value.toString().split("-")[1];
  // //  print("idduty $id $duty");
  //   if (column.columnName.split(" ")[0] == 'เช้า') {
  //     // print("duty ${duty}");
  //     if (duty == "เช้า") {
  //       dataGridRows[rowColumnIndex.rowIndex]
  //               .getCells()[rowColumnIndex.columnIndex] =
  //           DataGridCell<String>(
  //               columnName: "${column.columnName}", value: "${id}-ว่าง");
  //     } else if (duty == "ว่าง") {
  //       dataGridRows[rowColumnIndex.rowIndex]
  //               .getCells()[rowColumnIndex.columnIndex] =
  //           DataGridCell<String>(
  //               columnName: "${column.columnName}", value: "${id}-เช้า");
  //     //  print("กด เช้า");
  //     }

  //   //  print("onCellSubmit เช้า ${column.columnName}");
  //   } else if (column.columnName.split(" ")[0] == 'บ่าย') {
  //   //  print("onCellSubmit บ่าย");

  //     if (duty == "บ่าย") {
  //       dataGridRows[rowColumnIndex.rowIndex]
  //               .getCells()[rowColumnIndex.columnIndex] =
  //           DataGridCell<String>(
  //               columnName: "${column.columnName}", value: "${id}-ว่าง");
  //     } else if (duty == "ว่าง") {
  //       dataGridRows[rowColumnIndex.rowIndex]
  //               .getCells()[rowColumnIndex.columnIndex] =
  //           DataGridCell<String>(
  //               columnName: "${column.columnName}", value: "${id}-บ่าย");
  //     //  print("กด เช้า");
  //     }
  //   } else if (column.columnName.split(" ")[0] == 'ดึก') {
  //   //  print("onCellSubmit ดึก");
  //     if (duty == "ดึก") {
  //       dataGridRows[rowColumnIndex.rowIndex]
  //               .getCells()[rowColumnIndex.columnIndex] =
  //           DataGridCell<String>(
  //               columnName: "${column.columnName}", value: "${id}-ว่าง");
  //     } else if (duty == "ว่าง") {
  //       dataGridRows[rowColumnIndex.rowIndex]
  //               .getCells()[rowColumnIndex.columnIndex] =
  //           DataGridCell<String>(
  //               columnName: "${column.columnName}", value: "${id}-ดึก");
  //     //  print("กด เช้า");
  //     }
  //   }
  // }

  Widget _buildDatamoorning(
      {required CellSubmit submitCell,
      required DataGridRow dataGridRow,
      required RowColumnIndex rowColumnIndex,
      required GridColumn column,
      required String dutyId,
      required String duty,
      required String userId,
      required String groupId,
      required String id,
      required String year,
      required String month,
      required String day,
      required String group,
      required String count}) {
    //  print("builddata");
    Color colors = Colors.white;
    if (duty == "เช้า") {
      colors = Color(0xFFFF9EDFF3);
    } else if (duty == "บ่าย") {
      colors = Color(0xFFFFFF8A22);
    } else if (duty == "ดึก") {
      colors = Color(0xFFFF005BD7);
    }

    return InkWell(
      onTap: () {
        // futureAllMe[rowColumnIndex.rowIndex].duty![0].month;
        // rowColumnIndex.columnIndex ตัวนี้ต้องแก้

        //  print(
        // "rowColumnIndex.rowIndex ${rowColumnIndex.rowIndex} rowColumnIndex.rowIndex ${rowColumnIndex.columnIndex} --- ${int.parse(column.columnName.toString().split(" ")[1])}");
        try {
          final futureAllMe = allMeModelFromJson(FFAppState().itemsduty);
          final dutyStore = futureAllMe[rowColumnIndex.rowIndex]
              .duty![int.parse(column.columnName.toString().split(" ")[1]) - 1];

          // DutySave(id: ,morning: ,noon: ,night: );
          if (duty == "เช้า") {
            dutyStore.morning = 0;
            dutyStore.count = int.parse(dutyStore.morning.toString()) +
                int.parse(dutyStore.noon.toString()) +
                int.parse(dutyStore.night.toString());
            dataGridRows[rowColumnIndex.rowIndex].getCells()[
                rowColumnIndex
                    .columnIndex] = DataGridCell<String>(
                columnName: "${column.columnName}",
                value:
                    "${dutyId}_%ว่าง_%${duty}_%${groupId}_%${id}_%${year}_%${month}_%${day}_%${group}_%${dutyStore.count}");

            print("dutyStore.count ${dutyStore.count}");

            final futureAllMeTojson = allMeModelToJson(futureAllMe);

            FFAppState().itemsduty = futureAllMeTojson;
            print("itemsduty ${FFAppState().itemsduty}");

            // ก็อปจากตรงนี้
            // var indexid = futureAllMe.indexWhere((value) => value.id == "${id}");
            // // print("idex ${indexid}");
            // var indexduty = futureAllMe[indexid]
            //     .duty!
            //     .indexWhere((value) => value.day == day);
            // // ทำต่อ
            // List listadd = [];
            // listadd.addAll(FFAppState().itemsdutyupdata);
            // if (listadd.isNotEmpty && listadd.length > 0) {
            //   print("เมื่อใน list มากกว่า 0");
            //   // var jsontodata =  FFAppState().itemsdutyupdata
            //   //  print("FFAppState().itemsdutyupdata ${listadd}");
            //   // [{"_id":"62e0f78f8623e0780f25bee3","_user":"ว่าง","year":"2022","month":"7","day":"1","group":"bbb-โรงพยาบาลบ้านดุง","morning":"0","noon":"1","night":"1","count":"2"}, {"_id":"62e0f78f8623e0780f25bee3","_user":"ว่าง","year":"2022","month":"7","day":"1","group":"bbb-โรงพยาบาลบ้านดุง","morning":"0","noon":"1","night":"1","count":"2"}, {"_id":"62e0f78f8623e0780f25bee3","_user":"ว่าง","year":"2022","month":"7","day":"1","group":"bbb-โรงพยาบาลบ้านดุง","morning":"0","noon":"0","night":"0","count":"0"}, {"_id":"62e0f78f8623e0780f25bee3","_user":"ว่าง","year":"2022","month":"7","day":"1","group":"bbb-โรงพยาบาลบ้านดุง","morning":"0","noon":"0","night":"0","count":"0"}]
            //   int numberindex = 0;
            //   for (var a in listadd) {
            //     var o = dutySaveFromJson(a);
            //     // print("FFAppState().itemsdutyupdata ${listadd}");
            //     //  print(o.id == dutyId);
            //     if (o.id == dutyId) {
            //       print("เข้าครั้งเดียว เมื่อ เจอ id ที่ตรงกัน");
            //       var updataData1 = DutySave(
            //           id: "$dutyId",
            //           user: "$userId",
            //           year: "${futureAllMe[indexid].duty![indexduty].year}",
            //           month: "${futureAllMe[indexid].duty![indexduty].month}",
            //           day: "${futureAllMe[indexid].duty![indexduty].day}",
            //           group: "${futureAllMe[indexid].duty![indexduty].group}",
            //           morning: "0",
            //           noon: "${futureAllMe[indexid].duty![indexduty].noon}",
            //           night: "${futureAllMe[indexid].duty![indexduty].night}",
            //           count: "${futureAllMe[indexid].duty![indexduty].count}");
            //       String lastsave = dutySaveToJson(updataData1);
            //       // print("lastsave ${lastsave.runtimeType} ${lastsave}");
            //       FFAppState().insertToItemsduty(lastsave, numberindex);
            //     } else {
            //       print("เข้าเมื่อไม่ตรง");
            //       print("object id ${o.id}");
            //     }
            //     numberindex += 1;
            //   }
            //   listadd = [];
            //   numberindex = 0;
            //   // var indexdutyid = futureAllMe[indexid]
            //   //     .duty!
            //   //     .indexWhere((value) => value.id == dutyId);
            //   // print("indexdutyid $indexdutyid");

            // } else {
            //   var updataData = DutySave(
            //       id: "$dutyId",
            //       user: "$userId",
            //       year: "${futureAllMe[indexid].duty![indexduty].year}",
            //       month: "${futureAllMe[indexid].duty![indexduty].month}",
            //       day: "${futureAllMe[indexid].duty![indexduty].day}",
            //       group: "${futureAllMe[indexid].duty![indexduty].group}",
            //       morning: "0",
            //       noon: "${futureAllMe[indexid].duty![indexduty].noon}",
            //       night: "${futureAllMe[indexid].duty![indexduty].night}",
            //       count: "${futureAllMe[indexid].duty![indexduty].count}");
            //   String lastsave = dutySaveToJson(updataData);
            //   // print("lastsave ${lastsave.runtimeType} ${lastsave}");
            //   FFAppState().addToItemsduty(lastsave);
            //   print("ทำงานเมื่อ add ค่าครั้งแรก");
            //   //  print(
            //   // "FFAppState().itemsdutyupdata ${FFAppState().itemsdutyupdata}");
            // }
            // ก็อปจากตรงนี้

            // print(" id ${updataData.id} user ${updataData.user} year ${updataData.year} month ${updataData.month} day ${updataData.day} group ${updataData.group} month ${updataData.month} morning ${updataData.morning} noon ${updataData.noon} night ${updataData.night} count ${updataData.count}");
            //  print("กดว่าง");
            submitCell();
          } else if (duty == "ว่าง") {
            dutyStore.morning = 1;
            dutyStore.count = int.parse(dutyStore.morning.toString()) +
                int.parse(dutyStore.noon.toString()) +
                int.parse(dutyStore.night.toString());
            dataGridRows[rowColumnIndex.rowIndex].getCells()[
                rowColumnIndex
                    .columnIndex] = DataGridCell<String>(
                columnName: "${column.columnName}",
                value:
                    "${dutyId}_%เช้า_%${duty}_%${groupId}_%${id}_%${year}_%${month}_%${day}_%${group}_%${dutyStore.count}");
            //  print("dutyStore.count ${dutyStore.count}");
            final futureAllMeTojson = allMeModelToJson(futureAllMe);

            FFAppState().itemsduty = futureAllMeTojson;
            //  print("กดเช้า");
            submitCell();
          }
        } catch (error) {
          print("เกิดปัญตอนกด ${error}");
        }
      },
      child: Container(
        color: colors,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text("$duty"),
      ),
    );
  }

  Widget _buildDatanoon(
      {required CellSubmit submitCell,
      required DataGridRow dataGridRow,
      required RowColumnIndex rowColumnIndex,
      required GridColumn column,
      required String dutyId,
      required String duty,
      required String userId,
      required String groupId,
      required String id,
      required String year,
      required String month,
      required String day,
      required String group,
      required String count}) {
    //  print("builddata");
    Color colors = Colors.white;
    if (duty == "เช้า") {
      colors = Color(0xFFFF9EDFF3);
    } else if (duty == "บ่าย") {
      colors = Color(0xFFFFFF8A22);
    } else if (duty == "ดึก") {
      colors = Color(0xFFFF005BD7);
    }

    return InkWell(
      onTap: () async {
        try {
          final futureAllMe = allMeModelFromJson(FFAppState().itemsduty);
          final dutyStore = futureAllMe[rowColumnIndex.rowIndex]
              .duty![int.parse(column.columnName.toString().split(" ")[1]) - 1];
          //  print("${FFAppState().itemsduty}");
          if (duty == "บ่าย") {
            //  print("กดว่าง");
            dutyStore.noon = 0;
            dutyStore.count = int.parse(dutyStore.morning.toString()) +
                int.parse(dutyStore.noon.toString()) +
                int.parse(dutyStore.night.toString());
            dataGridRows[rowColumnIndex.rowIndex].getCells()[
                rowColumnIndex
                    .columnIndex] = DataGridCell<String>(
                columnName: "${column.columnName}",
                value:
                    "${dutyId}_%ว่าง_%${duty}_%${groupId}_%${id}_%${year}_%${month}_%${day}_%${group}_%${dutyStore.count}");

            //  print("dutyStore.count ${dutyStore.count}");
            final futureAllMeTojson = allMeModelToJson(futureAllMe);

            FFAppState().itemsduty = futureAllMeTojson;
            submitCell();
          } else if (duty == "ว่าง") {
            dutyStore.noon = 1;
            dutyStore.count = int.parse(dutyStore.morning.toString()) +
                int.parse(dutyStore.noon.toString()) +
                int.parse(dutyStore.night.toString());
            dataGridRows[rowColumnIndex.rowIndex].getCells()[
                rowColumnIndex
                    .columnIndex] = DataGridCell<String>(
                columnName: "${column.columnName}",
                value:
                    "${dutyId}_%บ่าย_%${duty}_%${groupId}_%${id}_%${year}_%${month}_%${day}_%${group}_%${dutyStore.count}");

            //  print("dutyStore.count ${dutyStore.count}");
            final futureAllMeTojson = allMeModelToJson(futureAllMe);

            FFAppState().itemsduty = futureAllMeTojson;

            //  print("กดบ่าย");
            submitCell();
          }
        } catch (err) {
          print("เกิดปัญหาตอนกดปุ่ม");
        }
        //  print(
        // "rowColumnIndex.rowIndex ${rowColumnIndex.rowIndex} rowColumnIndex.rowIndex ${rowColumnIndex.columnIndex} --- ${int.parse(column.columnName.toString().split(" ")[1])}");

        // submitCell();
      },
      child: Container(
        color: colors,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text("$duty"),
      ),
    );
  }

  Widget _buildDatanight(
      {required CellSubmit submitCell,
      required DataGridRow dataGridRow,
      required RowColumnIndex rowColumnIndex,
      required GridColumn column,
      required String dutyId,
      required String duty,
      required String userId,
      required String groupId,
      required String id,
      required String year,
      required String month,
      required String day,
      required String group,
      required String count}) {
    //  print("builddata");
    Color colors = Colors.white;
    if (duty == "เช้า") {
      colors = Color(0xFFFF9EDFF3);
    } else if (duty == "บ่าย") {
      colors = Color(0xFFFFFF8A22);
    } else if (duty == "ดึก") {
      colors = Color(0xFFFF005BD7);
    }
    return InkWell(
      onTap: () {
        //  print(
        // "rowColumnIndex.rowIndex ${rowColumnIndex.rowIndex} rowColumnIndex.rowIndex ${rowColumnIndex.columnIndex} --- ${int.parse(column.columnName.toString().split(" ")[1])}");
        try {
          final futureAllMe = allMeModelFromJson(FFAppState().itemsduty);
          //
          final dutyStore = futureAllMe[rowColumnIndex.rowIndex]
              .duty![int.parse(column.columnName.toString().split(" ")[1]) - 1];
          if (duty == "ดึก") {
            //  print("กดว่าง");
            dutyStore.night = 0;
            dutyStore.count = int.parse(dutyStore.morning.toString()) +
                int.parse(dutyStore.noon.toString()) +
                int.parse(dutyStore.night.toString());
            dataGridRows[rowColumnIndex.rowIndex].getCells()[
                rowColumnIndex
                    .columnIndex] = DataGridCell<String>(
                columnName: "${column.columnName}",
                value:
                    "${dutyId}_%ว่าง_%${duty}_%${groupId}_%${id}_%${year}_%${month}_%${day}_%${group}_%${dutyStore.count}");
            //  print("dutyStore.count ${dutyStore.count}");
            final futureAllMeTojson = allMeModelToJson(futureAllMe);

            FFAppState().itemsduty = futureAllMeTojson;
            submitCell();
          } else if (duty == "ว่าง") {
            // เปลี่ยนแปลงค่าในตาราง เป็นดึกเมื่อกดคลิกถูกค่าว่าง
            // เปลี่ยนแปลงค่า night
            dutyStore.night = 1;
            // เปลี่ยนแปลงค่า count
            dutyStore.count = int.parse(dutyStore.morning.toString()) +
                int.parse(dutyStore.noon.toString()) +
                int.parse(dutyStore.night.toString());
            dataGridRows[rowColumnIndex.rowIndex].getCells()[
                rowColumnIndex
                    .columnIndex] = DataGridCell<String>(
                columnName: "${column.columnName}",
                value:
                    "${dutyId}_%ดึก_%${duty}_%${groupId}_%${id}_%${year}_%${month}_%${day}_%${group}_%${dutyStore.count}");
            //  print("dutyStore.count ${dutyStore.count}");
            // ทำการแปลงค่าจาก object เป็น string
            final futureAllMeTojson = allMeModelToJson(futureAllMe);
            // นำค่า String ทั้งหมดไปบันทึกลงความจำภายในเครื่อง
            FFAppState().itemsduty = futureAllMeTojson;
            // setstate อัพเดตตาราง
            submitCell();
            //  print("กดดึก");
          }
        } catch (error) {
          print("เกิดปัญหาตอนกดปุ่ม ${error}");
        }
        // submitCell();
      },
      child: Container(
        color: colors,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text("$duty"),
      ),
    );
  }
}
