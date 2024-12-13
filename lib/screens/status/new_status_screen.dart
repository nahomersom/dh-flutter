import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class NewStatusScreen extends StatefulWidget {
  const NewStatusScreen({super.key});

  @override
  State<NewStatusScreen> createState() => _NewStatusScreenState();
}

class _NewStatusScreenState extends State<NewStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin, vertical: 32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.grey300),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.close,
                        color: AppConstants.primaryColor,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const CustomText(
              title: "General Status",
              textColor: AppConstants.grey500,
              fontSize: AppConstants.xLarge,
              fontWeight: FontWeight.normal,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.grey300),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.notificationGreen,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const CustomText(
                            title: "Do not Disturbed",
                            textColor: Colors.black,
                            fontSize: AppConstants.medium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.grey300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.phCalendar,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const CustomText(
                            title: "In Meeting",
                            textColor: Colors.black,
                            fontSize: AppConstants.medium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.grey300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.coffee,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const CustomText(
                            title: "Taking a Break",
                            textColor: Colors.black,
                            fontSize: AppConstants.medium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.grey300),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          CustomText(
                            title: "New Status",
                            textColor: Colors.black,
                            fontSize: AppConstants.medium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
