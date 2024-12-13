import 'package:dh_flutter_v2/widgets/cutom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';

class RecordingsScreen extends StatefulWidget {
  const RecordingsScreen({super.key});

  @override
  State<RecordingsScreen> createState() => _RecordingsScreenState();
}

class _RecordingsScreenState extends State<RecordingsScreen> {
  List<Map> user = [
    {"name": "Luel", "viewDetail": true},
    {"name": "John", "viewDetail": false},
    {"name": "Danel", "viewDetail": false},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.largeMargin,
                vertical: AppConstants.mediumMargin),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              border: Border.all(color: AppConstants.grey500),
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: AppConstants.black,
                          )),
                    ),
                    const CustomText(
                      title: "All Recordings",
                      fontSize: AppConstants.xxLarge,
                      textColor: AppConstants.black,
                    ),
                    Container(
                      width: 30,
                    )
                  ],
                ),
                Container(
                  height: 30,
                ),
                const TabBar(
                    dividerHeight: 0,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppConstants.primaryColor,
                    isScrollable: false,
                    labelPadding: EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.large),
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(child: Text("Audio records")),
                      Tab(child: Text("Video records"))
                    ]),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(children: [
                    ListView.builder(
                        itemCount: user.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                user[index]["viewDetail"] =
                                    !user[index]["viewDetail"];
                                setState(() {});
                              },
                              child: audioRecordingCard(user[index]["name"],
                                  user[index]["viewDetail"]));
                        }),
                    ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              user[index]["viewDetail"] =
                                  !user[index]["viewDetail"];
                              setState(() {});
                            },
                            child: videoRecordingCard(
                                user[index]["name"], user[index]["viewDetail"]),
                          );
                        }),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  videoRecordingCard(String name, bool viewDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: name,
                  textColor: Colors.black,
                  fontSize: AppConstants.large,
                ),
                const SizedBox(
                  height: 5,
                ),
                const CustomText(
                  title: "Nov 3, 2023",
                  textColor: AppConstants.grey500,
                  fontSize: AppConstants.medium,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
            const Icon(
              Icons.info,
              color: AppConstants.primaryColor,
            )
          ],
        ),
        !viewDetail
            ? Container()
            : const SizedBox(
                height: 15,
              ),
        !viewDetail
            ? Container()
            : Container(
                alignment: Alignment.center,
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                child: SvgPicture.asset(
                  AppAssets.play,
                  height: 25,
                ),
              ),
        const SizedBox(
          height: 15,
        ),
        const Divider(),
      ],
    );
  }

  audioRecordingCard(String name, bool viewDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: name,
                    textColor: Colors.black,
                    fontSize: AppConstants.large,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomText(
                    title: "Nov 3, 2023",
                    textColor: AppConstants.grey500,
                    fontSize: AppConstants.medium,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
              const Icon(
                Icons.info,
                color: AppConstants.primaryColor,
              )
            ],
          ),
        ),
        !viewDetail
            ? Container()
            : const SizedBox(
                height: 15,
              ),
        !viewDetail
            ? Container()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: "2:50",
                      textColor: AppConstants.grey600,
                      fontSize: AppConstants.small,
                      fontWeight: FontWeight.normal,
                    ),
                    CustomText(
                      title: "-1:30",
                      textColor: AppConstants.grey600,
                      fontSize: AppConstants.small,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
        !viewDetail
            ? Container()
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SliderTheme(
                  data: const SliderThemeData(
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 5,
                    ),
                  ),
                  child: Slider(
                      activeColor: AppConstants.primaryColor,
                      min: .001,
                      value: .5,
                      onChanged: (value) {}),
                ),
              ),
        // !viewDetail
        //     ? Container()
        //     : const SizedBox(
        //         height: 15,
        //       ),
        !viewDetail
            ? Container()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppAssets.rewind,
                      height: 23,
                    ),
                    SvgPicture.asset(
                      AppAssets.pause,
                      height: 23,
                    ),
                    SvgPicture.asset(
                      AppAssets.rewind,
                      height: 23,
                    ),
                    SvgPicture.asset(
                      AppAssets.delete,
                      height: 23,
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 15,
        ),
        const Divider(),
      ],
    );
  }
}
