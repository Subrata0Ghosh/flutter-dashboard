import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int _selectedDay = 30;
  final int _currentMonth = 10; // October
  final int _currentYear = 2023;

  static const List<String> _weekDays = [
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
    'Su',
  ];
  static const List<String> _months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  List<int> _getDaysGrid() {
    const int offset = 6;
    const int daysInMonth = 31;
    const int prevMonthDays = 30; // Sep has 30 days
    final List<int> days = [];
    for (int i = offset; i > 0; i--) {
      days.add(-(prevMonthDays - offset + i));
    }
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(i);
    }
    int remaining = 42 - days.length;
    for (int i = 1; i <= remaining; i++) {
      days.add(-i * 100);
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysGrid();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'GENERAL 10:00 AM TO 7:00 PM',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: MediaQuery.of(context).size.width < 1100
                    ? Colors.black87
                    : Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),

        // White Calendar Card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white, // white background matching PDF calendar card
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _MonthDropdown(value: _months[_currentMonth], onTap: () {}),
                  const SizedBox(width: 8),
                  _YearDropdown(value: _currentYear.toString(), onTap: () {}),
                ],
              ),

              const SizedBox(height: 8),

              // Weekdays (dark text on white card)
              Row(
                children: _weekDays
                    .map(
                      (d) => Expanded(
                        child: Text(
                          d,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: const Color(
                              0xFF1E1F3D,
                            ), // dark navy text matching PDF
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 4),

              // Calendar Grid (dark text on white card)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1.4,
                ),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final isCurrentMonth = day > 0 && day < 100;
                  final displayDay = isCurrentMonth
                      ? day
                      : (day < 0 && day > -100 ? -day : day ~/ -100);

                  final isStartRange = isCurrentMonth && day == 27;
                  final isEndRange = isCurrentMonth && day == 30;
                  final isInRange =
                      isCurrentMonth && day > 27 && day < 30;

                  if (!isCurrentMonth) {
                    return Center(
                      child: Text(
                        displayDay.abs().toString(),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: const Color(
                            0xFFCBD5E1,
                          ), // light grey for other months
                        ),
                      ),
                    );
                  }

                  BoxDecoration decoration = const BoxDecoration();
                  Color textColor = const Color(0xFF1E293B);
                  FontWeight weight = FontWeight.w600;

                  if (isStartRange) {
                    decoration = const BoxDecoration(
                      color: Color(0xFF4B36DE),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8),
                      ),
                    );
                    textColor = Colors.white;
                    weight = FontWeight.w700;
                  } else if (isEndRange) {
                    decoration = const BoxDecoration(
                      color: Color(0xFF4B36DE),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(8),
                      ),
                    );
                    textColor = Colors.white;
                    weight = FontWeight.w700;
                  } else if (isInRange) {
                    decoration = const BoxDecoration(
                      color: Color(0xFFF3F4F6), // very light blue/grey
                    );
                    weight = FontWeight.w700;
                  } else if (day == _selectedDay &&
                      !isStartRange &&
                      !isEndRange &&
                      !isInRange) {
                    // Just in case user taps another day
                    decoration = BoxDecoration(
                      color: const Color(0xFF4B36DE).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    );
                  }

                  return GestureDetector(
                    onTap: () => setState(() => _selectedDay = day),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 2,
                      ), // Keep vertical margin, remove horizontal so they connect
                      decoration: decoration,
                      child: Center(
                        child: Text(
                          '$day',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: weight,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8), // Added space after calendar
      ],
    );
  }
}

class _MonthDropdown extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const _MonthDropdown({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6FA), // light purple background
          borderRadius: BorderRadius.circular(12), // pill shape
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF5B21B6),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: Color(0xFF5B21B6),
            ),
          ],
        ),
      ),
    );
  }
}

class _YearDropdown extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const _YearDropdown({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: const BoxDecoration(
          color: Colors.transparent, // no background for year
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: Color(0xFF1E293B),
            ),
          ],
        ),
      ),
    );
  }
}

