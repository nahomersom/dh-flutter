import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class VideoChatScreen extends StatefulWidget {
  const VideoChatScreen({super.key});

  @override
  State<VideoChatScreen> createState() => _VideoChatScreenState();
}

class _VideoChatScreenState extends State<VideoChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(
            AppConstants.largeMargin,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            // height: 45,
                            // width: 45,
                            // alignment: Alignment.center,
                            // decoration: BoxDecoration(
                            //     border: Border.all(color: AppConstants.grey400),
                            // borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppConstants.grey700,
                        )),
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                title: "Gab, Yon, Hon, & 1 other",
                                fontSize: AppConstants.large,
                                textColor: Colors.black,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Waiting for Others",
                                style: TextStyle(
                                    color: AppConstants.grey500,
                                    fontSize: AppConstants.medium,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                      // const Icon(
                      //   Icons.info_outline,
                      //   color: AppConstants.grey600,
                      //   size: 35,
                      // )

                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: letterColors["T"]),
                        child: const Text(
                          "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppConstants.xxxLarge),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          appIconWidget(Colors.blue, Colors.white,
                              AppAssets.speaker, 45.0, 45.0),
                          const CustomText(
                            title: "Speaker",
                            textColor: Colors.black,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          appIconWidget(Colors.blue, Colors.white,
                              AppAssets.camera, 45.0, 45.0),
                          const CustomText(
                            title: "Camera",
                            textColor: Colors.black,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          appIconWidget(Colors.red.withOpacity(.2), Colors.red,
                              AppAssets.record, 45.0, 45.0),
                          const CustomText(
                            title: "Record",
                            textColor: Colors.black,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          appIconWidget(AppConstants.primaryColorVeryLight,
                              Colors.blue, AppAssets.send, 45.0, 45.0),
                          const CustomText(
                            title: "Share",
                            textColor: Colors.black,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          appIconWidget(AppConstants.primaryColorVeryLight,
                              Colors.red, AppAssets.end, 45.0, 45.0),
                          const CustomText(
                            title: "End",
                            textColor: Colors.black,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            // padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                                color: letterColors['T'],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: letterColors["J"]),
                                  child: const Text(
                                    "J",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: AppConstants.xxxLarge),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Betty",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: AppConstants.medium),
                                      ),
                                      Container(
                                          width: 25,
                                          height: 25,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppConstants
                                                  .primaryColorVeryLight),
                                          child: const Icon(
                                            Icons.notifications_outlined,
                                            size: 18,
                                            color: AppConstants.iconColor,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.bottomRight,
                    height: MediaQuery.of(context).size.height * .22,
                    width: MediaQuery.of(context).size.width * .43,
                    decoration: BoxDecoration(
                        color: letterColors['J'],
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        width: 45,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.primaryColorVeryLight),
                        child: const Icon(
                          Icons.cameraswitch_outlined,
                          color: AppConstants.iconColor,
                        )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
