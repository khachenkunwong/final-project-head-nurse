import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterFlowTheme.initialize();

  FFAppState(); // Initialize FFAppState

  runApp(MyApp());
  // doWhenWindowReady(() {
  //   final win = appWindow;
  //   const initialSize = Size(1200, 500);
  //   win.minSize = initialSize;
  //   win.size = initialSize;
  //   win.alignment = Alignment.center;
  //   win.title = "Custom window with Flutter";
  //   win.show();
  // });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HosWindown',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: FirstscreenWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage}) : super(key: key);

  final String? initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'workschedule';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'workschedule': WorkscheduleWidget(),
      'workcalendar': WorkcalendarWidget(),
      'notifications': NotificationsWidget(),
      'history': HistoryWidget(),
      'group': GroupWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      extendBody: true,
      bottomNavigationBar: Row(
        children: [
          FloatingNavbar(
            currentIndex: currentIndex,
            onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
            backgroundColor: Color(0xFFD6D6D6),
            selectedItemColor: Color(0xFF00A2FD),
            unselectedItemColor: Color(0xFF727272),
            selectedBackgroundColor: Color(0x00000000),
            borderRadius: 8,
            itemBorderRadius: 8,
            margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
            elevation: 0,
            items: [
              FloatingNavbarItem(
                customWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 0 ? Icons.home : Icons.home,
                      color: currentIndex == 0
                          ? Color(0xFF00A2FD)
                          : Color(0xFF727272),
                      size: currentIndex == 0 ? 26.0 : 23.0,
                    ),
                    Text(
                      'ตารางงาน',
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Mitr',
                            color: currentIndex == 0
                                ? Color(0xFF00A2FD)
                                : Color(0xFF727272),
                            fontSize: currentIndex == 0 ? 26.0 : 23.0,
                          ),
                    ),
                  ],
                ),
              ),
              FloatingNavbarItem(
                customWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 1
                          ? Icons.calendar_today
                          : Icons.calendar_today,
                      color: currentIndex == 1
                          ? Color(0xFF00A2FD)
                          : Color(0xFF727272),
                      size: currentIndex == 1 ? 26.0 : 23.0,
                    ),
                    Text(
                      'จัดตารางเวร',
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Mitr',
                            color: currentIndex == 1
                                ? Color(0xFF00A2FD)
                                : Color(0xFF727272),
                            fontSize: currentIndex == 1 ? 26.0 : 23.0,
                          ),
                    ),
                  ],
                ),
              ),
              FloatingNavbarItem(
                customWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 2
                          ? Icons.notifications
                          : Icons.notifications,
                      color: currentIndex == 2
                          ? Color(0xFF00A2FD)
                          : Color(0xFF727272),
                      size: currentIndex == 2 ? 26.0 : 23.0,
                    ),
                    Text(
                      'แจ้งเตือน',
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Mitr',
                            color: currentIndex == 2
                                ? Color(0xFF00A2FD)
                                : Color(0xFF727272),
                            fontSize: currentIndex == 2 ? 26.0 : 23.0,
                          ),
                    ),
                  ],
                ),
              ),
              FloatingNavbarItem(
                customWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 3 ? Icons.history : Icons.history,
                      color: currentIndex == 3
                          ? Color(0xFF00A2FD)
                          : Color(0xFF727272),
                      size: currentIndex == 3 ? 26.0 : 23.0,
                    ),
                    Text(
                      'ประวัติ',
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Mitr',
                            color: currentIndex == 3
                                ? Color(0xFF00A2FD)
                                : Color(0xFF727272),
                            fontSize: currentIndex == 3 ? 26.0 : 23.0,
                          ),
                    ),
                  ],
                ),
              ),
              FloatingNavbarItem(
                customWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 4 ? Icons.group : Icons.group,
                      color: currentIndex == 4
                          ? Color(0xFF00A2FD)
                          : Color(0xFF727272),
                      size: currentIndex == 4 ? 26.0 : 23.0,
                    ),
                    Text(
                      'กลุ่ม',
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Mitr',
                            color: currentIndex == 4
                                ? Color(0xFF00A2FD)
                                : Color(0xFF727272),
                            fontSize: currentIndex == 4 ? 26.0 : 23.0,
                          ),
                      // TextStyle(
                      //   fontSize: currentIndex == 4 ? 35.0 : 30.0,
                      //   color: currentIndex == 4
                      //       ? Color(0xFF00A2FD)
                      //       : Color(0xFF727272),

                      // ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
