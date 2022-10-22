import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_state.dart';
import '../backend/pubilc_.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../model/member_model.dart';
import '../custom_code/actions/index.dart' as actions;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../workcalendar/workcalendar_widget.dart';
import 'workschedule_widget.dart';

class WorksheduleHome2 extends StatefulWidget {
  const WorksheduleHome2({Key? key}) : super(key: key);

  @override
  State<WorksheduleHome2> createState() => _WorksheduleHome2State();
}

class _WorksheduleHome2State extends State<WorksheduleHome2> {
  Future<List<Group>>? futureMember;
  bool stataShowManagerGroup = false;
  List<List<String>> textlsit1 = [];
  List<String> grouplist = [];

  Future<List<Group>> getMemberModel({required String token}) async {
    try {
      setState(() {});
      print("token");
      final res = await http.get(
        Uri.parse("$url/api/group/me/member"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      print("res.body1 getMemberModel ${res.statusCode}");
      print("res.body1 getMemberModel ${res.body}");

      // if (checkUnauthorized) {
      //   await actions.notifica(
      //     context,
      //     'คุณไม่ใช่หัวหน้าพยาบาล',
      //   );
      //   return [];
      // }
      if (res.statusCode == 200) {
        final bodyMember =
            convert.json.decode(res.body) as Map<String, dynamic>;
        final _futureMember = MemberCall.fromJson(bodyMember);
        // print("_futureMember ${_futureMember.group!.first.limit}");
        final futureMember = _futureMember.group as List<Group>;

        for (int i = 0; i < futureMember.length; i++) {
          textlsit1.add([]);
          grouplist.add("${futureMember[i].nameGroup}");
          for (int a = 0; a < futureMember[i].member!.length; a++) {
            textlsit1[i].add(futureMember[i].member![a].actor as String);
          }
        }
        // for (var indexGroupNumber = 0;
        //     indexGroupNumber < futureMember.length;
        //     indexGroupNumber++) {
        //   for (var indexMemberNumber = 0;
        //       indexMemberNumber < futureMember[indexGroupNumber].member!.length;
        //       indexMemberNumber++) {
        //     deleteLord.addEntries({
        //       "refrest $indexGroupNumber $indexMemberNumber": false
        //     }.entries);
        //   }
        //   if (futureMember[indexGroupNumber].deleted == false) {
        //     showGroup.add(futureMember[indexGroupNumber]);
        //     // showGroup[indexGroupNumber] = ;
        //   }
        // }
        return futureMember;
      }
      await actions.notifica(
        context,
        'คุณไม่ใช่หัวหน้าพยาบาล',
      );

      return [];
    } catch (error) {
      print(error);
      if ("$error" == "Connection closed before full header was received") {
        // delay 2 second
        await Future.delayed(Duration(seconds: 2));
        getMemberModel(token: FFAppState().tokenStore);
      }
    }
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    futureMember = getMemberModel(token: FFAppState().tokenStore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder<List<Group>>(
                future: futureMember,
                builder: (context, snapshotGroup) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshotGroup.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }

                  return ExpandableTheme(
                    data: const ExpandableThemeData(
                        iconPadding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                        animationDuration: Duration(milliseconds: 250)),
                    child: ExpandablePanel(
                      header: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                            child: Text(
                              "กลุ่มทั้งหมด",
                              style: GoogleFonts.mitr(
                                  fontSize: 24, color: Color(0xFFF727272)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: TextButton(
                              onPressed: () {
                                // setState(() {
                                //   stataShowManagerGroup =
                                //       !stataShowManagerGroup;
                                // });
                                // print("$stataShowManagerGroup");
                              },
                              child: Text(
                                stataShowManagerGroup ? "ซ่อน" : "แสดงทั้งหมด",
                                style: GoogleFonts.mitr(
                                  fontSize: 24,
                                  color:
                                      FlutterFlowTheme.of(context).primaryBlue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      collapsed: FutureBuilder<List<Group>>(
                          future: futureMember,
                          builder: ((context, dataManagerGroup) {
                            if (!dataManagerGroup.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              );
                            }
                            if (dataManagerGroup.data == null) {
                              return Center(
                                child: SizedBox(
                                    width: 50, height: 50, child: Text("ว่าง")),
                              );
                            }
                            if (dataManagerGroup.hasError) {
                              return Center(
                                child: Text("เกิดข้อผิดพลาด"),
                              );
                            }

                            List<Group> listviewdataManagerGroup =
                                dataManagerGroup.data!;

                            if (listviewdataManagerGroup.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ยังไม่ได้สร้างกลุ่ม",
                                    style: GoogleFonts.mitr(
                                      fontSize: 20,
                                      color: Color(0xFFF727272),
                                    ),
                                  ),
                                ),
                              );
                              // return Center(
                              //   child: SizedBox(
                              //     width: 50,
                              //     height: 50,
                              //     child: CircularProgressIndicator(
                              //       color: FlutterFlowTheme.of(context).primaryColor,
                              //     ),
                              //   ),
                              // );
                            }
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listviewdataManagerGroup.length,
                                itemBuilder: ((context, indexGroup) {
                                  final indexnumber1 = indexGroup;
                                  // print(
                                  //     "listviewdataManagerGroup[indexGroup] ${listviewdataManagerGroup[indexGroup].}");
                                  // FFAppState().itemsdutyList.add("$indexGroup");
                                  print("arms");
                                  return 
                                  ExpansionTile(
                                    controlAffinity:ListTileControlAffinity.platform,
                                      initiallyExpanded: stataShowManagerGroup,
                                      maintainState: stataShowManagerGroup,
                                      onExpansionChanged: (value) {
                                        print("value $value");
                                        // setState(() {
                                        //   stataShowManagerGroup = value;
                                        // });
                                      },
                                      title: const SizedBox(),
                                      leading: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${indexnumber1 + 1} ${listviewdataManagerGroup[indexGroup].nameGroup}",
                                          style: GoogleFonts.mitr(
                                            fontSize: 20,
                                            color: Color(0xFFF727272),
                                          ),
                                        ),
                                      ),
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: WorkcalendarWidget(
                                                indexGroup: indexGroup,
                                                nameGroup:
                                                    "${snapshotGroup.data?[indexGroup].nameGroup}",
                                                idGroup:
                                                    "${snapshotGroup.data?[indexGroup].id}")),
                                      ]);
                                }));
                          })),
                      expanded: SizedBox(),
                    ),
                  );

                  // return Text("kkk");
                  // print("snapshotGroup ${snapshotGroup.data}");
                  // return ListView.builder(
                  //     padding: EdgeInsets.zero,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.vertical,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: snapshotGroup.data!.length,
                  //     itemBuilder: (context, int indexGroup) {
                  //       return Column(
                  //         children: [
                  //           Text("ชื่อกลุ่ม ${snapshotGroup.data?[indexGroup].nameGroup}",style: GoogleFonts.mitr(fontSize: 24),),
                  //           Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             height: MediaQuery.of(context).size.height,
                  //             child: WorkcalendarWidget(nameGroup:"${snapshotGroup.data?[indexGroup].nameGroup}")),
                  //         ],
                  //       );
                  //     });
                }),
          ],
        ),
      ),
    );
  }
}
