import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../app_state.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../custom_code/actions/index.dart' as actions;

class CreateGroupWidget extends StatefulWidget {
  const CreateGroupWidget({Key? key}) : super(key: key);

  @override
  State<CreateGroupWidget> createState() => _CreateGroupWidgetState();
}

class _CreateGroupWidgetState extends State<CreateGroupWidget> {
  bool lord1 = false;
  TextEditingController? textControllernamegroup;
  ApiCallResponse? createGroupOutput;
  @override
  void initState() {
    textControllernamegroup = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  color: FlutterFlowTheme.of(context).secondaryText,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: FlutterFlowTheme.of(context).title3,
          ),
        ),
      ),
      actions: [
        lord1 == false
            ? TextButton(
                onPressed: () async {
                  if (textControllernamegroup!.text.length != 0 &&
                      textControllernamegroup!.text != null) {
                    setState(() {
                      lord1 = true;
                    });

                    createGroupOutput = await CreateGroupCall.call(
                      token: FFAppState().tokenStore,
                      nameGroup: '${textControllernamegroup?.text}',
                    );
                    if ((createGroupOutput?.statusCode ?? 200) == 200) {
                      if (mounted) {
                        setState(() {
                          lord1 = false;
                        });
                      }
                      await actions.notifica(
                        context,
                        'สร้างกลุ่มเสร็จสิ้น',
                      );
                    } else {
                      if (mounted) {
                        setState(() {
                          lord1 = false;
                        });
                      }
                      await actions.notifica(
                        context,
                        'สร้างกลุ่มไม่เสำเร็จ',
                      );
                    }

                    if (mounted) {
                      setState(() => lord1 = false);
                    }
                    Navigator.pop(context);
                  } else {
                    await actions.notifica(
                      context,
                      'กรุณากรอกชื่อกลุ่ม',
                    );
                  }
                },
                child: Text(
                  'สร้างกลุ่ม',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
              )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                  color: Color(0xFF00A2FD),
                ),
            )
      ],
    );
  }
}
