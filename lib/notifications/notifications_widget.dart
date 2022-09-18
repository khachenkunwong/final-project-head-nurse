import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../components/showimage_widget.dart';
import '../custom_code/actions/notifica.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/changduty_model_get.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  DateTimeRange? calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Datum>> futureGetChangDuty;
  late String calendarSelectedDayString;
  late String calendarSelectedmonthString;
  late String calendarSelectedyearString;
  List dayDuty = ["เช้า", "บ่าย", "ดึก"];
  Future<List<Datum>> getChangDutyModel() async {
    try {
      final res = await http.get(
        Uri.parse("$url/api/changduty/leader/invited"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "${FFAppState().tokenStore}"
        },
      );
      print("getChangDutyModel code ${res.statusCode}");
      print("getChangDutyModel  body${res.body}");

      final body = convert.json.decode(res.body) as Map<String, dynamic>;
      final _futureGetChangDuty =
          GetChangDuty.fromJson(body as Map<String, dynamic>);
      final futureGetChangDuty = _futureGetChangDuty.data as List<Datum>;
      if (res.statusCode == 200) {
        await notifica(context, "แสดงข้อมูลสำเร็จ");
        return futureGetChangDuty;
      } else {
        await notifica(context, "แสดงข้อมูลไม่สำเร็จ");
      }
      // print("_futurePresent ${_futurePresent.duty}");
      // for (var dutylist in data) {
      //   // list ออกมาทั้ง index
      //   final _futurePresent =
      //       PresentModel.fromJson(dutylist as Map<String, dynamic>);
      //   // aa = _dutylist.duty!.first.day;
      //   // print("_dutylist ${aa}");
      //   setState(() {
      //     futurePresent.add(_futurePresent);
      //   });
      // }

    } catch (error) {
      print(error);
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    futureGetChangDuty = getChangDutyModel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dayDuty.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        icon: Icon(
          Icons.send,
          size: 35,
        ),
        elevation: 10,
        label: Container(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder<List<Datum>>(
                  future: futureGetChangDuty,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("เกิดข้อผิดพลาดเกี่ยวกับแอป"),
                      );
                    }
                    if (snapshot.data!.length == 0) {
                      return Center(
                        child: Text(""),
                      );
                    }
                    // if (snapshot.data!.first.memberApprove == false) {
                    //   return Card(
                    //       clipBehavior: Clip.antiAliasWithSaveLayer,
                    //       color: FlutterFlowTheme.of(context).secondaryWhite,
                    //       elevation: 2,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(20.0),
                    //         child: Center(
                    //           child: Text("ปฎิเศษแล้ว"),
                    //         ),
                    //       ));
                    // }

                    return Builder(builder: (context) {
                      return Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(329, 0, 329, 0),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color:
                                  FlutterFlowTheme.of(context).secondaryWhite,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 56,
                                      height: 56,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/260/600',
                                      ),
                                    ),
                                    Text(
                                      // '${getDataLeader!.fristName} ${getDataLeader.lastName} (${getDataLeader.actor})',
                                      "${snapshot.data!.first.member2!.fristName} ${snapshot.data!.first.member2!.lastName} (${snapshot.data!.first.member2!.actor})",
                                      style:
                                          FlutterFlowTheme.of(context).title2,
                                    ),
                                    // Text(
                                    //   'แลกทั้งหมด',
                                    //   textAlign: TextAlign.center,
                                    //   style: FlutterFlowTheme.of(context)
                                    //       .bodyText1
                                    //       .override(
                                    //         fontFamily: 'Mitr',
                                    //         color: FlutterFlowTheme.of(context)
                                    //             .primaryBlue,
                                    //       ),
                                    // ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 60,
                                      icon: Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder:
                                  (BuildContext context, int indexgetInvite) {
                                print(
                                    "ttttttttt ${snapshot.data!.first.approve}");
                                if (snapshot
                                        .data![indexgetInvite].memberApprove ==
                                    null) {
                                  return SizedBox();
                                }
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      329, 0, 329, 0),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                'assets/images/noti.png',
                                                width: 27.89,
                                                height: 30.72,
                                                fit: BoxFit.cover,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 0),
                                                child: Text(
                                                  'แลกเปลี่ยนเวร',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .title2
                                                      .override(
                                                        fontFamily: 'Mitr',
                                                        color:
                                                            Color(0xFF606060),
                                                        fontSize: 24,
                                                      ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'วันนี้ 07:14 น.',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title3,
                                                  ),
                                                  Text(
                                                    '${snapshot.data!.first.member2!.fristName} ${snapshot.data!.first.member2!.lastName}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Mitr',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryRed,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        FlutterFlowCalendar(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          weekFormat: false,
                                          weekStartsMonday: false,
                                          rowHeight: 70.0,
                                          onChange:
                                              (DateTimeRange? newSelectedDate) {
                                            setState(() {
                                              calendarSelectedDay =
                                                  newSelectedDate;
                                              calendarSelectedDayString =
                                                  calendarSelectedDay
                                                      .toString()
                                                      .split(" - ")[0]
                                                      .split(" ")[0]
                                                      .split("-")[2]
                                                      .toString();
                                              // ทุกครั้งที่กดวันที่ในปฏิทิน จะได้เดิอนมา
                                              calendarSelectedmonthString =
                                                  calendarSelectedDay
                                                      .toString()
                                                      .split(" - ")[0]
                                                      .split(" ")[0]
                                                      .split("-")[1]
                                                      .split("0")[1]
                                                      .toString();
                                              calendarSelectedyearString =
                                                  calendarSelectedDay
                                                      .toString()
                                                      .split(" - ")[0]
                                                      .split(" ")[0]
                                                      .split("-")[0]
                                                      .toString();
                                            });
                                          },
                                          titleStyle: GoogleFonts.getFont(
                                            'Mitr',
                                            color: Color(0xFF050000),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 28,
                                          ),
                                          dayOfWeekStyle: GoogleFonts.getFont(
                                            'Mitr',
                                            color: Color(0xFF050000),
                                            fontSize: 24,
                                          ),
                                          dateStyle: GoogleFonts.getFont(
                                            'Mitr',
                                            color: Color(0xFF050000),
                                            fontSize: 24,
                                          ),
                                          selectedDateStyle:
                                              GoogleFonts.getFont(
                                            'Mitr',
                                            color: Colors.white,
                                            fontSize: 28,
                                          ),
                                          inactiveDateStyle:
                                              GoogleFonts.getFont(
                                            'Mitr',
                                            color: Color(0xFF8E8E8E),
                                            fontSize: 24,
                                          ),
                                          daysOfWeekHeight: 50,
                                          yearduty: int.parse(snapshot
                                              .data!.first.duty2!.year
                                              .toString()),
                                          monthduty: int.parse(snapshot
                                              .data!.first.duty2!.month
                                              .toString()),
                                          dayduty: int.parse(snapshot
                                              .data!.first.duty2!.day
                                              .toString()),
                                          changTwoDuty: true,
                                          yearduty2: int.parse(snapshot
                                              .data!.first.duty1!.year
                                              .toString()),
                                          monthduty2: int.parse(snapshot
                                              .data!.first.duty1!.month
                                              .toString()),
                                          dayduty2: int.parse(snapshot
                                              .data!.first.duty1!.day
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            "ชื่อกลุ่ม ${snapshot.data![0].group2}",
                                            style: GoogleFonts.mitr(
                                              fontSize: 16,
                                              color: Color(0xFF606060),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 5, 0, 0),
                                            child: Text(
                                              'เวรของฉัน',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Mitr',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryButtonDarkBlue,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: FlutterFlowTheme.of(context)
                                              .stokeLightGray,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 15),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  final getState =
                                                      await UpdateApproveCall.call(
                                                          token: FFAppState()
                                                              .tokenStore,
                                                          approve: true,
                                                          changId:
                                                              '${snapshot.data![0].id}');
                                                  if (getState.statusCode ==
                                                      200) {
                                                    print(
                                                        "getstata ${getState.jsonBody}");
                                                    await notifica(
                                                        context, "สำเร็จ");
                                                  } else {
                                                    print(
                                                        "getstata ${getState.jsonBody}");
                                                    await notifica(
                                                        context, "ไม่สำเร็จ");
                                                  }
                                                  if (mounted) {
                                                    setState(() {});
                                                  }
                                                },
                                                child: Text(
                                                  'อนุญาติ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Mitr',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                      ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  final getState =
                                                      await UpdateApproveCall.call(
                                                          token: FFAppState()
                                                              .tokenStore,
                                                          approve: false,
                                                          changId:
                                                              '${snapshot.data![0].id}');
                                                  if (getState.statusCode ==
                                                      200) {
                                                    print(
                                                        "getstata ${getState.jsonBody}");
                                                    await notifica(
                                                        context, "สำเร็จ");
                                                  } else {
                                                    print(
                                                        "getstata ${getState.jsonBody}");
                                                    await notifica(
                                                        context, "ไม่สำเร็จ");
                                                  }
                                                  if (mounted) {
                                                    setState(() {});
                                                  }
                                                },
                                                child: Text(
                                                  'ปฎิเศษ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Mitr',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryRed,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      );
                    });
                  }),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(329, 0, 329, 0),
              //   child: Card(
              //     clipBehavior: Clip.antiAliasWithSaveLayer,
              //     color: FlutterFlowTheme.of(context).secondaryWhite,
              //     elevation: 2,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.max,
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             width: 56,
              //             height: 56,
              //             clipBehavior: Clip.antiAlias,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //             ),
              //             child: Image.network(
              //               'https://picsum.photos/seed/260/600',
              //             ),
              //           ),
              //           Text(
              //             'Hannah Darlene',
              //             style: FlutterFlowTheme.of(context).title2,
              //           ),
              //           Text(
              //             'แลกทั้งหมด',
              //             textAlign: TextAlign.center,
              //             style: FlutterFlowTheme.of(context)
              //                 .bodyText1
              //                 .override(
              //                   fontFamily: FlutterFlowTheme.of(context)
              //                       .bodyText1Family,
              //                   color: FlutterFlowTheme.of(context).primaryBlue,
              //                 ),
              //           ),
              //           FlutterFlowIconButton(
              //             borderColor: Colors.transparent,
              //             borderRadius: 30,
              //             borderWidth: 1,
              //             buttonSize: 60,
              //             icon: Icon(
              //               Icons.keyboard_arrow_up,
              //               color: Colors.black,
              //               size: 30,
              //             ),
              //             onPressed: () {
              //               print('IconButton pressed ...');
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(329, 0, 329, 0),
              //   child: Card(
              //     clipBehavior: Clip.antiAliasWithSaveLayer,
              //     color: Colors.white,
              //     elevation: 2,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.max,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(42, 20, 56, 0),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SvgPicture.asset(
              //                 'assets/images/noti.svg',
              //                 width: 60,
              //                 height: 60,
              //                 fit: BoxFit.cover,
              //               ),
              //               Padding(
              //                 padding:
              //                     EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              //                 child: Text(
              //                   'แลกเปลี่ยนเวร',
              //                   style: FlutterFlowTheme.of(context).title2,
              //                 ),
              //               ),
              //               Column(
              //                 mainAxisSize: MainAxisSize.max,
              //                 crossAxisAlignment: CrossAxisAlignment.end,
              //                 children: [
              //                   Text(
              //                     'วันนี้ 07:14 น.',
              //                     style: FlutterFlowTheme.of(context).title3,
              //                   ),
              //                   Text(
              //                     'Hannah Darlene ',
              //                     style: FlutterFlowTheme.of(context)
              //                         .bodyText1
              //                         .override(
              //                           fontFamily: FlutterFlowTheme.of(context)
              //                               .bodyText1Family,
              //                           color: FlutterFlowTheme.of(context)
              //                               .primaryRed,
              //                           fontWeight: FontWeight.w500,
              //                         ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //         FlutterFlowCalendar(
              //           color: FlutterFlowTheme.of(context).primaryColor,
              //           weekFormat: false,
              //           weekStartsMonday: false,
              //           rowHeight: 70,
              //           onChange: (DateTimeRange? newSelectedDate) {
              //             setState(() => calendarSelectedDay = newSelectedDate);
              //           },
              //           titleStyle:
              //               FlutterFlowTheme.of(context).title1.override(
              //                     fontFamily:
              //                         FlutterFlowTheme.of(context).title1Family,
              //                     fontSize: 28,
              //                   ),
              //           dayOfWeekStyle:
              //               FlutterFlowTheme.of(context).title1.override(
              //                     fontFamily:
              //                         FlutterFlowTheme.of(context).title1Family,
              //                     fontSize: 28,
              //                   ),
              //           dateStyle: FlutterFlowTheme.of(context).title2.override(
              //                 fontFamily:
              //                     FlutterFlowTheme.of(context).title2Family,
              //                 color: FlutterFlowTheme.of(context).primaryBlack,
              //               ),
              //           selectedDateStyle: FlutterFlowTheme.of(context)
              //               .title2
              //               .override(
              //                 fontFamily:
              //                     FlutterFlowTheme.of(context).title2Family,
              //                 color:
              //                     FlutterFlowTheme.of(context).secondaryWhite,
              //               ),
              //           inactiveDateStyle: FlutterFlowTheme.of(context).title2,
              //           daysOfWeekHeight: 50,
              //         ),
              //         Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(0, 45, 0, 27),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               InkWell(
              //                 onTap: () async {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     SnackBar(
              //                       content: Text(
              //                         'แลกเปลี่ยนเสร็จสิ้น',
              //                         style: FlutterFlowTheme.of(context)
              //                             .subtitle1
              //                             .override(
              //                               fontFamily:
              //                                   FlutterFlowTheme.of(context)
              //                                       .subtitle1Family,
              //                               fontSize: 18,
              //                             ),
              //                       ),
              //                       duration: Duration(milliseconds: 4000),
              //                       backgroundColor:
              //                           FlutterFlowTheme.of(context)
              //                               .primaryColor,
              //                     ),
              //                   );
              //                 },
              //                 child: Text(
              //                   'อนุมัติ',
              //                   style: FlutterFlowTheme.of(context)
              //                       .bodyText1
              //                       .override(
              //                         fontFamily: FlutterFlowTheme.of(context)
              //                             .bodyText1Family,
              //                         color: FlutterFlowTheme.of(context)
              //                             .primaryColor,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                 ),
              //               ),
              //               Text(
              //                 'ยกเลิก',
              //                 style: FlutterFlowTheme.of(context)
              //                     .bodyText1
              //                     .override(
              //                       fontFamily: FlutterFlowTheme.of(context)
              //                           .bodyText1Family,
              //                       color:
              //                           FlutterFlowTheme.of(context).alternate,
              //                       fontWeight: FontWeight.w500,
              //                     ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(329, 0, 329, 0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(42, 20, 56, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/noti.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                'แจ้งเหตุ',
                                style: FlutterFlowTheme.of(context).title2,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'วันนี้ 07:14 น.',
                                  style: FlutterFlowTheme.of(context).title3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(47, 10, 47, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'ชื่อ:',
                                  style: FlutterFlowTheme.of(context)
                                      .title2
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title2Family,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBlack,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'Hannah Darlene ',
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(47, 0, 47, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'ประเภทการลา:',
                                  style: FlutterFlowTheme.of(context)
                                      .title2
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title2Family,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBlack,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'ลาป่วย',
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .title2Family,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryRed,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(47, 0, 47, 0),
                            child: Wrap(
                              // mainAxisSize: MainAxisSize.max,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  'รายละเอียดเพิ่มเติ่ม:',
                                  style: FlutterFlowTheme.of(context)
                                      .title2
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title2Family,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBlack,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'เนื่องจากติดโควิดจึงของแจ้งลา',
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .title2Family,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryGray,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(47, 0, 47, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'ติดต่อ:',
                                  style: FlutterFlowTheme.of(context)
                                      .title2
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title2Family,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBlack,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    '0883011544',
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .title2Family,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryGray,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryWhite,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      height: 1215,
                                      child: ShowimageWidget(
                                        image: random_data.randomImageUrl(
                                          939,
                                          1215,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Hero(
                              tag: 'showimage',
                              transitionOnUserGestures: true,
                              child: Image.network(
                                'https://picsum.photos/seed/935/600',
                                width: 302,
                                height: 391,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(47, 49, 47, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'ทำนวนวันที่ขอลา:',
                              style:
                                  FlutterFlowTheme.of(context).title2.override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title2Family,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBlack,
                                      ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'ยังไม่ได้กำหนด',
                                style: FlutterFlowTheme.of(context)
                                    .title2
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .title2Family,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryRed,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(47, 0, 47, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'แจ้งเมื่อ:',
                              style:
                                  FlutterFlowTheme.of(context).title2.override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title2Family,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBlack,
                                      ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'วันที่ 18 เดือน เมษายน ปี 2565 ',
                                style: FlutterFlowTheme.of(context)
                                    .title2
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .title2Family,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryGray,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(47, 0, 47, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'จำนวนการลาที่เหลือ:',
                              style:
                                  FlutterFlowTheme.of(context).title2.override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title2Family,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBlack,
                                      ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                '5 ครั้ง',
                                style: FlutterFlowTheme.of(context)
                                    .title2
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .title2Family,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryGray,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 45, 0, 27),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'แลกเปลี่ยนเสร็จสิ้น',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle1Family,
                                            fontSize: 18,
                                          ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryColor,
                                  ),
                                );
                              },
                              child: Text(
                                'อนุมัติ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyText1Family,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Text(
                              'ยกเลิก',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
