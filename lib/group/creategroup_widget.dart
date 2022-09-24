import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

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
          // ยังไม่เสร็จ
          child: Focus(
            onKey: (node, event) {
              KeyEventResult result = KeyEventResult.ignored;
              // Activates all key bindings that match, returns handled if any handle it.
              // for (final ShortcutActivator activator in bindings.keys) {
              //   if (activator.accepts(event, RawKeyboard.instance)) {
              //     bindings[activator]!.call();
              //     result = KeyEventResult.handled;
              //   }
              // }
              // print("result ${result} - $node - $event ");
              if (event.logicalKey.keyLabel == "Control Left" && event.logicalKey.keyLabel == "Meta Left"){
                result = KeyEventResult.handled;
              }
              return result;
            },
            onKeyEvent: (node, event) {
              KeyEventResult result2 = KeyEventResult.ignored;
              if (event.logicalKey.keyLabel == "Control Left" && event.logicalKey.keyLabel == "Meta Left"){
                result2 = KeyEventResult.handled;
              }


              print("result2 ${event.logicalKey.keyLabel}");
              return result2;
            },
            child: TextFormField(
              controller: textControllernamegroup,
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'กรุณาใส่ชื่อกลุ่ม',
                hintStyle: GoogleFonts.mitr(
                  color: Color(0xFFBDBDBD),
                  fontWeight: FontWeight.normal,
                  fontSize: 28,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFBDBDBD),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF727272),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: GoogleFonts.mitr(
                color: Color(0xFF727272),
                fontWeight: FontWeight.normal,
                fontSize: 28,
              ),
            ),
          ),
        ),
      ),
      actions: [
        lord1 == false
            ? TextButton(
                onPressed: () async {
                  try {
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
                        await actions.notifica(context, 'สร้างกลุ่มเสร็จสิ้น',
                            color: Colors.green);
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
                  } catch (error) {
                    print(error);
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
