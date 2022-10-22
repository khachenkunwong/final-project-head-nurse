import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
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

class WorksheduleHome extends StatefulWidget {
  const WorksheduleHome({Key? key}) : super(key: key);

  @override
  State<WorksheduleHome> createState() => _WorksheduleHomeState();
}

class _WorksheduleHomeState extends State<WorksheduleHome> {
  Future<List<Group>>? futureMember;
  bool stataShowManagerGroup = false;
  // ListTileControlAffinity? controlAffinity = ListTileControlAffinity("10");
  List<List<String>> textlsit1 = [];
  List<String> grouplist = [];
  Map<int, bool> hideandshow = {};
  ExpandableController controllerExpandable =
      ExpandableController(initialExpanded: true);
  List<ExpandableController> controllerExpandablein = [];
  // Map<int,ExpandableController> = {0:ExpandableController(initialExpanded: true)}

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
  // @override
  // // TODO: implement mounted
  // bool get mounted => super.mounted;

  @override
  void initState() {
    // TODO: implement initState
    futureMember = getMemberModel(token: FFAppState().tokenStore);
    print("check แสดงหุบว่าเปลี่ยนไหมtrue initState");
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant WorksheduleHome oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   print("check แสดงหุบว่าเปลี่ยนไหมtrue didUpdateWidget ${oldWidget.toStringShort()}");

  //   super.didUpdateWidget(oldWidget);
  // }
  // @override
  // void didChangeDependencies(){
  //   print("check แสดงหุบว่าเปลี่ยนไหมtrue didUpdateWidget ${didChangeDependencies}");
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    print("check แสดงหุบว่าเปลี่ยนไหมtrue 222");
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // stataShowManagerGroup? Text("fasdfaffdafsfdffdf",style:TextStyle(color: Colors.black,fontSize: 50.0)):SizedBox(),
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
                      controller: controllerExpandable,
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
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          //   child: TextButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         controllerExpandable.value =
                          //             !controllerExpandable.value;
                          //       });
                          //       print(
                          //           "controllerExpandable.expanded ${controllerExpandable.expanded} ${controllerExpandable.value}");
                          //       // setState(() {
                          //       //   controllerExpandable.expanded;
                          //       //   //  = ExpandableController(initialExpanded: );
                          //       // });
                          //       // setState(() {
                          //       //   stataShowManagerGroup =
                          //       //       !stataShowManagerGroup;
                          //       // });
                          //       // print("$stataShowManagerGroup");
                          //     },
                          //     child: Text(
                          //       controllerExpandable.value
                          //           ? "แสดงทั้งหมด"
                          //           : "ซ่อน",
                          //       style: GoogleFonts.mitr(
                          //         fontSize: 24,
                          //         color:
                          //             FlutterFlowTheme.of(context).primaryBlue,
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
                                  hideandshow.addAll({indexGroup: false});
                                  controllerExpandablein.add(
                                      ExpandableController(
                                          initialExpanded: true));

                                  // print(
                                  //     "listviewdataManagerGroup[indexGroup] ${listviewdataManagerGroup[indexGroup].}");
                                  // FFAppState().itemsdutyList.add("$indexGroup");
                                  return ExpandablePanel(
                                    
                                    key: Key(
                                        "${listviewdataManagerGroup[indexGroup].id}"),
                                    controller:
                                        controllerExpandablein[indexGroup],
                                    // controller: controllerExpandable,
                                    // ExpansionTile(
                                    //     controlAffinity: controlAffinity,
                                    //     initiallyExpanded:
                                    //         hideandshow[indexGroup]!,
                                    //     maintainState: hideandshow[indexGroup]!,
                                    //     onExpansionChanged: (value) {
                                    //       print("valueuu $value");
                                    //     },
                                    expanded: Text(""),
                                    // expanded: Row(
                                    //   mainAxisSize: MainAxisSize.max,
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   children: [
                                    //     TextButton(
                                    //       onPressed: () {
                                    //         // print(
                                    //         //     "controlAffinity ${controlAffinity?.index}}");
                                    //         setState(() {
                                    //           stataShowManagerGroup =
                                    //               !stataShowManagerGroup;
                                    //           hideandshow[indexGroup] =
                                    //               stataShowManagerGroup;
                                    //         });

                                    //         print(
                                    //             " check แสดงหุบว่าเปลี่ยนไหม$stataShowManagerGroup $hideandshow");
                                    //       },
                                    //       child: Text(
                                    //         hideandshow[indexGroup]!
                                    //             ? "ซ่อน"
                                    //             : "แสดงทั้งหมด",
                                    //         style: GoogleFonts.mitr(
                                    //           fontSize: 24,
                                    //           color:
                                    //               FlutterFlowTheme.of(context)
                                    //                   .primaryBlue,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    header: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${indexnumber1 + 1} ชื่อกลุ่ม ${listviewdataManagerGroup[indexGroup].nameGroup}",
                                            style: GoogleFonts.mitr(
                                              fontSize: 20,
                                              color: Color(0xFFF727272),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 8, 8),
                                          child: TextButton(
                                            onPressed: () {
                                              for (int i = 0;
                                                  i <
                                                      listviewdataManagerGroup
                                                          .length;
                                                  i++) {
                                                if (indexGroup != i) {
                                                  controllerExpandablein[i]
                                                      .value = true;
                                                }
                                              }
                                              setState(() {
                                                controllerExpandablein[
                                                            indexGroup]
                                                        .value =
                                                    !controllerExpandablein[
                                                            indexGroup]
                                                        .value;
                                              });

                                              // print(
                                              //     "controllerExpandable.expanded ${controllerExpandable.expanded} ${controllerExpandable.value}");
                                              // setState(() {
                                              //   controllerExpandable.expanded;
                                              //   //  = ExpandableController(initialExpanded: );
                                              // });
                                              // setState(() {
                                              //   stataShowManagerGroup =
                                              //       !stataShowManagerGroup;
                                              // });
                                              // print("$stataShowManagerGroup");
                                            },
                                            child: Text(
                                              controllerExpandablein[indexGroup]
                                                      .value
                                                  ? "แสดงทั้งหมด"
                                                  : "ซ่อน",
                                              style: GoogleFonts.mitr(
                                                fontSize: 24,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    collapsed: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: WorkcalendarWidget(
                                            indexGroup: indexGroup,
                                            nameGroup:
                                                "${snapshotGroup.data?[indexGroup].nameGroup}",
                                            idGroup:
                                                "${snapshotGroup.data?[indexGroup].id}")),
                                    // collapsed: ExpansionTile(
                                    //   initiallyExpanded:
                                    //       controllerExpandablein[indexGroup]
                                    //           .value,
                                    //   // onExpansionChanged: (value) {
                                    //   //   return value;
                                    //   // },
                                    //   title: const SizedBox(),
                                    //   children: [
                                    //     Container(
                                    //         width: MediaQuery.of(context)
                                    //             .size
                                    //             .width,
                                    //         height: MediaQuery.of(context)
                                    //             .size
                                    //             .height,
                                    //         child: WorkcalendarWidget(
                                    //             indexGroup: indexGroup,
                                    //             nameGroup:
                                    //                 "${snapshotGroup.data?[indexGroup].nameGroup}",
                                    //             idGroup:
                                    //                 "${snapshotGroup.data?[indexGroup].id}")),
                                    //   ],
                                    // ),
                                  );
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
