import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../firstscreen/firstscreen_widget.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../flutter_flow/flutter_flow_widgets.dart';
import '../model/all_me_model.dart';

class WorkscheduleWidget extends StatefulWidget {
  const WorkscheduleWidget({Key? key}) : super(key: key);

  @override
  _WorkscheduleWidgetState createState() => _WorkscheduleWidgetState();
}

class _WorkscheduleWidgetState extends State<WorkscheduleWidget> {
  ApiCallResponse? crateTableOutput;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiCallResponse? logoutCallOutput;
  DateTimeRange? calendarSelectedDay;
  late Future<String> getMall;

  Future<String> getMeallpubileinClass({required String token}) async {
    setState(() {});
    try {
      final res = await http.get(
        Uri.parse("$url/api/group/schedule/me/all/AAA-บ้านม่วง"),
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
        return res.body;
      } else {
        setState(() {});
      }
    } catch (e) {
      print("error $e");
      getMeallpubileinClass(token: FFAppState().tokenStore);
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // crateTableOutput = await CreateTableCall.call();
      // if ((crateTableOutput?.statusCode ?? 200) == 200) {
      //   await actions.notifica(
      //     context,
      //     'สร้างตารางเสร็จสิ้น',
      //   );
      // } else {
      //   await actions.notifica(
      //     context,
      //     'สร้างตารางไม่สำเร็จ',
      //   );
      // }
    });
// FFAppState().itemsduty
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    // final getMeAllThen = getMeallpubileinClass(token: FFAppState().tokenStore);
    // FFAppState().itemsduty = getMeAllThen;
    getMall = getMeallpubileinClass(token: FFAppState().tokenStore);
    getMall.then((getMeAllThen) {
      print("ค่าวางไหม ${getMeAllThen.isEmpty}");

      print("บันทึกข้อมูล");
      FFAppState().itemsduty = getMeAllThen;
    });
    // if (FFAppState().itemsduty.length <= 2 && FFAppState().itemsduty.isEmpty) {
    //   getMall = getMeallpubileinClass(token: FFAppState().tokenStore);
    //   getMall.then((getMeAllThen) {
    //     print("ค่าวางไหม ${getMeAllThen.isEmpty}");

    //     print("บันทึกข้อมูล");
    //     FFAppState().itemsduty = getMeAllThen;
    //     // print("data strote ${FFAppState().itemsduty}");
    //   });
    // } else {
    //   print(" 1 มีของมูลอยู่แล้ว");
    //   // print("data strote ${FFAppState().itemsduty}");
    // }
    print("FFAppState().itemsduty ${FFAppState().itemsduty}");
  }

  @override
  Widget build(BuildContext context) {
    // FFAppState().itemsduty = "";
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        icon: Icon(
          Icons.message,
          size: 35,
        ),
        elevation: 10,
        label: Container(),
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
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground1,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                    child: FlutterFlowCalendar(
                      color: FlutterFlowTheme.of(context).primaryColor,
                      weekFormat: true,
                      weekStartsMonday: true,
                      rowHeight: 70,
                      onChange: (DateTimeRange? newSelectedDate) {
                        setState(() => calendarSelectedDay = newSelectedDate);
                      },
                      titleStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: FlutterFlowTheme.of(context).primaryBlack,
                        fontSize: 28,
                      ),
                      dayOfWeekStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Color(0xFF050000),
                        fontSize: 28,
                      ),
                      dateStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Color(0xFF050000),
                        fontSize: 28,
                      ),
                      selectedDateStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Colors.white,
                        fontSize: 28,
                      ),
                      inactiveDateStyle: GoogleFonts.getFont(
                        'Mitr',
                        color: Color(0xFF8E8E8E),
                        fontSize: 28,
                      ),
                      daysOfWeekHeight: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logoutCallOutput = await LogoutCall.call(
                          token: FFAppState().tokenStore,
                        );
                        // setState(() => FFAppState().tokenStore = '');
                        if (((logoutCallOutput?.statusCode ?? 200)) == 200) {
                          setState(() => FFAppState().tokenStore = '');
                          await actions.notifica(
                            context,
                            'ออกจากระบบแล้ว',
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirstscreenWidget(),
                              ));
                        } else {
                          setState(() => FFAppState().tokenStore = '');
                          await actions.notifica(
                            context,
                            'ออกจากระบบไม่สำเร็จ',
                          );
                        }
                      },
                      text: 'ออกจากระบบ',
                      options: FFButtonOptions(
                        width: 350,
                        height: 42,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle: FlutterFlowTheme.of(context).bodyText1,
                        elevation: 10,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
