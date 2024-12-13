import 'package:dh_flutter_v2/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.grey300),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppConstants.primaryColor,
                      )),
                ),
                const CustomText(
                  title: "My Status",
                  fontSize: AppConstants.xxLarge,
                  textColor: Colors.black,
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context, customPageRoute(const NewStatusScreen()));
                //   },
                //   child: Container(
                //       padding: const EdgeInsets.all(5),
                //       alignment: Alignment.center,
                //       child: const Icon(
                //         Icons.add,
                //         size: 30,
                //         color: AppConstants.black,
                //       )),
                // ),
                Container()
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.grey300),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AppAssets.notificationGreen,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "Do not disturb",
                            textColor: Colors.black,
                            fontSize: AppConstants.medium,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "1 hr Mute",
                            style: TextStyle(color: AppConstants.grey500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    title: "Duration",
                    textColor: AppConstants.grey500,
                    fontSize: AppConstants.medium,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.grey300),
                        ),
                        child: const Text(
                          "30 min",
                          style: TextStyle(
                              color: AppConstants.black,
                              fontSize: AppConstants.small),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.grey300),
                        ),
                        child: const Text(
                          "1 hr",
                          style: TextStyle(
                              color: AppConstants.black,
                              fontSize: AppConstants.small),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.grey300),
                        ),
                        child: const Text(
                          "2 hr",
                          style: TextStyle(
                              color: AppConstants.black,
                              fontSize: AppConstants.small),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.grey300),
                        ),
                        child: const Text(
                          "4 hr",
                          style: TextStyle(
                              color: AppConstants.black,
                              fontSize: AppConstants.small),
                        ),
                      ),
                      Container(
                        width: 30,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppConstants.grey300),
                    ),
                    child: const Text(
                      "Ends at 11:58 PM today",
                      style: TextStyle(
                          color: AppConstants.black,
                          fontSize: AppConstants.small),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppConstants.grey300),
                    ),
                    child: const Text(
                      "Customize",
                      style: TextStyle(
                          color: AppConstants.black,
                          fontSize: AppConstants.small),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, customPageRoute(const NewStatusScreen()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: "More Setting",
                          textColor: AppConstants.grey700,
                          fontSize: AppConstants.medium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.grey300),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AppAssets.phCalendar,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "In meeting",
                            textColor: Colors.black,
                            fontSize: AppConstants.medium,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "1 hr",
                            style: TextStyle(color: AppConstants.grey500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.grey300),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AppAssets.coffee,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "Taking a break",
                            textColor: Colors.black,
                            fontSize: AppConstants.medium,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "1 hr",
                            style: TextStyle(color: AppConstants.grey500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
