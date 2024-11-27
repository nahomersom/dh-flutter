// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dh/model/onboarding_items.dart';
// import 'package:dh/routes/custom_page_route.dart';
// import 'package:dh/screens/auth/sign_in_screen.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../constants/constants.dart';
// import '../../widgets/custom_botton.dart';

// class SplashScreen extends StatefulWidget {
//   static const String routeName = "/SplashScreen";
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   int _currentSlide = 0;
//   bool isLastPage = false;
//   final CarouselController _carouselController = CarouselController();

//   @override
//   void initState() {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//         systemNavigationBarColor: Colors.white, // navigation bar color
//         statusBarColor: Colors.white,
//         statusBarBrightness: Brightness.dark));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment:
//                     // (_currentSlide == 0)
//                     //     ?
//                     MainAxisAlignment.end,
//                 // : MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 15),
//                     margin: const EdgeInsets.only(top: 30),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             // LocalStorage.setFirstTimeOpeningApp();
//                             // Navigator.pushNamedAndRemoveUntil(
//                             //     context, RoutesScreen.register, (route) => false,
//                             //     arguments: RegisterArguments(
//                             //         fromScreen: 'signup', isFromOnboarding: true));
//                           },
//                           child: const Text(
//                             // _currentSlide == onboardingItems.length - 1
//                             //     ? "Sign up"
//                             // :
//                             "Skip",
//                             style: TextStyle(
//                               fontSize: AppConstants.large,
//                               color: AppConstants.primaryColor,
//                               fontWeight: FontWeight.bold,
//                               // color: ColorProvider.darkPrimary,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     CarouselSlider(
//                       carouselController: _carouselController,
//                       options: CarouselOptions(
//                         height: 460,
//                         aspectRatio: 16 / 9,
//                         viewportFraction: 1.0,
//                         initialPage: 0,
//                         autoPlay: true,
//                         enableInfiniteScroll: false,
//                         reverse: false,
//                         autoPlayInterval: const Duration(seconds: 3),
//                         autoPlayAnimationDuration:
//                             const Duration(milliseconds: 800),
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enlargeCenterPage: true,
//                         enlargeFactor: 0.3,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             _currentSlide = index;
//                           });
//                         },
//                       ),
//                       items: onboardingItems.map((item) {
//                         return Builder(
//                           builder: (BuildContext context) {
//                             return Container(
//                               width: double.infinity,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 15.0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                               ),
//                               child: Column(
//                                 children: [
//                                   Expanded(
//                                     child: SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           .5,
//                                       // height: MediaQuery.of(context).size.height * .3,
//                                       child: SvgPicture.asset(
//                                         onboardingItems[_currentSlide]
//                                             .imagePath,
//                                         fit: BoxFit.contain,
//                                         // height:
//                                         //     MediaQuery.of(context).size.height * .16,
//                                         // colorFilter: ColorFilter.mode(
//                                         //   // Theme.of(context).AppConstants.primaryColor,
//                                         //   // Colors.green,
//                                         //   BlendMode.srcIn,
//                                         // ),
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     onboardingItems[_currentSlide].title,
//                                     textAlign: TextAlign.center,
//                                     style: const TextStyle(
//                                       fontSize: 22,
//                                       color: Color(0xFF3A3838),
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 30,
//                                     ),
//                                     child: Text(
//                                       onboardingItems[_currentSlide].disc,
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           color: AppConstants.grey500,
//                                           fontSize: AppConstants.small),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         DotsIndicator(
//                           dotsCount: 3,
//                           position: _currentSlide,
//                           decorator: DotsDecorator(
//                             size: const Size.square(8.0),
//                             activeSize: const Size(25.0, 8.0),
//                             activeShape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             color: AppConstants.grey400,
//                             activeColor: AppConstants.primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 18),
//                 child: CustomButton(
//                   onPressed: () {
//                     // if (_currentSlide == onboardingItems.length - 1) {
//                     // LocalStorage.setFirstTimeOpeningApp();
//                     //  Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
//                     Navigator.push(
//                         context, customPageRoute(const SignInScreen()));
//                     // } else {
//                     //   _currentSlide++;
//                     //   setState(() {});
//                     // }
//                   },
//                   title: "Get Started",
//                 ),
//               ),
//               const SizedBox(
//                 height: 60,
//               )
//             ]),
//       ),
//     );
//   }
// }

// List<Map<String, dynamic>> _onboardingItems = [
//   {
//     "title": "Calendar integration",
//     "desc":
//         "The app could sync with popular calendar apps like Google, Outlook.",
//     "imagePath": AppAssets.onboarding1
//   },
//   {
//     "title": "Real time video conferensing",
//     "desc":
//         "The app could allow you real time video collaboration with fellow workers",
//     "imagePath": AppAssets.onboarding3
//   },
//   {
//     "title": "Smooth communication experiance",
//     "desc":
//         "The app could allow you to group chat, video conferencing, file sharing",
//     "imagePath": AppAssets.onboarding2
//   },
// ];

// List<OnboardingItems> onboardingItems =
//     _onboardingItems.map((item) => OnboardingItems.getItems(item)).toList();
