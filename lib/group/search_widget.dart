import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_state.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../custom_code/actions/index.dart' as actions;
import '../model/all_member_without_me.dart';
import '../model/member_model.dart';

class SearchWidget extends StatefulWidget {
  final List<Datum> listvievDutySearch;
  final String nameGroup;
  const SearchWidget(
      {Key? key, required this.listvievDutySearch, required this.nameGroup})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController searchEdit;
  List<Datum> listSearchEmail = [];
  Map<String, bool> searchLord = {};
  @override
  void initState() {
    // TODO: implement initState
    searchEdit = TextEditingController(text: "");
    super.initState();
    listSearchEmail = widget.listvievDutySearch;
    for (var i = 0; i < listSearchEmail.length; i++) {
      searchLord.addEntries({"refrest${i}": false}.entries);
    }
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
                  
                  print("widget.nameGroup ${widget.nameGroup} ${listSearchEmail[indexAllDuty].email}");
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
                              if (addMemberOutPut.statusCode == 200) {
                                await actions.notifica(
                                  context,
                                  'เพิ่มสมาชิกสำเร็จ',
                                );
                                if (mounted) {
                                  setState(() {
                                    searchLord["refrest${indexAllDuty}"] = false;
                                  });
                                }
                                Navigator.pop(context);
                              } else {
                                await actions.notifica(
                                  context,
                                  'เพิ่มสมาชิกไม่เสำเร็จ',
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
