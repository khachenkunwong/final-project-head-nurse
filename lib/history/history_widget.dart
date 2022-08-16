import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  String? dropDownValue1;
  String? dropDownValue2;
  String? dropDownValue3;
  String? dropDownValue4;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryWhite,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                            child: FaIcon(
                              FontAwesomeIcons.check,
                              color: FlutterFlowTheme.of(context).primaryBlue01,
                              size: 50,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(26, 0, 24, 0),
                            child: Text(
                              'ประวัติอนุมัติ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBlue01,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryGrayWhite,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                            child: FaIcon(
                              FontAwesomeIcons.check,
                              color:
                                  FlutterFlowTheme.of(context).secondaryWhite,
                              size: 50,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(26, 0, 24, 0),
                            child: Text(
                              'ประวัติไม่อนุมัติ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryWhite,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryWhite,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'แสดง',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                            FlutterFlowDropDown(
                              options: ['10 รายการ', '20 รายการ', '30 รายการ'],
                              onChanged: (val) =>
                                  setState(() => dropDownValue1 = val),
                              width: 180,
                              height: 48,
                              textStyle:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title1Family,
                                        fontSize: 24,
                                      ),
                              hintText: '30 รายการ',
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                              borderRadius: 0,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                            Text(
                              'ค้นหาตั้งแต่',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                            FlutterFlowDropDown(
                              options: ['10 รายการ', '20 รายการ', '30 รายการ'],
                              onChanged: (val) =>
                                  setState(() => dropDownValue2 = val),
                              width: 180,
                              height: 48,
                              textStyle:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title1Family,
                                        fontSize: 24,
                                      ),
                              hintText: '30 รายการ',
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                              borderRadius: 0,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                            Text(
                              'ถึง',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                            FlutterFlowDropDown(
                              options: ['10 รายการ', '20 รายการ', '30 รายการ'],
                              onChanged: (val) =>
                                  setState(() => dropDownValue3 = val),
                              width: 180,
                              height: 48,
                              textStyle:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title1Family,
                                        fontSize: 24,
                                      ),
                              hintText: '30 รายการ',
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                              borderRadius: 0,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                            Text(
                              'ประเภทการลา',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                            FlutterFlowDropDown(
                              options: [
                                'ลาป่วย',
                                'ลากิจส่วนตัว',
                                'ลาคลอดบุตร',
                                'ลาไปช่วยภริยาคลอดบุตร',
                                'ลาไปศึกษา,ฝึกอบรม,ปฎิบัติการวิจัย,หรือดูงาน',
                                'ลาคัดเลือกทหาร',
                                'ทั้งหมด'
                              ],
                              onChanged: (val) =>
                                  setState(() => dropDownValue4 = val),
                              width: 180,
                              height: 48,
                              textStyle:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title1Family,
                                        fontSize: 24,
                                      ),
                              hintText: 'ทั้งหมด',
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                              borderRadius: 0,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'ค้นหา',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 61,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title3Family,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryWhite,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
