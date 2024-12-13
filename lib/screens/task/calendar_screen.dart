import 'package:dh_flutter_v2/constants/app_assets.dart';
import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largeMargin,
                  vertical: AppConstants.largeMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CustomText(
                  //   title: formatDate(DateTime.now()),
                  //   textColor: Colors.black,
                  //   fontSize: AppConstants.xLarge,
                  // ),
                  const Text(
                    "Calendar",
                    style: TextStyle(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.large,
                        decoration: TextDecoration.underline,
                        decorationColor: AppConstants.primaryColor),
                  ),
                  SvgPicture.asset(
                    AppAssets.date,
                    height: 25,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfCalendar(
                headerStyle: const CalendarHeaderStyle(
                    textStyle: TextStyle(
                        color: AppConstants.black,
                        fontSize: AppConstants.xLarge,
                        fontWeight: FontWeight.bold)),
                view: CalendarView.workWeek,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
