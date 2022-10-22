import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hos_windown/group/creategroup_widget.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/pubilc_.dart';
import '../custom_code/actions/notifica.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/actions/index.dart' as actions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/all_member_without_me.dart';
import '../model/member_model.dart';
import '../model/not_manager_group_model.dart';
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
  List<MemberNotManagerGroup>? listvievDutySearch;
  List<MemberNotManagerGroup>? listSearchEmail;
  List<Datum>? listvievDutySearch2;
  List<Datum>? listSearchEmail2;
  List<Group> showGroup = [];
  TextEditingController? controllerlimit;
  TextEditingController? controllerlimittest;
  List<TextEditingController> _controllers = [];

  Map<String, bool> deleteLord = {};
  Map<String, bool> editLimit = {};
  bool lord1 = false;
  var refresh;
  int stoprerun = 0;
  // อัพเดตจำนวนสมาชิกสูงสุด
  updatalimitmember({required String groupId, required String limit}) async {
    var headers = {
      'Authorization': '${FFAppState().tokenStore}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$url/graphql'));
    request.body =
        '''{"query":"mutation UpdateGroup(\$input: UpdateGroupInput!) {\\r\\n  updateGroup(input: \$input) {\\r\\n    _id\\r\\n    limit\\r\\n  }\\r\\n}","variables":{"input":{"_id":"$groupId","limit":$limit}}}''';
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await notifica(context, "อัพเดตจำนวนสมาชิกสูงสุดสำเร็จ",
          color: Colors.green);
    } else {
      print(response.reasonPhrase);
      await notifica(context, "อัพเดตจำนวนสมาชิกสูงสุดไม่สำเร็จ");
    }
  }

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
      if (res.statusCode == 200) {
        // for (int i = 0; i < futureNotManagerGroup.length; i++) {
        //   actorNotMangerGroup.add(futureNotManagerGroup[i].actor.toString());
        // }
        if (listvievDutySearch?.length == 0 || listvievDutySearch == null) {
          setState(() {
            listvievDutySearch = futureNotManagerGroup;
            listSearchEmail = listvievDutySearch;
          });
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
        for (var indexGroupNumber = 0;
            indexGroupNumber < futureMember.length;
            indexGroupNumber++) {
          for (var indexMemberNumber = 0;
              indexMemberNumber < futureMember[indexGroupNumber].member!.length;
              indexMemberNumber++) {
            deleteLord.addEntries({
              "refrest $indexGroupNumber $indexMemberNumber": false
            }.entries);
          }
          if (futureMember[indexGroupNumber].deleted == false) {
            showGroup.add(futureMember[indexGroupNumber]);
            // showGroup[indexGroupNumber] = ;
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
      print("res.body3 ${res.statusCode}");
      print("res.body3 ${res.body}");

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
        final _futureAllDuty = AllMemberwithout.fromJson(bodyAllDuty);
        final futureAllDuty = _futureAllDuty.data as List<Datum>;
        print("armmsttt");
        if (listvievDutySearch2?.length == 0 || listvievDutySearch2 == null) {
          setState(() {
            listvievDutySearch2 = futureAllDuty;
            listSearchEmail2 = listvievDutySearch2;
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
        await actions.notifica(context, "ลบสมาชิกสำเร็จ", color: Colors.green);
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

  Future<List<Datum>> deleteGroup({required String groupId}) async {
    try {
      var headers = {
        'Authorization': '${FFAppState().tokenStore}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$url/graphql'));
      request.body =
          '''{"query":"mutation DeleteGroup(\$input: DeleteGroupInput!) {\\r\\n  deleteGroup(input: \$input)\\r\\n}","variables":{"input":{"groupId":"$groupId"}}}''';

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        await actions.notifica(context, "ลบกลุ่มสำเร็จ", color: Colors.green);
      } else {
        print(response.reasonPhrase);
        await actions.notifica(context, "ลบกลุ่มไม่สำเร็จ");
      }

      //

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
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      futureMember = getMemberModel(token: FFAppState().tokenStore);
    });
    // อันนี้ลบออกเมื่อใช้เสร็จ
    refresh = false;

    // FFAppState().tokenStore =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjp7InN1YiI6IjYyY2JjNGU1NDIwYzllMWFmZjJkN2I4MCIsInYiOjF9LCJpYXQiOjE2NTkxNjQwNDEsImV4cCI6MTY1OTc2ODg0MX0.nCsqVj5aA5znhFnguY89aTF2oZzaya-t4miI4waLeu8";
    // //
  }

  @override
  Widget build(BuildContext context) {
    futureAllDuty = getAllMemberWhithOut(token: FFAppState().tokenStore);
    getManagerNotGroupModel(token: FFAppState().tokenStore);
    // futureAllDuty = getAllMemberWhithOut(token: FFAppState().tokenStore);
    print("scaffold");
    print("$listvievDutySearch2");
    if (listvievDutySearch2?.length == 0 || listvievDutySearch2 == null) {
      setState(() {
        listSearchEmail2 = listvievDutySearch2;
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
                      // final GetGroupMyMemberResponse = snapshotGroup.data!;
                      // if (snapshotGroup.data.isEmpty)
                      print("snapshotGroup.data.isEmpty ${snapshotGroup.data?.length}");
                      if (snapshotGroup.data?.isEmpty == null ||
                          snapshotGroup.data?.length == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text("ยังไม่มีสร้างกลุ่ม",style: GoogleFonts.mitr(fontSize: 24,color: Colors.black),)),
                          ],
                        );
                      }
                      return Builder(
                        builder: (context) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              print("refresh");
                              setState(() => _apiRequestCompleter = null);
                              // await waitForApiRequestCompleter(minWait: 2.0);
                            },
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 700.0,
                                      childAspectRatio: 3 / 3,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: showGroup.length,
                              itemBuilder: (context, indexGroup) {
                                print(
                                    "GetGroupMyMemberResponse.length ${showGroup[indexGroup].deleted}");
                                final ItemGroup = showGroup[indexGroup];

                                editLimit.addAll({"$indexGroup": false});
                                // if (stoprerun <= showGroup.length) {

                                //   stoprerun += 1;
                                _controllers.add(TextEditingController(
                                    text: "${ItemGroup.limit}"));
                                // }

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
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('ลบกลุ่ม',
                                                        style: GoogleFonts.mitr(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white)),
                                                    Text(
                                                      'ชื่อกลุ่ม ${ItemGroup.nameGroup}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title2,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        // ลบกลุ่ม
                                                        await deleteGroup(
                                                            groupId:
                                                                ItemGroup.id!);
                                                      },
                                                      child:
                                                          // Icon(
                                                          //   Icons.folder_delete,
                                                          //   color: Colors.red,
                                                          //   size: 30.0,
                                                          // ),
                                                          Text(
                                                        'ลบกลุ่ม',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Mitr',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryRed,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
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
                                                                            MemberNotManagerGroup>,
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
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'สมาชิก',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title2,
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              editLimit[
                                                                      "$indexGroup"] =
                                                                  true;
                                                            });
                                                            print(
                                                                "editLimit $editLimit  ${editLimit["$indexGroup"]}");
                                                          },
                                                          child: Text(
                                                            '${ItemGroup.member!.length - 1}/',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Mitr',
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 26,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 50.0,
                                                          child: TextFormField(
                                                              controller:
                                                                  _controllers[
                                                                      indexGroup],
                                                              obscureText:
                                                                  false,
                                                              style: GoogleFonts
                                                                  .mitr(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "จำนวนสมาชิก",
                                                                hintStyle: GoogleFonts.mitr(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .grey),
                                                              )),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              // setState(() {
                                                              //   controllerlimit
                                                              //       .text = "";
                                                              // });
                                                            },
                                                            icon: Icon(
                                                                Icons.close)),
                                                        IconButton(
                                                            onPressed: () {
                                                              if (_controllers[
                                                                              indexGroup]
                                                                          .text
                                                                          .isNotEmpty !=
                                                                      null &&
                                                                  int.parse(
                                                                          "${_controllers[indexGroup].text.length}") >
                                                                      0) ;
                                                              print(
                                                                  "999  ${_controllers[indexGroup].text}");
                                                              updatalimitmember(
                                                                  groupId:
                                                                      "${ItemGroup.id}",
                                                                  limit:
                                                                      "${_controllers[indexGroup].text}");
                                                            },
                                                            icon: Icon(
                                                                Icons.save))
                                                      ],
                                                    ),
                                                  ],
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
                                                                            child: deleteLord["refrest $indexGroup $indexMember"] == false
                                                                                ? InkWell(
                                                                                    onTap: () async {
                                                                                      setState(() {
                                                                                        deleteLord["refrest $indexGroup $indexMember"] = true;
                                                                                      });
                                                                                      // print("yyyy ${ItemGroup.id} - ${itemMember.email}");
                                                                                      // getDeleteMember = await DeleteMemberInGroupCall.call(groupId: "${ItemGroup.id}", email: "${itemMember.email}", token: FFAppState().tokenStore);
                                                                                      // print("id group ${ItemGroup.id} id member ${itemMember.email} fristName ${itemMember.fristName} lastName ${itemMember.lastName}");
                                                                                      // print("ลบสมาชิก");
                                                                                      await deleteMember(email: "${itemMember.email}", groupId: "${ItemGroup.id}");
                                                                                      print("ทำงานเสร็จแล้ว");
                                                                                      if (mounted) {
                                                                                        setState(() {
                                                                                          deleteLord["refrest $indexGroup $indexMember"] = false;
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                    child: Icon(
                                                                                      Icons.delete,
                                                                                      color: Colors.red,
                                                                                    )
                                                                                    // Text(
                                                                                    //   'ลบ',
                                                                                    //   style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                    //         fontFamily: 'Mitr',
                                                                                    //         color: FlutterFlowTheme.of(context).primaryRed,
                                                                                    //       ),
                                                                                    // ),
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
                              // separatorBuilder:
                              //     (BuildContext context, int index) {
                              //   return SizedBox(
                              //     width: 5.0,
                              //     height: 5.0,
                              //   );
                              // },
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
