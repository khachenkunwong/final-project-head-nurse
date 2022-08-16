import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnextEmailYesNoWidget extends StatefulWidget {
  const ConnextEmailYesNoWidget({Key? key}) : super(key: key);

  @override
  _ConnextEmailYesNoWidgetState createState() =>
      _ConnextEmailYesNoWidgetState();
}

class _ConnextEmailYesNoWidgetState extends State<ConnextEmailYesNoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'คุณต้องการเข้ากลุ่มใช้หรือไหม',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: FlutterFlowTheme.of(context).bodyText1Family,
                color: FlutterFlowTheme.of(context).primaryBlack,
              ),
        ),
        SvgPicture.asset(
          'assets/images/email.svg',
          width: 24,
          height: 19,
          fit: BoxFit.cover,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'ใช้',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyText1Family,
                    color: FlutterFlowTheme.of(context).primaryBlue,
                  ),
            ),
            Text(
              'ไม่ใช้',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyText1Family,
                    color: FlutterFlowTheme.of(context).primaryRed,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
