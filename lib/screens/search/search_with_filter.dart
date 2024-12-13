import 'package:dh_flutter_v2/widgets/cutom_text.dart';
import 'package:dh_flutter_v2/widgets/search_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SearchWithFilter extends StatefulWidget {
  const SearchWithFilter({super.key});

  @override
  State<SearchWithFilter> createState() => _SearchWithFilterState();
}

class _SearchWithFilterState extends State<SearchWithFilter> {
  String selected = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: DefaultTabController(
        length: 5,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.largeMargin,
                vertical: AppConstants.mediumMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        // height: 45,
                        child: searchWidget("Search")),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.large),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const TabBar(
                    dividerHeight: 0,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppConstants.primaryColor,
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(right: 25),
                    labelStyle: TextStyle(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.medium),
                    unselectedLabelColor: AppConstants.grey600,
                    tabs: [
                      Text("Top Results"),
                      Text("Tasks"),
                      Text("Files"),
                      Text("Media"),
                      Text("Links"),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(children: [
                    ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppConstants.primaryColor
                                        .withOpacity(.2)),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppConstants.primaryColor),
                                      child: const Text(
                                        "DH",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppConstants.medium,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const CustomText(
                                      title: "DH",
                                      textColor: Colors.black,
                                      fontSize: AppConstants.large,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                selected == "top result"
                    ? Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    AppConstants.primaryColor.withOpacity(.2)),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              title: "Frequently Used",
                              fontSize: AppConstants.large,
                              textColor: Colors.black,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppConstants.primaryColor),
                                  child: const Text(
                                    "DH",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppConstants.medium,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const CustomText(
                                  title: "DH",
                                  textColor: Colors.black,
                                  fontSize: AppConstants.large,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : selected == "messages"
                        ? messageCard(context)
                        : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container messageCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      margin: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      height: 80,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: letterColors["I"],
            ),
            child: const Text(
              "S",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.xxxLarge),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Tech",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: AppConstants.large,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppConstants.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "All staff",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: AppConstants.medium),
                          ),
                        )
                      ],
                    ),
                    const Text(
                      "23 min",
                      style: TextStyle(
                          color: AppConstants.grey400,
                          fontSize: AppConstants.small,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Samuel Joined Tech. New...",
                style: TextStyle(
                    color: AppConstants.grey600, fontSize: AppConstants.medium),
              ),
            ],
          )
        ],
      ),
    );
  }
}
