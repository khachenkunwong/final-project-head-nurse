import 'package:bitsdojo_window/bitsdojo_window.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../forgetemail/forgetemail_widget.dart';
import '../main.dart';
import '../register/register_widget.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  ApiCallResponse? getpresentoutput;
  ApiCallResponse? stateLogin;
  ApiCallResponse? stateCreateTable;
  TextEditingController? textController1;
  TextEditingController? textController2;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String checkActor;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: 'leader@gmail.com');
    textController2 = TextEditingController(text: 'leader');
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/background.png',
                ).image,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // WindowTitleBarBox(
                //   child: Row(
                //     children: [
                //       Expanded(child: MoveWindow()),
                //       const WindowButtons()
                //     ],
                //   ),
                // ),
                Material(
                  color: Colors.transparent,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 701,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x0D000000),
                          offset: Offset(0, 4),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Hero(
                                tag: 'HosApp',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/274839699_1333130893857613_7481782092199286452_n_1.png',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                                child: Text(
                                  'อีเมล',
                                  style: FlutterFlowTheme.of(context).title2,
                                ),
                              ),
                              TextFormField(
                                controller: textController1,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'กรอกอีเมลตรงนี้',
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
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 17, 0, 0),
                                child: Text(
                                  'รหัสผ่าน',
                                  style: FlutterFlowTheme.of(context).title2,
                                ),
                              ),
                              TextFormField(
                                controller: textController2,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  hintText: 'กรอกรหัสผ่านตรงนี้',
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
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF757575),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).title3,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                try {
                                  stateLogin = await PostLoginCall.call(
                                    email: textController1!.text,
                                    password: textController2!.text,
                                  );

                                  if (((stateLogin?.statusCode ?? 200)) ==
                                      200) {
                                    setState(() {
                                      FFAppState().tokenStore =
                                          PostLoginCall.resToken(
                                        (stateLogin?.jsonBody ?? ''),
                                      ).toString();
                                    });
                                    checkActor = PostLoginCall.resActor(
                                      (stateLogin?.jsonBody ?? ''),
                                    ).toString();
                                    if (checkActor == "หัวหน้าพยาบาล") {
                                      // getpresentoutput = await GetPresentCall.call(
                                      //   token: FFAppState().tokenStore,
                                      // );
                                      print("frist ${FFAppState().tokenStore}");
                                      await actions.notifica(
                                        context,
                                        'เข้าสู่ระบบสำเร็จ',
                                        color: Colors.green
                                      );

                                      // stateCreateTable =
                                      //     await CreateTableCall.call();
                                      // if (((stateCreateTable?.statusCode ?? 200)) ==
                                      //         200
                                      //     //     &&
                                      //     // ((getpresentoutput?.statusCode ?? 200)) ==
                                      //     //     200
                                      //         ) {
                                      // await actions.notifica(
                                      //   context,
                                      //   'สร้างตารางสำเร็จ',
                                      // );
                                      // setState(() {
                                      //   FFAppState().namegroup =
                                      //       GetPresentCall.oneNameGroup(
                                      //     (getpresentoutput?.jsonBody ?? ''),
                                      //   ).toString();
                                      // });

                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NavBarPage(
                                              initialPage: 'workschedule'),
                                        ),
                                      );
                                      // } else {
                                      //   await actions.notifica(
                                      //     context,
                                      //     'สร้างตารางไม่สำเร็จ',
                                      //   );
                                      // }
                                    } else {
                                      await actions.notifica(
                                        context,
                                        'คุณไม่ใช้หัวหน้าพยาบาล',
                                      );
                                      FFAppState().tokenStore = "";
                                    }
                                  } else {
                                    await actions.notifica(
                                      context,
                                      'ชื่อหรือรหัสผ่านไม่ถูกต้อง',
                                    );
                                    FFAppState().tokenStore = "";
                                  }

                                  setState(() {});
                                }
                                // on Exception{
                                //   await actions.notifica(
                                //     context,
                                //     'กรุณาเชื่อมต่ออินเทอร์เน็ต',
                                //   );
                                //   setState(() {});

                                // }
                                catch (error) {
                                  print(error);
                                  await actions.notifica(
                                    context,
                                    'เกิดข้อผิดพลาด',
                                  );
                                  FFAppState().tokenStore = "";
                                  setState(() {});
                                }
                              },
                              text: 'เข้าสู่ระบบ',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 66,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle:
                                    FlutterFlowTheme.of(context).bodyText1,
                                elevation: 10,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.8, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgetemailWidget(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'ลืมรหัสผ่าน?',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 41, 0, 47),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ยังไม่มีบัญชี?',
                                  style: FlutterFlowTheme.of(context).subtitle1,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterWidget(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    ' ลงทะเบียน',
                                    style:
                                        FlutterFlowTheme.of(context).bodyText2,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
