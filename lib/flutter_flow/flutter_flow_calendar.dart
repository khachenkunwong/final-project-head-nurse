import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime kFirstDay = DateTime(1970, 1, 1);
DateTime kLastDay = DateTime(2100, 1, 1);

extension DateTimeExtension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59);
}

bool isSameDay(DateTime? a, DateTime? b) {
  var tt = 1;
  // print(
  //     "arm $a == $b a == null ${a == null} b == null ${b == null} a == null || b == null ${a == null || b == null}");
  if (a == null || b == null) {
    tt = tt + 1;
    // print("tt $tt");
    return false;
  }
  // print(tt);
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

bool isSameMonth(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }
  return a.year == b.year && a.month == b.month;
}

class FlutterFlowCalendar extends StatefulWidget {
  const FlutterFlowCalendar({
    Key? key,
    required this.color,
    this.onChange,
    this.initialDate,
    this.weekFormat = false,
    this.weekStartsMonday = false,
    this.iconColor,
    this.dateStyle,
    this.dayOfWeekStyle,
    this.inactiveDateStyle,
    this.selectedDateStyle,
    this.titleStyle,
    this.rowHeight,
    this.locale,
    this.yearduty,
    this.monthduty,
    this.dayduty,
    this.yearduty2,
    this.monthduty2,
    this.dayduty2,
    this.changTwoDuty = false,
    required this.daysOfWeekHeight,
  }) : super(key: key);

  final bool weekFormat;
  final bool weekStartsMonday;
  final Color color;
  final void Function(DateTimeRange?)? onChange;
  final DateTime? initialDate;
  final Color? iconColor;
  final TextStyle? dateStyle;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? inactiveDateStyle;
  final TextStyle? selectedDateStyle;
  final TextStyle? titleStyle;
  final double? rowHeight;
  final String? locale;
  final int? yearduty;
  final int? monthduty;
  final int? dayduty;
  final int? yearduty2;
  final int? monthduty2;
  final int? dayduty2;
  final bool? changTwoDuty;
  final double daysOfWeekHeight;

  @override
  State<StatefulWidget> createState() => _FlutterFlowCalendarState();
}

class _FlutterFlowCalendarState extends State<FlutterFlowCalendar> {
  late DateTime focusedDay;
  late DateTime selectedDay;
  late DateTimeRange selectedRange;
  late int index;
  var selectedDays;
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // print("_onDaySelected $selectedDay $focusedDay");selectedDay
    setState(() {
      focusedDay = selectedDay;
      // Update values in a Set
      // ทำงานเมื่อค้นหาเจอ
      // if (_selectedDays.contains(selectedDay)) {
      // if (widget.yearduty != null &&
      //     widget.monthduty != null &&
      //     widget.dayduty != null) {
      //   if (selectedDay.toString().split(" ")[0] !=
      //       _selectedDays.first.toString().split(" ")[0]) {
      //     _selectedDays.remove(selectedDay);
      //   }
      // } else {
      //   _selectedDays.remove(selectedDay);
      // }
      // }
      // ทำงานเมื่อหาไม่เจอ
      // else {
      // print("widget.yearduty ${widget.yearduty}");
      // เมื่อมีเวรของเพื่อน
      // เพิ่มจำนวนการ marker
      if (widget.changTwoDuty == false) {
        if (widget.yearduty != null &&
            widget.monthduty != null &&
            widget.dayduty != null) {
          // print("มีการเพิ่มเวรเข้ามาอยู่แล้ว");
          // _selectedDays ห้ามเกิน 2 ถ้าเกินลบสมาชิกล่าสุด แล้วเพิ่มใหม่
          if (_selectedDays.length == 2) {
            _selectedDays.remove(_selectedDays.last);
            _selectedDays.add(selectedDay);
            setSelectedDay(selectedDay);
          } else {
            _selectedDays.add(selectedDay);
            setSelectedDay(selectedDay);
          }
        } else {
          if (_selectedDays.length == 1) {
            // print("มีเวร 1 เวร");
            _selectedDays.remove(_selectedDays.last);
            _selectedDays.add(selectedDay);
            setSelectedDay(selectedDay);
          } else {
            _selectedDays.add(selectedDay);
            setSelectedDay(selectedDay);
          }
        }
      } else {
        if (widget.yearduty != null &&
            widget.monthduty != null &&
            widget.dayduty != null) {
          // print("มีการเพิ่มเวรเข้ามาอยู่แล้ว");
          // _selectedDays ห้ามเกิน 2 ถ้าเกินลบสมาชิกล่าสุด แล้วเพิ่มใหม่
          if (_selectedDays.length == 3) {
            _selectedDays.remove(_selectedDays.last);
            _selectedDays.add(selectedDay);
            setSelectedDay(selectedDay);
          } else {
            _selectedDays.add(selectedDay);
            setSelectedDay(selectedDay);
          }
        } else {
          if (_selectedDays.length == 1) {
            // print("มีเวร 1 เวร");
            _selectedDays.remove(_selectedDays.last);
            _selectedDays.add(selectedDay);
            setSelectedDay(selectedDay);
          } else {
            _selectedDays.add(selectedDay);
            setSelectedDay(selectedDay);
          }
        }
      }

      // _selectedDays.intersection(other)
      // }
    });
  }

  @override
  void initState() {
    super.initState();
    index = 0;
    focusedDay = widget.initialDate ?? DateTime.now();
    selectedDay = widget.initialDate ?? DateTime.now();
    selectedRange = DateTimeRange(
      start: selectedDay.startOfDay,
      end: selectedDay.endOfDay,
    );

    SchedulerBinding.instance.addPostFrameCallback((_) => setSelectedDay(
          selectedRange.start,
        ));
    // เพิ่ม จุด mark วัน
    if (widget.yearduty != null &&
        widget.monthduty != null &&
        widget.dayduty != null) {
      _selectedDays.add(DateTime(
          widget.yearduty ?? 2000, widget.monthduty ?? 1, widget.dayduty ?? 1));
      if (widget.changTwoDuty == true) {
        _selectedDays.add(DateTime(widget.yearduty2 ?? 2000,
            widget.monthduty2 ?? 1, widget.dayduty2 ?? 1));
      }
    }
  }

  CalendarFormat get calendarFormat =>
      widget.weekFormat ? CalendarFormat.week : CalendarFormat.month;

  StartingDayOfWeek get startingDayOfWeek => widget.weekStartsMonday
      ? StartingDayOfWeek.monday
      : StartingDayOfWeek.sunday;

  Color get color => widget.color;

  Color get lightColor => widget.color.withOpacity(0.85);

  Color get lighterColor => widget.color.withOpacity(0.60);

  void setSelectedDay(
    DateTime? newSelectedDay, [
    DateTime? newSelectedEnd,
  ]) {
    final newRange = newSelectedDay == null
        ? null
        : DateTimeRange(
            start: newSelectedDay.startOfDay,
            end: newSelectedEnd ?? newSelectedDay.endOfDay,
          );
    setState(() {
      selectedDay = newSelectedDay ?? selectedDay;
      selectedRange = newRange ?? selectedRange;
      if (widget.onChange != null) {
        widget.onChange!(newRange);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("selectedDay.startOfDay ${selectedDay.startOfDay}");
    // print("selectedDay.endOfDay ${selectedDay.endOfDay}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CalendarHeader(
          focusedDay: focusedDay,
          onLeftChevronTap: () => setState(
            () => focusedDay = widget.weekFormat
                ? _previousWeek(focusedDay)
                : _previousMonth(focusedDay),
          ),
          onRightChevronTap: () => setState(
            () => focusedDay = widget.weekFormat
                ? _nextWeek(focusedDay)
                : _nextMonth(focusedDay),
          ),
          onTodayButtonTap: () => setState(() => focusedDay = DateTime.now()),
          titleStyle: widget.titleStyle,
          iconColor: widget.iconColor,
          locale: widget.locale,
        ),
        TableCalendar(
          focusedDay: focusedDay,
          selectedDayPredicate: (date) {
            // return isSameDay(selectedDay, date);
            // print("_selectedDays ${_selectedDays}");

            // print(
            //     "_selectedDays.contains(date); ${_selectedDays.contains(date)}");
            if (index == 0 &&
                widget.yearduty != null &&
                widget.monthduty != null &&
                widget.dayduty != null) {
              index = 1;
              return _selectedDays.contains(_selectedDays.first);
            }
            return _selectedDays.contains(date);
            // print("data selected $date");
            // return true;
          },
          daysOfWeekHeight: widget.daysOfWeekHeight,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          calendarFormat: calendarFormat,
          headerVisible: false,
          locale: widget.locale,
          rowHeight: widget.rowHeight ?? MediaQuery.of(context).size.width / 7,
          calendarStyle: CalendarStyle(
            defaultTextStyle:
                widget.dateStyle ?? const TextStyle(color: Color(0xFF5A5A5A)),
            weekendTextStyle: widget.dateStyle ??
                const TextStyle(color: const Color(0xFF5A5A5A)),
            holidayTextStyle: widget.dateStyle ??
                const TextStyle(color: const Color(0xFF5C6BC0)),
            selectedTextStyle:
                const TextStyle(color: Color(0xFFFAFAFA), fontSize: 16.0)
                    .merge(widget.selectedDateStyle),
            todayTextStyle:
                const TextStyle(color: Color(0xFFFAFAFA), fontSize: 16.0)
                    .merge(widget.selectedDateStyle),
            outsideTextStyle: const TextStyle(color: Color(0xFF9E9E9E))
                .merge(widget.inactiveDateStyle),
            selectedDecoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: lighterColor,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: lightColor,
              shape: BoxShape.circle,
            ),
            markersMaxCount: 3,
            canMarkersOverflow: true,
          ),
          availableGestures: AvailableGestures.horizontalSwipe,
          startingDayOfWeek: startingDayOfWeek,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: const TextStyle(color: Color(0xFF616161))
                .merge(widget.dayOfWeekStyle),
            weekendStyle: const TextStyle(color: Color(0xFF616161))
                .merge(widget.dayOfWeekStyle),
          ),
          onDaySelected: _onDaySelected,
        ),
      ],
    );
  }
}

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onTodayButtonTap,
    this.iconColor,
    this.titleStyle,
    this.locale,
  }) : super(key: key);

  final DateTime focusedDay;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onTodayButtonTap;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final String? locale;

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(),
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                DateFormat.yMMMM(locale).format(focusedDay),
                style: const TextStyle(fontSize: 17).merge(titleStyle),
              ),
            ),
            CustomIconButton(
              icon: Icon(Icons.calendar_today, color: iconColor),
              onTap: onTodayButtonTap,
            ),
            CustomIconButton(
              icon: Icon(Icons.chevron_left, color: iconColor),
              onTap: onLeftChevronTap,
            ),
            CustomIconButton(
              icon: Icon(Icons.chevron_right, color: iconColor),
              onTap: onRightChevronTap,
            ),
          ],
        ),
      );
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
    this.padding = const EdgeInsets.all(10),
  }) : super(key: key);

  final Icon icon;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: margin,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Padding(
            padding: padding,
            child: Icon(
              icon.icon,
              color: icon.color,
              size: icon.size,
            ),
          ),
        ),
      );
}

DateTime _previousWeek(DateTime week) {
  return week.subtract(const Duration(days: 7));
}

DateTime _nextWeek(DateTime week) {
  return week.add(const Duration(days: 7));
}

DateTime _previousMonth(DateTime month) {
  if (month.month == 1) {
    return DateTime(month.year - 1, 12);
  } else {
    return DateTime(month.year, month.month - 1);
  }
}

DateTime _nextMonth(DateTime month) {
  if (month.month == 12) {
    return DateTime(month.year + 1, 1);
  } else {
    return DateTime(month.year, month.month + 1);
  }
}
