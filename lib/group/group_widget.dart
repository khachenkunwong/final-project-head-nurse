import 'package:easy_debounce/easy_debounce.dart';
import 'package:hos_windown/group/creategroup_widget.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/actions/index.dart' as actions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/all_member_without_me.dart';
import '../model/member_model.dart';
import 'search_widget.dart';

class GroupWidget extends StatefulWidget {
  const GroupWidget({Key? key}) : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  
  ApiCallResponse? getDeleteMember;
  Completer<ApiCallResponse>? _apiRequestCompleter;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Group>>? futureMember;
  Future<List<Datum>>? futureAllDuty;
  List<Datum>? listvievDutySearch;
  List<Datum>? listSearchEmail;

  Map<String, bool> deleteLord = {};
  bool lord1 = false;
  var refresh;
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
      print("res.body1 ${res.statusCode}");
      print("res.body1 ${res.body}");

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
        final _futureMember =
            MemberCall.fromJson(bodyMember as Map<String, dynamic>);
        final futureMember = _futureMember.group as List<Group>;
        for (var indexGroupNumber = 0;
            indexGroupNumber < futureMember.length;
            indexGroupNumber++) {
          for (var indexMemberNumber = 0;
              indexMemberNumber < futureMember[indexGroupNumber].member!.length;
              indexMemberNumber++) {
            deleteLord.addEntries({
              "refrest ${indexGroupNumber} ${indexMemberNumber}": false
            }.entries);
          }
        }
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

  Future<List<Datum>> getAllMemberWhithOut({required String token}) async {
    try {
      print(token);
      final res = await http.get(
        Uri.parse("$url/api/group/list/member/location"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      // print("res.body2 ${res.statusCode}");
      // print("res.body2 ${res.body}");

      // if (checkUnauthorized) {
      //   await actions.notifica(
      //     context,
      //     'คุณไม่ใช่หัวหน้าพยาบาล',
      //   );
      //   return [];
      // }
      if (res.statusCode == 200) {
        final bodyAllDuty =
            convert.json.decode(res.body) as Map<String, dynamic>;
        final _futureAllDuty =
            AllMemberwithout.fromJson(bodyAllDuty as Map<String, dynamic>);
        final futureAllDuty = _futureAllDuty.data as List<Datum>;
        if (listvievDutySearch?.length == 0 || listvievDutySearch == null) {
          setState(() {
            listvievDutySearch = futureAllDuty;
            listSearchEmail = listvievDutySearch;
          });
        }

        return futureAllDuty;
      }
      await actions.notifica(
        context,
        'คุณไม่ใช่หัวหน้าพยาบาล',
      );
      return [];
    } catch (error) {
      print(error);
    }
    return [];
  }

  Future<List<Datum>> deleteMember(
      {required String groupId, required String email}) async {
    try {
      var body = jsonEncode({
        'groupId': groupId.toString(),
        'email': email.toString(),
      });
      final res = await http.delete(
        Uri.parse("$url/api/group/removemember"),
        headers: {
          'content-type': 'application/json',
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "${FFAppState().tokenStore}"
        },
        body: body,
      );

      print("res.body23 ${res.statusCode}");
      print("res.body23 ${res.body}");

      // if (checkUnauthorized) {
      //   await actions.notifica(
      //     context,
      //     'คุณไม่ใช่หัวหน้าพยาบาล',
      //   );
      //   return [];
      // }

      if (res.statusCode == 200) {
        print("yyyyy ${res.body}}");
        await actions.notifica(context, "ลบสมาชิกสำเร็จ");
      } else {
        print("yyyyy ${res.body}}");
        await actions.notifica(context, "ลบสมาชิกไม่สำเร็จ");
      }

      return [];
    } catch (error) {
      print(error);
    }
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // อันนี้ลบออกเมื่อใช้เสร็จ
    refresh = false;
    // FFAppState().tokenStore =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjp7InN1YiI6IjYyY2JjNGU1NDIwYzllMWFmZjJkN2I4MCIsInYiOjF9LCJpYXQiOjE2NTkxNjQwNDEsImV4cCI6MTY1OTc2ODg0MX0.nCsqVj5aA5znhFnguY89aTF2oZzaya-t4miI4waLeu8";
    // //
  }

  @override
  Widget build(BuildContext context) {
    futureMember = getMemberModel(token: FFAppState().tokenStore);
    futureAllDuty = getAllMemberWhithOut(token: FFAppState().tokenStore);
    print("scaffold");
    print("${listvievDutySearch}");
    if (listvievDutySearch?.length == 0 || listvievDutySearch == null) {
      setState(() {
        listSearchEmail = listvievDutySearch;
      });
    }
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FutureBuilder<List<Group>>(
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
                      final GetGroupMyMemberResponse = snapshotGroup.data!;
                      return Builder(
                        builder: (context) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              print("refresh");
                              setState(() => _apiRequestCompleter = null);
                              // await waitForApiRequestCompleter(minWait: 2.0);
                            },
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: GetGroupMyMemberResponse.length,
                              itemBuilder: (context, indexGroup) {
                                print(
                                    "GetGroupMyMemberResponse.length ${GetGroupMyMemberResponse.length}");
                                final ItemGroup =
                                    GetGroupMyMemberResponse[indexGroup];
                                return Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                      width: 551,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 42, 0, 0),
                                                child: Text(
                                                  'ชื่อกลุ่ม ${ItemGroup.nameGroup}',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .title2,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 9, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 10, 0),
                                                      child: Text(
                                                        'ผู้ดูแล',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title2,
                                                      ),
                                                    ),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      borderWidth: 1,
                                                      buttonSize: 60,
                                                      icon: Icon(
                                                        Icons.add,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 40,
                                                      ),
                                                      onPressed: () async {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return SearchWidget(
                                                                listvievDutySearch:
                                                                    listvievDutySearch
                                                                        as List<
                                                                            Datum>,
                                                                nameGroup: ItemGroup
                                                                    .nameGroup
                                                                    .toString());
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 18, 0, 0),
                                                child: Builder(
                                                  builder: (context) {
                                                    return ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: ItemGroup
                                                          .leader!.length,
                                                      itemBuilder: (context,
                                                          indexLeader) {
                                                        final itemLeader =
                                                            ItemGroup.leader![
                                                                indexLeader];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      10, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Hero(
                                                                tag: 'profile',
                                                                transitionOnUserGestures:
                                                                    true,
                                                                child:
                                                                    Container(
                                                                  width: 45,
                                                                  height: 45,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    'https://picsum.photos/seed/180/600',
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "${itemLeader.fristName} ${itemLeader.lastName}",
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .title2,
                                                                    ),
                                                                    Text(
                                                                      '${itemLeader.email}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .title3,
                                                                    ),
                                                                  ],
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
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 18, 0, 0),
                                                child: Text(
                                                  'สมาชิก',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .title2,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 17, 0, 20),
                                                child: Builder(
                                                  builder: (context) {
                                                    return RefreshIndicator(
                                                      onRefresh: () async {
                                                        setState(() =>
                                                            _apiRequestCompleter =
                                                                null);
                                                        await waitForApiRequestCompleter();
                                                      },
                                                      child:
                                                          ItemGroup.member!
                                                                      .length ==
                                                                  1
                                                              ? Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "ไม่มีสมาชิก",
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title3,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : ListView
                                                                  .builder(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount:
                                                                      ItemGroup
                                                                          .member!
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          indexMember) {
                                                                    final itemMember =
                                                                        ItemGroup
                                                                            .member![indexMember];
                                                                    if (indexMember ==
                                                                        0) {
                                                                      return SizedBox();
                                                                    }

                                                                    return Padding(
                                                                      key: Key(itemMember
                                                                          .id
                                                                          .toString()),
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
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
                                                                                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${itemMember.fristName} ${itemMember.lastName}",
                                                                                      style: FlutterFlowTheme.of(context).title2,
                                                                                    ),
                                                                                    Text(
                                                                                      '${itemMember.email}',
                                                                                      style: FlutterFlowTheme.of(context).title3,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                20,
                                                                                0),
                                                                            child: deleteLord["refrest ${indexGroup} ${indexMember}"] == false
                                                                                ? InkWell(
                                                                                    onTap: () async {
                                                                                      setState(() {
                                                                                        deleteLord["refrest ${indexGroup} ${indexMember}"] = true;
                                                                                      });
                                                                                      // print("yyyy ${ItemGroup.id} - ${itemMember.email}");
                                                                                      // getDeleteMember = await DeleteMemberInGroupCall.call(groupId: "${ItemGroup.id}", email: "${itemMember.email}", token: FFAppState().tokenStore);
                                                                                      // print("id group ${ItemGroup.id} id member ${itemMember.email} fristName ${itemMember.fristName} lastName ${itemMember.lastName}");
                                                                                      // print("ลบสมาชิก");
                                                                                      await deleteMember(email: "${itemMember.email}", groupId: "${ItemGroup.id}");
                                                                                      print("ทำงานเสร็จแล้ว");
                                                                                      if (mounted) {
                                                                                        setState(() {
                                                                                          deleteLord["refrest ${indexGroup} ${indexMember}"] = false;
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                    child: Text(
                                                                                      'ลบ',
                                                                                      style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                            fontFamily: 'Mitr',
                                                                                            color: FlutterFlowTheme.of(context).primaryRed,
                                                                                          ),
                                                                                    ),
                                                                                  )
                                                                                : CircularProgressIndicator(
                                                                                    color: Colors.red,
                                                                                  ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 5.0,
                                  height: 5.0,
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(35, 0, 0, 0),
                  child: InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            
                            return CreateGroupWidget();
                          });
                    },
                    child: Container(
                      width: 252,
                      height: 343,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryWhite,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 84,
                          ),
                          Text(
                            'สร้างกลุ่ม',
                            style: FlutterFlowTheme.of(context).title2.override(
                                  fontFamily:
                                      FlutterFlowTheme.of(context).title2Family,
                                  fontSize: 34,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
