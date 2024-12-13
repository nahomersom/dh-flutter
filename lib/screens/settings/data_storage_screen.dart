import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/widgets/cutom_text.dart';
import 'package:flutter/material.dart';

class DataStorageScreen extends StatefulWidget {
  const DataStorageScreen({super.key});

  @override
  State<DataStorageScreen> createState() => _DataStorageScreenState();
}

class _DataStorageScreenState extends State<DataStorageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomText(
          title: "Data and Storage",
          fontSize: AppConstants.xLarge,
          textColor: Colors.black,
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.grey700,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.largeMargin,
            vertical: AppConstants.mediumMargin),
        child: ListView(
          children: [
            const Text(
              "Automatic media download",
              style: TextStyle(
                  color: AppConstants.grey500, fontSize: AppConstants.medium),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.grey300),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  actionContainer(
                      Icons.key_outlined,
                      Colors.amber,
                      "When using mobile data",
                      "Photos, Videos(10 MB), Files(1 MB)",
                      true),
                  const Divider(),
                  actionContainer(
                      Icons.watch_later_outlined,
                      Colors.red,
                      "Auto-Delete Messages",
                      "Photos, Videos(10 MB), Files(1 MB)",
                      true),
                  const Divider(),
                  actionContainer(Icons.lock_outline, Colors.blue,
                      "Passcode Lock", "Photos", false),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        title: "Reset Auto-Download Settings",
                        fontSize: AppConstants.medium,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.red,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Save to Gallery",
              style: TextStyle(
                  color: AppConstants.grey500, fontSize: AppConstants.medium),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.grey300),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  actionContainer(Icons.key_outlined, Colors.amber,
                      "Private Chats", "Off", false),
                  const Divider(),
                  actionContainer(Icons.watch_later_outlined, Colors.red,
                      "Groups", "Off", false),
                  // const Divider(),
                  // actionContainer(Icons.lock_outline, Colors.blue,
                  //     "Passcode Lock", "Photos", false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container actionContainer(
      IconData icon, color, String title, String subTitle, bool value) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   color: Colors.white,
        //   border: Border.all(color: AppConstants.grey300),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        title: title,
                        textColor: AppConstants.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.medium),
                    const SizedBox(
                      height: 3,
                    ),
                    CustomText(
                        title: subTitle,
                        textColor: AppConstants.grey500,
                        fontWeight: FontWeight.normal,
                        fontSize: AppConstants.small),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Switch(
                activeColor: AppConstants.primaryColor,
                value: value,
                onChanged: (val) {})
          ],
        ));
  }
}
