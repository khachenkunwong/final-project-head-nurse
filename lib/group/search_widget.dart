import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_state.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../custom_code/actions/notifica.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../custom_code/actions/index.dart' as actions;
import '../model/all_member_without_me.dart';
import 'package:http/http.dart' as http;
import '../model/member_model.dart';
import '../model/not_manager_group_model.dart';
import 'dart:convert' as convert;

class SearchWidget extends StatefulWidget {
  List<MemberNotManagerGroup> listvievDutySearch;
  // List<MemberNotManagerGroup> listvievDutySearch2;
  final String nameGroup;
  final Group itemGroup;

  SearchWidget(
      {Key? key,
      required this.listvievDutySearch,
      // required this.listvievDutySearch2,
      required this.nameGroup,
      required this.itemGroup})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  // late List<MemberNotManagerGroup> copySeach;
// แสดงข้อมูลที่ยังไม่ได้จัดกลุ่ม
  Future<List<MemberNotManagerGroup>> getManagerNotGroupModel(
      {required String token}) async {
    try {
      print(token);
      final res = await http.get(
        Uri.parse("$url/api/admin/member"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      print("getManagerModel state ${res.statusCode}");
      print("getManagerModel body ${res.body}");

      final body = convert.json.decode(res.body);
      final _futureNotManagerGroup =
          GetNotManagerGroup.fromJson(body as Map<String, dynamic>);
      final futureNotManagerGroup =
          _futureNotManagerGroup.members as List<MemberNotManagerGroup>;

      print(
          "widget.listvievDutySearch ${widget.listvievDutySearch}");
      // for (int v = 0; v < widget.listvievDutySearch.length; v++) {
      // copySeach.add(widget.listvievDutySearch[v]);
      // }
      // print("copySeach.length ${copySeach}");

      if (res.statusCode == 200) {
        for (int i = 0; i < widget.itemGroup.member!.length; i++) {
          // namedeleteMangerGroup.add();
          print(
              "lll ${futureNotManagerGroup[i].email} ${widget.itemGroup.member![i].email}");
          int indexSearchEmaildelete =
              widget.listvievDutySearch.indexWhere((u) {
            print("${u.email} ==  ${widget.itemGroup.member![i].email}");
            return u.email == widget.itemGroup.member![i].email;
          });

          if (indexSearchEmaildelete != -1) {
            widget.listvievDutySearch.removeAt(indexSearchEmaildelete);
          }
          print(
              "widget.listvievDutySearch ${widget.listvievDutySearch}  $indexSearchEmaildelete");
        }

        await notifica(context, "แสดงข้อมูลที่ยังไม่ได้จัดกลุ่มเสำเร็จ",
            color: Colors.green);
        return futureNotManagerGroup;
      } else {
        await notifica(
          context,
          "แสดงข้อมูลที่ยังไม่ได้จัดกลุ่มไม่สำเร็จ",
        );
      }

      return futureNotManagerGroup;
    } catch (error) {
      print(error);
      await Future.delayed(Duration(seconds: 5));
      setState(() {});
    }
    return [];
  }

  late TextEditingController searchEdit;
  List<MemberNotManagerGroup> listSearchEmail = [];
  Map<String, bool> searchLord = {};
  @override
  void dispose() {
    // TODO: implement dispose
    print("copySeach.length ${widget.listvievDutySearch.length}");
    // widget.listvievDutySearch = copySeach;
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getManagerNotGroupModel(token: FFAppState().tokenStore);

      // print("${namedeleteMangerGroup}");

      // setState(() {
      //   listSearchEmail = widget.listvievDutySearch;
      // });
      // for (var i = 0; i < listSearchEmail.length; i++) {
      //   searchLord.addEntries({"refrest${i}": false}.entries);
      // }
      setState(() {
        listSearchEmail = widget.listvievDutySearch;
      });

      for (var i = 0; i < listSearchEmail.length; i++) {
        searchLord.addEntries({"refrest${i}": false}.entries);
      }
    });
    searchEdit = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext, BoxConstraints) {
      print("listSearchEmail.lentttt ${listSearchEmail.length}");
      return AlertDialog(
        title: Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: TextFormField(
              controller: searchEdit,
              onChanged: (string) {
                setState(() {
                  listSearchEmail = widget.listvievDutySearch
                      .where((u) =>
                          u.email!.toLowerCase().toString().contains(string))
                      .toList();
                });
                print("listSearchEmail ${listSearchEmail.length}");
              },
              obscureText: false,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'ค้นหา',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  size: 16,
                ),
              ),
              style: FlutterFlowTheme.of(context).title3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Builder(
            builder: (context) {
              return ListView.builder(
                itemCount: listSearchEmail.length,
                itemBuilder: (context, int indexAllDuty) {
                  print(
                      "widget.nameGroup ${widget.nameGroup} ${listSearchEmail[indexAllDuty].email}");
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://picsum.photos/seed/180/600',
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${listSearchEmail[indexAllDuty].fristName} ${listSearchEmail[indexAllDuty].lastName}",
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                  Text(
                                    '${listSearchEmail[indexAllDuty].email}',
                                    style: FlutterFlowTheme.of(context).title3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                searchLord["refrest${indexAllDuty}"] = true;
                              });
                              final addMemberOutPut = await AddMemberCall.call(
                                token: FFAppState().tokenStore,
                                email: '${listSearchEmail[indexAllDuty].email}',
                                nameGroup: '${widget.nameGroup}',
                              );
                              final output = AddMemberCall.getState(
                                  addMemberOutPut.jsonBody);
                              print("output ${output["message"]}");
                              if (addMemberOutPut.statusCode == 200) {
                                if (output["message"] ==
                                    "ผู้ใช้งานนี้มีการจัดตารางขึ้นเวรแล้ว") {
                                  await actions.notifica(
                                    context,
                                    '${output["message"]}',
                                  );
                                  if (mounted) {
                                    setState(() {
                                      searchLord["refrest${indexAllDuty}"] =
                                          false;
                                    });
                                  }
                                } else {
                                  await actions.notifica(
                                      context, 'ส่งคำเชิญแล้ว',
                                      color: Colors.green);
                                  if (mounted) {
                                    setState(() {
                                      searchLord["refrest${indexAllDuty}"] =
                                          false;
                                    });
                                  }
                                  Navigator.pop(context);
                                }
                              } else {
                                await actions.notifica(
                                  context,
                                  'ส่งคำเชิญไม่สำเร็จ',
                                );
                                if (mounted) {
                                  setState(() {
                                    searchLord["refrest${indexAllDuty}"] = true;
                                  });
                                }
                              }

                              // setState(() {
                              //   refresh = !refresh;
                              // });
                            },
                            child: searchLord["refrest${indexAllDuty}"] == false
                                ? Text(
                                    'เพิ่ม',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Mitr',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBlue,
                                        ),
                                  )
                                : CircularProgressIndicator(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                print("${searchLord["refrest1"]} ${searchLord}");
                Navigator.pop(context);
              },
              child: Text(
                'ยกเลิก',
                style: GoogleFonts.mitr(color: Colors.red, fontSize: 24),
              ),
            ),
          ),
        ],
      );
    });
  }
}
