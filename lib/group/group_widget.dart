import 'package:easy_debounce/easy_debounce.dart';

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

class GroupWidget extends StatefulWidget {
  const GroupWidget({Key? key}) : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  ApiCallResponse? createGroupOutput;
  ApiCallResponse? getDeleteMember;
  Completer<ApiCallResponse>? _apiRequestCompleter;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController searchEdit;
  Future<List<Group>>? futureMember;
  Future<List<Datum>>? futureAllDuty;
  TextEditingController? textControllernamegroup;
  bool lord1 = false;
  var refresh;
  Future<List<Group>> getMemberModel({required String token}) async {
    try {
      setState(() {
        
      });
      print(token);
      final res = await http.get(
        Uri.parse("$url/api/group/me/member"),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          "x-access-token": "$token"
        },
      );
      // print("res.body1 ${res.statusCode}");
      // print("res.body1 ${res.body}");

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // อันนี้ลบออกเมื่อใช้เสร็จ
    refresh = false;
    // FFAppState().tokenStore =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjp7InN1YiI6IjYyY2JjNGU1NDIwYzllMWFmZjJkN2I4MCIsInYiOjF9LCJpYXQiOjE2NTkxNjQwNDEsImV4cCI6MTY1OTc2ODg0MX0.nCsqVj5aA5znhFnguY89aTF2oZzaya-t4miI4waLeu8";
    // //

    textControllernamegroup = TextEditingController(text: '');
    searchEdit = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    futureMember = getMemberModel(token: FFAppState().tokenStore);
    futureAllDuty = getAllMemberWhithOut(token: FFAppState().tokenStore);
    print("scaffold");
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
                                                              return AlertDialog(
                                                                title: Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          searchEdit,
                                                                      onChanged:
                                                                          (_) =>
                                                                              EasyDebounce.debounce(
                                                                        'textController',
                                                                        Duration(
                                                                            milliseconds:
                                                                                2000),
                                                                        () => setState(
                                                                            () {}),
                                                                      ),
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        hintText:
                                                                            'ค้นหา',
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.white,
                                                                        prefixIcon:
                                                                            Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .title3,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                ),
                                                                content:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.5,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.4,
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          Datum>>(
                                                                    future:
                                                                        futureAllDuty,
                                                                    builder:
                                                                        ((context,
                                                                            snapshotAllDuty) {
                                                                      if (!snapshotAllDuty
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              color: FlutterFlowTheme.of(context).primaryColor,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      final listViewAllDuty =
                                                                          snapshotAllDuty
                                                                              .data!;
                                                                      return Builder(
                                                                          builder:
                                                                              (context) {
                                                                        print(listViewAllDuty
                                                                            .length);
                                                                        return ListView
                                                                            .builder(
                                                                          itemCount:
                                                                              listViewAllDuty.length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int indexAllDuty) {
                                                                            final itemAllDuty =
                                                                                listViewAllDuty[indexAllDuty];
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
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              "${itemAllDuty.fristName} ${itemAllDuty.lastName}",
                                                                                              style: FlutterFlowTheme.of(context).title2,
                                                                                            ),
                                                                                            Text(
                                                                                              '${itemAllDuty.email}',
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
                                                                                        final addMemberOutPut = await AddMemberCall.call(
                                                                                          token: FFAppState().tokenStore,
                                                                                          email: '${itemAllDuty.email}',
                                                                                          nameGroup: '${ItemGroup.nameGroup}',
                                                                                        );
                                                                                        if (addMemberOutPut.statusCode == 200) {
                                                                                          Navigator.pop(context);
                                                                                          await actions.notifica(
                                                                                            context,
                                                                                            'เพิ่มสมาชิกสำเร็จ',
                                                                                          );

                                                                                          setState(() {});
                                                                                        } else {
                                                                                          await actions.notifica(
                                                                                            context,
                                                                                            'เพิ่มสมาชิกไม่เสำเร็จ',
                                                                                          );
                                                                                        }

                                                                                        setState(() {
                                                                                          refresh = !refresh;
                                                                                        });
                                                                                      },
                                                                                      child: Text(
                                                                                        'เพิ่ม',
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'Mitr',
                                                                                              color: FlutterFlowTheme.of(context).primaryBlue,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      });
                                                                    }),
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext),
                                                                    child: Text(
                                                                        'Ok'),
                                                                  ),
                                                                ],
                                                              );
                                                            });
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
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () async {
                                                                                getDeleteMember = await DeleteMemberInGroupCall.call(token: FFAppState().tokenStore, groupId: "${ItemGroup.id}", userId: "${itemMember.id}");
                                                                                print("id group ${ItemGroup.id} id member ${itemMember.id} fristName ${itemMember.fristName} lastName ${itemMember.lastName}");
                                                                                print("ลบสมาชิก");
                                                                                print("${DeleteMemberInGroupCall.getRes(getDeleteMember?.jsonBody ?? '')}}");
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                'ลบ',
                                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                      fontFamily: 'Mitr',
                                                                                      color: FlutterFlowTheme.of(context).primaryRed,
                                                                                    ),
                                                                              ),
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
                            return AlertDialog(
                              title: SizedBox(
                                height: 100.0,
                                width: 500.0,
                                child: Center(
                                  child: TextFormField(
                                    controller: textControllernamegroup,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'กรุณาใส่ชื่อกลุ่ม',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: FlutterFlowTheme.of(context).title3,
                                  ),
                                ),
                              ),
                              actions: [
                                lord1
                                    ? CircularProgressIndicator(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                      )
                                    : TextButton(
                                        onPressed: () async {
                                          if (textControllernamegroup!
                                                      .text.length !=
                                                  0 &&
                                              textControllernamegroup!.text !=
                                                  null) {
                                            setState(() {
                                              lord1 = true;
                                            });

                                            createGroupOutput =
                                                await CreateGroupCall.call(
                                              token: FFAppState().tokenStore,
                                              nameGroup:
                                                  '${textControllernamegroup?.text}',
                                            );
                                            if ((createGroupOutput
                                                        ?.statusCode ??
                                                    200) ==
                                                200) {
                                              await actions.notifica(
                                                context,
                                                'สร้างกลุ่มเสร็จสิ้น',
                                              );
                                            } else {
                                              await actions.notifica(
                                                context,
                                                'สร้างกลุ่มไม่เสำเร็จ',
                                              );
                                            }

                                            if (mounted) {
                                              setState(() => lord1 = false);
                                            }
                                            Navigator.pop(alertDialogContext);
                                          } else {
                                            await actions.notifica(
                                              context,
                                              'กรุณากรอกชื่อกลุ่ม',
                                            );
                                          }
                                        },
                                        child: Text(
                                          'สร้างกลุ่ม',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2,
                                        ),
                                      ),
                              ],
                            );
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
