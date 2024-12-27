import 'dart:convert';
import 'dart:io';

import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/constants/constants.dart';
import 'package:dh_flutter_v2/routes/routes.dart';
import 'package:dh_flutter_v2/screens/screens.dart';
import 'package:dh_flutter_v2/screens/settings/widgets/profile_bottom_sheet_content.dart';
import 'package:dh_flutter_v2/widgets/cutom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profile_image;
  late GoRouter _router;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    _router = GoRouter.of(context);
    _router.routerDelegate.addListener(_onRouteChange);
    getProfileImage();
    super.initState();
  }

  Future<void> _onRouteChange() async {
    if (!mounted) return;
    await getProfileImage();
  }

// Retrieve image as File
  Future<void> getProfileImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final base64String = prefs.getString("profile-image");

      if (base64String == null) return null;

      // Decode base64 string to bytes
      final bytes = base64Decode(base64String);

      // Create temporary file
      // Generate a unique temporary file
      final tempDir = Directory.systemTemp;
      final tempFile = File(
          '${tempDir.path}/profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Write bytes to file
      await tempFile.writeAsBytes(bytes);
      setState(() {
        _profile_image = tempFile;
      });
    } catch (e) {
      setState(() {
        _profile_image = null;
      });
      print('Error retrieving image: $e');
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ProfileBottomSheetContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 50,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 45,
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppConstants.backgroundColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          )),
                    ),
                    IconButton(
                        onPressed: () {
                          context.go("/workspace/profile/edit-profile");
                        },
                        icon: Icon(
                          Icons.edit_note_outlined,
                          size: 30,
                          color: AppTheme.baseBlack,
                        ))
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: Container(),
                ),
                pinned: true,
                backgroundColor: Colors.white,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: _profile_image != null
                            ? FileImage(_profile_image!)
                            : null,
                        backgroundColor: Colors.grey[300],
                        child: _profile_image != null
                            ? null
                            : const Icon(Icons.person,
                                size: 40, color: Colors.white),
                      ),
                      // const SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const CustomText(
                        title: 'John Luke',
                        textColor: AppConstants.black,
                        fontSize: AppConstants.xxxLarge,
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: AppConstants.grey400,
                      ),
                      const SizedBox(height: 10),
                      Container(
                          width: MediaQuery.of(context).size.width * .7,
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppConstants.largeMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.call,
                                    height: 25,
                                    // colorFilter: const ColorFilter.mode(
                                    //   AppConstants.iconColor,
                                    //   BlendMode.srcATop,
                                    // )
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Call",
                                    style: TextStyle(
                                        color: AppConstants.grey500,
                                        fontSize: AppConstants.small),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      customPageRoute(const VideoChatScreen()));
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(AppAssets.camera,
                                        height: 25,
                                        colorFilter: const ColorFilter.mode(
                                          AppConstants.primaryColor,
                                          BlendMode.srcATop,
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Video",
                                      style: TextStyle(
                                          color: AppConstants.grey500,
                                          fontSize: AppConstants.small),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  SvgPicture.asset(AppAssets.mute,
                                      height: 25,
                                      colorFilter: const ColorFilter.mode(
                                        AppConstants.primaryColorLight,
                                        BlendMode.srcATop,
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Mute",
                                    style: TextStyle(
                                        color: AppConstants.grey500,
                                        fontSize: AppConstants.small),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppConstants.grey500,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: IconButton(
                                      onPressed: () {
                                        _showBottomSheet(context);
                                      },
                                      icon: const Icon(
                                        Icons.more_horiz,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "More",
                                    style: TextStyle(
                                        color: AppConstants.grey500,
                                        fontSize: AppConstants.small),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 10),
                      const Divider(
                        color: AppConstants.grey400,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Contact details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppConstants.mediumMargin, vertical: 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.smallMargin,
                          vertical: AppConstants.largeMargin,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppConstants.grey300),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "User ID",
                                  textColor: Colors.black,
                                  fontSize: AppConstants.medium,
                                ),
                                CustomText(
                                  title: "@johnLukas",
                                  fontSize: AppConstants.medium,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              height: 5,
                              color: AppConstants.grey500,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "Phone number",
                                  textColor: Colors.black,
                                  fontSize: AppConstants.medium,
                                ),
                                CustomText(
                                  title: "+251 967 890 890",
                                  fontSize: AppConstants.medium,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              height: 5,
                              color: AppConstants.grey500,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "My QR Code",
                                  textColor: Colors.black,
                                  fontSize: AppConstants.medium,
                                ),
                                CustomText(
                                  title: "View",
                                  fontSize: AppConstants.medium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: AppConstants.mediumMargin),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: AppConstants.grey300,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10)),
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: AppConstants.mediumMargin,
                      //       vertical: 15),
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(vertical: 5.0),
                      //         child: Row(
                      //           children: [
                      //             SvgPicture.asset(AppAssets.call,
                      //                 height: 25,
                      //                 colorFilter: const ColorFilter.mode(
                      //                   AppConstants.primaryColor,
                      //                   BlendMode.srcATop,
                      //                 )),
                      //             const SizedBox(width: 16),
                      //             const Expanded(
                      //               child: CustomText(
                      //                 title: '+1 000 000 000',
                      //                 textColor: Colors.black,
                      //                 fontSize: AppConstants.medium,
                      //                 fontWeight: FontWeight.normal,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       const Divider(),
                      //       Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(vertical: 5.0),
                      //         child: Row(
                      //           children: [
                      //             SvgPicture.asset(AppAssets.call,
                      //                 height: 25,
                      //                 colorFilter: const ColorFilter.mode(
                      //                   AppConstants.primaryColor,
                      //                   BlendMode.srcATop,
                      //                 )),
                      //             const SizedBox(width: 16),
                      //             const Expanded(
                      //               child: CustomText(
                      //                 title: '+1 000 000 000',
                      //                 textColor: Colors.black,
                      //                 fontSize: AppConstants.medium,
                      //                 fontWeight: FontWeight.normal,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 10),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'You & John Luke',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        // height: MediaQuery.of(context).size.height * .26,
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppConstants.mediumMargin),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppConstants.grey300,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CustomText(
                                title: "Interactions",
                                textColor: AppConstants.black,
                                fontSize: AppConstants.medium,
                              ),
                            ),
                            InteractionItem(
                              icon: Icons.message_outlined,
                              title: 'Adem Peter, Want to see this week\'s',
                              time: '13:30',
                            ),
                            InteractionItem(
                              icon: Icons.message_outlined,
                              title: 'Hi, Adem Peter, Your peers are rece',
                              time: 'Aug 7',
                            ),
                            InteractionItem(
                              icon: Icons.message_outlined,
                              title: 'Hi, Adem Peter, you need to see the',
                              time: '11/18/22',
                            ),
                            // Add more items as needed
                            const Divider(
                              color: AppConstants.grey400,
                            ),
                            const SizedBox(height: 8),

                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  title: 'More',
                                  textColor: AppConstants.primaryColor,
                                  fontSize: AppConstants.medium,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: AppConstants.primaryColor,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )

              //      Column(
              //   children: [
              //     Container(
              //         color: Colors.white,
              //         margin: const EdgeInsets.symmetric(
              //           vertical: AppConstants.largeMargin,
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: AppConstants.mediumMargin,
              //                   vertical: AppConstants.mediumMargin),
              //               child: CustomText(
              //                 title: "John Lukas",
              //                 fontSize: AppConstants.xxxLarge,
              //                 textColor: AppConstants.grey700,
              //               ),
              //             ),
              //             Container(
              //               width: MediaQuery.of(context).size.width,
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: AppConstants.mediumMargin,
              //                   vertical: AppConstants.smallMargin),
              //               child: const Text(
              //                 "My name is John Lukas and I enjoy meeting new people and finding ways to help them have an uplifting experience.",
              //                 style: TextStyle(
              //                     height: 1.5,
              //                     color: AppConstants.grey500,
              //                     fontSize: AppConstants.medium),
              //               ),
              //             ),
              //           ],
              //         )),
              //     Container(
              //       margin: const EdgeInsets.symmetric(
              //           horizontal: AppConstants.mediumMargin,
              //           vertical: AppConstants.mediumMargin),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: AppConstants.smallMargin,
              //         vertical: AppConstants.largeMargin,
              //       ),
              //       decoration: BoxDecoration(
              //           border: Border.all(color: AppConstants.grey300),
              //           borderRadius: BorderRadius.circular(5)),
              //       child: const Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               CustomText(
              //                 title: "User ID",
              //                 textColor: Colors.black,
              //                 fontSize: AppConstants.medium,
              //               ),
              //               CustomText(
              //                 title: "@johnLukas",
              //                 fontSize: AppConstants.medium,
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           Divider(
              //             height: 5,
              //             color: AppConstants.grey500,
              //           ),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               CustomText(
              //                 title: "Phone number",
              //                 textColor: Colors.black,
              //                 fontSize: AppConstants.medium,
              //               ),
              //               CustomText(
              //                 title: "+251 967 890 890",
              //                 fontSize: AppConstants.medium,
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           Divider(
              //             height: 5,
              //             color: AppConstants.grey500,
              //           ),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               CustomText(
              //                 title: "My QR Code",
              //                 textColor: Colors.black,
              //                 fontSize: AppConstants.medium,
              //               ),
              //               CustomText(
              //                 title: "View",
              //                 fontSize: AppConstants.medium,
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //     Container(
              //       margin: const EdgeInsets.symmetric(
              //           horizontal: AppConstants.mediumMargin,
              //           vertical: AppConstants.smallMargin),
              //       padding: const EdgeInsets.all(15),
              //       decoration: BoxDecoration(
              //           border: Border.all(color: AppConstants.grey300),
              //           borderRadius: BorderRadius.circular(12)),
              //       child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Column(
              //                   children: [
              //                     SvgPicture.asset(
              //                       AppAssets.call,
              //                       height: 25,
              //                       // colorFilter: const ColorFilter.mode(
              //                       //   AppConstants.iconColor,
              //                       //   BlendMode.srcATop,
              //                       // )
              //                     ),
              //                     const SizedBox(
              //                       height: 5,
              //                     ),
              //                     const Text(
              //                       "Call",
              //                       style: TextStyle(
              //                           color: AppConstants.grey500,
              //                           fontSize: AppConstants.small),
              //                     ),
              //                   ],
              //                 ),
              //                 InkWell(
              //                   onTap: () {
              //                     Navigator.push(context,
              //                         customPageRoute(const VideoChatScreen()));
              //                   },
              //                   child: Column(
              //                     children: [
              //                       SvgPicture.asset(AppAssets.camera,
              //                           height: 25,
              //                           colorFilter: const ColorFilter.mode(
              //                             AppConstants.primaryColor,
              //                             BlendMode.srcATop,
              //                           )),
              //                       const SizedBox(
              //                         height: 5,
              //                       ),
              //                       const Text(
              //                         "Video",
              //                         style: TextStyle(
              //                             color: AppConstants.grey500,
              //                             fontSize: AppConstants.small),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 Column(
              //                   children: [
              //                     SvgPicture.asset(AppAssets.mute,
              //                         height: 25,
              //                         colorFilter: const ColorFilter.mode(
              //                           AppConstants.primaryColorLight,
              //                           BlendMode.srcATop,
              //                         )),
              //                     const SizedBox(
              //                       height: 5,
              //                     ),
              //                     const Text(
              //                       "Mute",
              //                       style: TextStyle(
              //                           color: AppConstants.grey500,
              //                           fontSize: AppConstants.small),
              //                     ),
              //                   ],
              //                 ),
              //                 Column(
              //                   children: [
              //                     Container(
              //                       padding: const EdgeInsets.symmetric(
              //                           horizontal: 2),
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                             color: AppConstants.grey500,
              //                           ),
              //                           borderRadius: BorderRadius.circular(5)),
              //                       child: const Icon(
              //                         Icons.more_horiz,
              //                       ),
              //                     ),
              //                     const SizedBox(
              //                       height: 5,
              //                     ),
              //                     const Text(
              //                       "More",
              //                       style: TextStyle(
              //                           color: AppConstants.grey500,
              //                           fontSize: AppConstants.small),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             )
              //           ]),
              //     ),
              //     const TabBar(
              //         dividerHeight: 0,
              //         indicatorSize: TabBarIndicatorSize.label,
              //         isScrollable: false,
              //         indicatorColor: AppConstants.primaryColor,
              //         labelPadding: EdgeInsets.symmetric(horizontal: 0),
              //         labelStyle: TextStyle(
              //             color: AppConstants.primaryColor,
              //             fontWeight: FontWeight.bold),
              //         unselectedLabelColor: Colors.black,
              //         unselectedLabelStyle: TextStyle(
              //             color: Colors.black, fontWeight: FontWeight.bold),
              //         tabs: [
              //           Tab(
              //             child: Text("Media"),
              //           ),
              //           Tab(
              //             child: Text("Files"),
              //           ),
              //           Tab(
              //             child: Text("Voice"),
              //           ),
              //           Tab(
              //             child: Text("Links"),
              //           )
              //         ]),
              //     Container(
              //       height: 500,
              //     ),
              //   ],
              // ))
            ],
          ),
        ),
      ),
    );
  }
}

class InteractionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;

  InteractionItem(
      {required this.icon, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: AppConstants.primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  fontWeight: FontWeight.normal,
                  textColor: AppConstants.black,
                  fontSize: AppConstants.medium,
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomText(
                  title: time,
                  fontWeight: FontWeight.normal,
                  textColor: AppConstants.grey400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
