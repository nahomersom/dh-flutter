import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class SuiteAdminScreen extends StatefulWidget {
  const SuiteAdminScreen({super.key});

  @override
  State<SuiteAdminScreen> createState() => _SuiteAdminScreenState();
}

class _SuiteAdminScreenState extends State<SuiteAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            // padding: const EdgeInsets.all(5),
            // height: 50,
            // width: 50,
            // alignment: Alignment.center,
            // decoration: BoxDecoration(
            //     border: Border.all(color: AppConstants.grey400),
            //     borderRadius: BorderRadius.circular(15)),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppConstants.grey700,
            ),
          ),
        ),
        title: const CustomText(
          title: "Administrators",
          fontSize: AppConstants.xLarge,
          textColor: Colors.black,
        ),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Container(
        //         padding: const EdgeInsets.all(5),
        //         margin: const EdgeInsets.only(right: 25),
        //         alignment: Alignment.center,
        //         // decoration: BoxDecoration(
        //         //     // border: Border.all(color: AppConstants.grey500),
        //         //     shape: BoxShape.circle),
        //         child: const Icon(
        //           Icons.close,
        //           color: AppConstants.primaryColor,
        //         )),
        //   )
        // ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              // horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: ListView(children: [
            const SizedBox(
              height: 25,
            ),
            actions(AppAssets.organization, "Organization Name", "Tech", true,
                true),
            actions(
                AppAssets.id, "Organizational ID", "LEBVLARP8", false, true),
            actions(AppAssets.moreInfo, "More Organizational Info", "", true,
                false),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppConstants.largeMargin),
              child: CustomText(
                title: "Contacts",
                textColor: AppConstants.grey500,
                fontSize: AppConstants.medium,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            actions(AppAssets.member, "Member and Dept.", "Tech", true, true),
            actions(AppAssets.userIcon, "Add Organizational Member", "", true,
                false),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppConstants.largeMargin),
              child: CustomText(
                title: "Organization Info",
                textColor: AppConstants.grey500,
                fontSize: AppConstants.medium,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              decoration: BoxDecoration(
                  color: AppConstants.primaryColorVeryLight.withOpacity(.4)),
              child: actions(
                  AppAssets.administrator, "Administrators", "", true, false),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppConstants.largeMargin),
              child: CustomText(
                title: "Help",
                textColor: AppConstants.grey500,
                fontSize: AppConstants.medium,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                    color: AppConstants.primaryColorVeryLight.withOpacity(.4)),
                child: Column(
                  children: [
                    actions(AppAssets.help, "Help Center", "", true, true),
                    actions(AppAssets.customerService, "Customer Service", "",
                        true, false),
                  ],
                )),
          ]),
        ),
      ),
    );
  }

  actions(String asset, String title, String sub, bool canEdit, bool divider) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.largeMargin,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      asset,
                      // height: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppConstants.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.medium),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    sub,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppConstants.primaryColor.withOpacity(.5),
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.medium),
                  ),
                  canEdit
                      ? const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppConstants.grey700,
                          size: 30,
                        )
                      : Container(
                          width: 30,
                        ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          // icon == Icons.edit_outlined ? Container() : const SizedBox(height: 5),
          divider ? const Divider(color: AppConstants.grey400) : Container(),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
