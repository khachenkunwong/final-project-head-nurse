import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../login/login_widget.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstscreenWidget extends StatefulWidget {
  const FirstscreenWidget({Key? key}) : super(key: key);

  @override
  _FirstscreenWidgetState createState() => _FirstscreenWidgetState();
}

class _FirstscreenWidgetState extends State<FirstscreenWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      hideBeforeAnimating: false,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 3000));
      if (FFAppState().tokenStore == null || FFAppState().tokenStore == '') {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginWidget(),
          ),
        );
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavBarPage(initialPage: 'workschedule'),
          ),
        );
      }
    });

    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Hero(
                  tag: 'HosApp',
                  transitionOnUserGestures: true,
                  child: Image.asset(
                    'assets/images/274839699_1333130893857613_7481782092199286452_n_1.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ).animated([animationsMap['imageOnPageLoadAnimation']!]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
