import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LeavedetailsWidget extends StatefulWidget {
  const LeavedetailsWidget({Key? key}) : super(key: key);

  @override
  _LeavedetailsWidgetState createState() => _LeavedetailsWidgetState();
}

class _LeavedetailsWidgetState extends State<LeavedetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 7, 0, 10),
            child: Text(
              'รายละเอียด คำขอการลา',
              style: FlutterFlowTheme.of(context).title1.override(
                    fontFamily: FlutterFlowTheme.of(context).title1Family,
                    fontSize: 30,
                  ),
            ),
          ),
          Divider(
            height: 2,
            color: FlutterFlowTheme.of(context).primaryBlack,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'ชื่อ นามสกุล',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidAddressCard,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'ประเภทการลา',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidAddressCard,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'รายละเอียด',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.send,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'วันที่รายการ',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'วันที่ขอลา',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.calendarAlt,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'จำนวนวันลา',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'จำนวนการลาที่เหลือ',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'จำนวนวันลา',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.star_outline_sharp,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'สถานะ',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.attach_file,
                          color: Colors.black,
                          size: 38,
                        ),
                        Text(
                          'ไฟล์แนบ',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' : นาย Jonh liam',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                    Text(
                      ': ลากิจ',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                    Text(
                      ': เนื่องจากป่วยเป็นโควิดจึงไม่ได้มาทำงาน',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                    Text(
                      ': 12 เม.ย 2562',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                    Text(
                      ': 12 เม.ย 2562 - 21 เม.ย 2565 ',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                    Text(
                      ': 7 วัน',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                    Text(
                      ': 5 ครั้ง',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                    Text(
                      ': 0883011544',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                    Text(
                      ': อนุมัติ',
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).title2Family,
                            color: FlutterFlowTheme.of(context).primaryGreen,
                          ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'ดาวโหลด',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle: FlutterFlowTheme.of(context).bodyText1,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
