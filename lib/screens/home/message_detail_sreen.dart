// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:dh/model/models.dart';
import 'package:dh/repository/auth_repository.dart';
import 'package:dh/screens/screens.dart';
import 'package:dh/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart' as photo;

// import 'package:photo_manager/photo_manager.dart';

import '../../constants/constants.dart';
import '../../routes/routes.dart';
import '../../utils/socket_connection.dart';

class MessageDetailSreen extends StatefulWidget {
  final bool isGroup;
  final int? groupId;
  final int? reciverId;
  const MessageDetailSreen(
      {super.key,
      required this.isGroup,
      required this.groupId,
      required this.reciverId});

  @override
  State<MessageDetailSreen> createState() => _MessageDetailSreenState();
}

class _MessageDetailSreenState extends State<MessageDetailSreen> {
  Completer<GoogleMapController> controller = Completer();
  GoogleMapController? mapController;
  LatLng _currentPosition = const LatLng(0.0, 0.0);
  bool _locationFetched = false;
  User? user;
  TextEditingController messageController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   _checkLocationPermission();
  // }

  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      // Handle permission denied case
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Location permission is required to show the map."),
      ));
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // setState(() {
    _currentPosition = LatLng(position.latitude, position.longitude);
    _locationFetched = true;
    // });
  }

  final List<Map<String, dynamic>> messages = [
    {
      'name': 'Tamerat tesfa',
      'message':
          'a new generation of cleaning robot has been put on the market',
      'time': '2:55 PM',
      'isSentByMe': false,
    },
    {
      'name': 'Leul Daniel',
      'message':
          'okay for a wooden floors? cuz my apartment got a wooden floors.',
      'time': '3:02 PM',
      'isSentByMe': true,
    },
    {
      'name': 'Tamerat tesfa',
      'message': 'Sure, let’s do it! 😊',
      'time': '3:10 PM',
      'isSentByMe': false,
    },
    {
      'name': 'Leul Daniel',
      'message':
          'Great I will write later the exact time and place. See you soon!',
      'time': '3:12 PM',
      'isSentByMe': true,
    },
  ];

  //   _sendPrivateChat() {
  //   BlocProvider.of<ChatBloc>(context).add(const SendM());
  // }

  @override
  initState() {
    super.initState();
    _loadProfile();
  }

  _loadProfile() async {
    var auth = AuthRepository();

    await auth.getUserData().then((value) => {
          user = value,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppConstants.largeMargin,
          horizontal: AppConstants.mediumMargin,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppConstants.grey700,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.isGroup ? "DH Group" : "John Lukas",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: AppConstants.large,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    if (!widget.isGroup)
                      const Text(
                        "Online",
                        style: TextStyle(
                            color: AppConstants.grey400,
                            fontSize: AppConstants.small,
                            fontWeight: FontWeight.normal),
                      ),
                  ],
                ),

                InkWell(
                  onTap: () {
                    widget.isGroup
                        ? Navigator.push(
                            context,
                            customPageRoute(SettingScreen(
                              groupId: widget.groupId!,
                            )))
                        : Navigator.push(
                            context, customPageRoute(const ProfileScreen()));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: letterColors["Y"],
                    ),
                    child: Text(
                      widget.isGroup ? 'DH' : "J",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstants.large),
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 15,
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context, customPageRoute(const VideoChatScreen()));
                //   },
                //   child: SvgPicture.asset(AppAssets.video,
                //       height: 45,
                //       colorFilter: const ColorFilter.mode(
                //         Colors.green,
                //         BlendMode.srcATop,
                //       )),
                // ),
                // const SizedBox(
                //   width: 10,
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context, customPageRoute(const SettingScreen()));
                //   },
                //   child: const Icon(
                //     Icons.more_vert,
                //     color: AppConstants.iconColor,
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 0.0),
                    // margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: message['isSentByMe']
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!message['isSentByMe'] && widget.isGroup)
                          CircleAvatar(
                            backgroundColor: message['isSentByMe']
                                ? const Color(0xFFD8F6FF)
                                : AppConstants.primaryColor,
                            child: Text(
                              message['name'][0],
                              style: TextStyle(
                                  color: message['isSentByMe']
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        if (!message['isSentByMe'] && widget.isGroup)
                          const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   message['name'],
                            //   style: const TextStyle(
                            //     fontSize: AppConstants.medium,
                            //     color: AppConstants.grey600,
                            //   ),
                            // ),
                            // const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: message['isSentByMe']
                                    ? const Color(0xFFD8F6FF)
                                    : AppConstants.primaryColorVeryLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!message['isSentByMe'] && widget.isGroup)
                                    Text(
                                      message['name'],
                                      style: const TextStyle(
                                          fontSize: AppConstants.medium,
                                          color: AppConstants.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  // if (!message['isSentByMe'] && widget.isGroup)
                                  //   const SizedBox(height: 8),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    child: Text(
                                      message['message'],
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: message['isSentByMe']
                                              ? Colors.black
                                              : Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .62,
                              child: Row(
                                mainAxisAlignment: message['isSentByMe']
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Text(
                                    message['time'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppConstants.grey600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  message['isSentByMe']
                                      ? const Icon(
                                          Icons.done_all,
                                          color: AppConstants.primaryColor,
                                          size: 20,
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(width: 8),
                        // if (message['isSentByMe'])
                        //   CircleAvatar(
                        //     child: Text(message['name'][0]),
                        //   ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.mediumMargin, vertical: 0),
        height: 70,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                // _loadImages();
                _checkLocationPermission();
                _showImageSourceBottomSheet(context);
              },
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  messageController.text = value;
                  setState(() {});
                },
                controller: messageController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  hintText: 'Communicate',
                  hintStyle: const TextStyle(
                    color: AppConstants.grey400,
                    fontWeight: FontWeight.normal,
                    fontSize: AppConstants.large,
                  ),

                  suffixIcon: messageController.text == ""
                      ? null
                      : InkWell(
                          onTap: () {
                            sendMessage(messageController.text,
                                widget.reciverId!, "Text");
                            setState(() {
                              messageController.text = "";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SvgPicture.asset(AppAssets.communication,
                                // height: 20,
                                colorFilter: const ColorFilter.mode(
                                  AppConstants.primaryColor,
                                  BlendMode.srcATop,
                                )),
                          ),
                        ),
                  // prefixIcon: Container(
                  //   child: Icon(Icons.attach_file),
                  // ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppConstants.grey300),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppConstants.primaryColorVeryLight,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.keyboard_voice,
                color: AppConstants.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showImageSourceBottomSheet(BuildContext context) async {
    final TextEditingController questionController = TextEditingController();
    final List<TextEditingController> optionControllers = [];
    // List recentImages = [];
    bool anonymousVoting = true;
    bool multipleAnswers = false;
    bool quizMode = false;
    int optionCount = 1;

    int index = 0;
    // List<bool> selected = List.generate(
    //     12, (_) => false); // Initialize selection state for 9 items
    void addOption() {
      setState(() {
        optionControllers.add(TextEditingController());
        optionCount++;
      });
    }

    List<photo.AssetEntity> images = [];
    List<bool> selected = [];
    // bool fetching = true;

    // Future<void> _loadImages() async {
    final photo.PermissionState ps =
        await photo.PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<photo.AssetPathEntity> albums =
          await photo.PhotoManager.getAssetPathList(
        onlyAll: true,
        type: photo.RequestType.image,
      );
      photo.AssetPathEntity album = albums[0];
      int totalImages = await album.assetCountAsync;
      List<photo.AssetEntity> photos = await albums[0].getAssetListPaged(
          page: 0, size: totalImages); // Load the first 100 images

      setState(() {
        images = photos;
        selected = List.generate(photos.length, (index) => false);
        // fetching = false;
      });
    } else {
      // Handle permission denial
    }
    // }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          bool isAnySelected = selected.contains(true);
          return Container(
            height: MediaQuery.of(context).size.height * .7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.largeMargin, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: AppConstants.grey400,
                      width: 100,
                      height: 5,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: index == 0
                      ? galleryMethod(context, images, selected)
                      : index == 1
                          ? filesWidget()
                          : index == 2
                              ? locationWidget()
                              : index == 3
                                  ? pollMethod(
                                      context,
                                      questionController,
                                      optionCount,
                                      optionControllers,
                                      addOption,
                                      setState,
                                      anonymousVoting,
                                      multipleAnswers,
                                      quizMode)
                                  : contactsWidget(),
                ),
                Container(
                  color: AppConstants.backgroundColor,
                  child: isAnySelected && index == 0
                      ? Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.emoji_emotions,
                                        color: AppConstants.primaryColor),
                                    onPressed: () {
                                      // Handle emoji selection
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: AppConstants.grey200,
                                  hintText: 'Add a caption...',
                                  hintStyle: const TextStyle(
                                      color: AppConstants.grey600,
                                      fontSize: AppConstants.medium,
                                      fontWeight: FontWeight.normal),
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Stack(
                              children: [
                                InkWell(
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: AppConstants.primaryColor,
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.send,
                                          color: Colors.white)),
                                  onTap: () {
                                    // Handle send action
                                  },
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: AppConstants.white,
                                        shape: BoxShape.circle),
                                    child: Container(
                                        height: 17,
                                        width: 17,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: AppConstants.primaryColor,
                                            shape: BoxShape.circle),
                                        child: Text(
                                          selected.length.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: AppConstants.xxSmall,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  index = 0;
                                });
                              },
                              child: actionIcons(
                                  "Gallery", Icons.image, index == 0),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  index = 1;
                                });
                              },
                              child: actionIcons(
                                  "File", Icons.file_copy, index == 1),
                            ),
                            InkWell(
                              onTap: () {
                                // _checkLocationPermission();
                                setState(() {
                                  index = 2;
                                });
                              },
                              child: actionIcons(
                                  "Location", Icons.location_on, index == 2),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  index = 3;
                                });
                              },
                              child:
                                  actionIcons("Poll", Icons.poll, index == 3),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  index = 4;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: index == 4
                                          ? AppConstants.primaryColor
                                              .withOpacity(.1)
                                          : AppConstants.grey300,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: index == 4
                                          ? AppConstants.primaryColor
                                          : AppConstants.grey600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Contact",
                                    style: TextStyle(
                                      color: AppConstants.grey500,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppConstants.small,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  Column locationWidget() {
    return Column(
      children: [
        Expanded(
          child: _locationFetched
              ? GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 16.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: _currentPosition,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                    ),
                  },
                  myLocationEnabled: true,
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocationOption(
                icon: Icons.location_pin,
                title: 'Send selected location',
                subtitle: 'Addis Ababa, Addis Ababa, Ethiopia',
              ),
              LocationOption(
                icon: Icons.share,
                title: 'Share My Live Location for...',
                subtitle: 'Updated in real time as you move',
              ),
            ],
          ),
        ),
      ],
    );
  }

  ListView contactsWidget() {
    return ListView(
      children: [
        searchWidget("Search contact"),
        const ContactTile(
            name: 'Aba Bd',
            number: '+251 918141784',
            imageUrl: 'assets/images/user.png'),
        const ContactTile(
            name: 'Aba Kasahun',
            number: '+251 972715510',
            imageUrl: 'assets/images/user.png'),
        const ContactTile(name: 'Aba Senay', number: '0918016749'),
        const ContactTile(name: 'Abel', number: '+251 982014890'),
        const ContactTile(name: 'Abeni', number: '+251 941674607'),
        const ContactTile(name: 'Abeni', number: '+251 941674607'),
        const ContactTile(name: 'Abeni', number: '+251 941674607'),
        // Add more contacts here
      ],
    );
  }

  SizedBox filesWidget() {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            // padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.only(bottom: 10),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.storage,
                  color: Colors.green,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'File Manager',
                      style: TextStyle(
                        color: AppConstants.black,
                        fontWeight: FontWeight.normal,
                        fontSize: AppConstants.large,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Browse your file system',
                      style: TextStyle(
                        color: AppConstants.grey400,
                        fontWeight: FontWeight.normal,
                        fontSize: AppConstants.small,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 10),
          //   margin: const EdgeInsets.only(bottom: 10),
          //   child: const Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Icon(
          //         Icons.telegram,
          //         color: Colors.teal,
          //       ),
          //       SizedBox(width: 20),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Telegram',
          //             style: TextStyle(
          //               color: AppConstants.black,
          //               fontWeight: FontWeight.normal,
          //               fontSize: AppConstants.large,
          //             ),
          //           ),
          //           Text(
          //             'Browse the app\'s folder',
          //             style: TextStyle(
          //               color: AppConstants.grey400,
          //               fontWeight: FontWeight.normal,
          //               fontSize: AppConstants.small,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // const Divider(),
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 10),
          //   margin: const EdgeInsets.only(bottom: 10),
          //   child: const Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Icon(
          //         Icons.image,
          //         color: AppConstants.primaryColor,
          //       ),
          //       SizedBox(width: 20),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Gallery',
          //             style: TextStyle(
          //               color: AppConstants.black,
          //               fontWeight: FontWeight.normal,
          //               fontSize: AppConstants.large,
          //             ),
          //           ),
          //           Text(
          //             'To send images without compression',
          //             style: TextStyle(
          //               color: AppConstants.grey400,
          //               fontWeight: FontWeight.normal,
          //               fontSize: AppConstants.small,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // const Divider(),
          Expanded(
            child: ListView(
              children: const [
                Text(
                  'Recent files',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: AppConstants.medium,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('555A1792.JPG'),
                  subtitle: Text(
                    '11.6 MB',
                    style: TextStyle(
                      color: AppConstants.grey400,
                      fontWeight: FontWeight.normal,
                      fontSize: AppConstants.small,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('555A1722.JPG'),
                  subtitle: Text(
                    '10.1 MB',
                    style: TextStyle(
                      color: AppConstants.grey400,
                      fontWeight: FontWeight.normal,
                      fontSize: AppConstants.small,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('555A1716.JPG'),
                  subtitle: Text(
                    '11.3 MB',
                    style: TextStyle(
                      color: AppConstants.grey400,
                      fontWeight: FontWeight.normal,
                      fontSize: AppConstants.small,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('555A1721 (1).JPG'),
                  subtitle: Text(
                    '11.3 MB',
                    style: TextStyle(
                      color: AppConstants.grey400,
                      fontWeight: FontWeight.normal,
                      fontSize: AppConstants.small,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('555A1721 (1).JPG'),
                  subtitle: Text(
                    '11.3 MB',
                    style: TextStyle(
                      color: AppConstants.grey400,
                      fontWeight: FontWeight.normal,
                      fontSize: AppConstants.small,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('555A1721 (1).JPG'),
                  subtitle: Text(
                    '11.3 MB',
                    style: TextStyle(
                      color: AppConstants.grey400,
                      fontWeight: FontWeight.normal,
                      fontSize: AppConstants.small,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container galleryMethod(BuildContext context,
      List<photo.AssetEntity> recentImages, List<bool> selectedImages) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        // fetching
        //     ? Container(
        //         height: 20, width: 20, child: const CircularProgressIndicator())
        //     :
        SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: recentImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print("#####${selectedImages[index]}");
                  setState(() {
                    selectedImages[index] =
                        !selectedImages[index]; // Toggle selection state
                    print("#####${selectedImages[index]}");
                  });
                },
                child: Stack(
                  children: [
                    FutureBuilder<Widget>(
                      future: recentImages[index]
                          .thumbnailData
                          // .thumbDataWithSize(200, 200)
                          .then((data) {
                        return Image.memory(
                          data!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      }),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return snapshot.data!;
                        } else {
                          return Container(
                            color: Colors
                                .grey[300], // Placeholder background color
                          );
                        }
                      },
                    ),
                    if (index == 0)
                      const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    if (index == 0)
                      InkWell(
                        onTap: () {
                          _pickImage(ImageSource.camera);
                        },
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    if (index != 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.white,
                          child: selectedImages[index]
                              ? const Icon(
                                  Icons.check_circle,
                                  color: AppConstants.primaryColor,
                                  size: 20,
                                )
                              : const Text(""),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Column pollMethod(
      BuildContext context,
      TextEditingController questionController,
      int optionCount,
      List<TextEditingController> optionControllers,
      void addOption(),
      StateSetter setState,
      bool anonymousVoting,
      bool multipleAnswers,
      bool quizMode) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                  color: AppConstants.grey700,
                  fontSize: AppConstants.large,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Send",
              style: TextStyle(
                  color: AppConstants.primaryColor,
                  fontSize: AppConstants.large,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "QUESTION",
                        style: TextStyle(
                            color: AppConstants.black,
                            fontSize: AppConstants.medium,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: questionController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: AppConstants.grey200,
                        hintText: 'Ask a question',
                        hintStyle: const TextStyle(
                            color: AppConstants.grey600,
                            fontSize: AppConstants.medium,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "POLL OPTIONS",
                        style: TextStyle(
                            color: AppConstants.black,
                            fontSize: AppConstants.medium,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    for (int i = 0; i < optionCount; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          controller: optionControllers.length > i
                              ? optionControllers[i]
                              : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: AppConstants.grey200,
                            hintText: 'Option',
                            hintStyle: const TextStyle(
                                color: AppConstants.grey600,
                                fontSize: AppConstants.medium,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    if (optionCount < 9)
                      InkWell(
                        onTap: () {
                          addOption();
                          setState(() {});
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.centerLeft,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppConstants.grey200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'Add an Option',
                              style: TextStyle(
                                  color: AppConstants.grey600,
                                  fontSize: AppConstants.medium,
                                  fontWeight: FontWeight.normal),
                            )),
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "You can add 8 more options",
                        style: TextStyle(
                            color: AppConstants.grey500,
                            fontSize: AppConstants.small),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: AppConstants.grey200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Anonymous Voting',
                                style: TextStyle(
                                    color: AppConstants.grey700,
                                    fontSize: AppConstants.medium,
                                    fontWeight: FontWeight.normal),
                              ),
                              Switch(
                                value: anonymousVoting,
                                onChanged: (value) {
                                  setState(() {
                                    anonymousVoting = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Multiple Answers',
                                style: TextStyle(
                                    color: AppConstants.grey700,
                                    fontSize: AppConstants.medium,
                                    fontWeight: FontWeight.normal),
                              ),
                              Switch(
                                value: multipleAnswers,
                                onChanged: (value) {
                                  setState(() {
                                    multipleAnswers = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Quiz Mode',
                                style: TextStyle(
                                    color: AppConstants.grey700,
                                    fontSize: AppConstants.medium,
                                    fontWeight: FontWeight.normal),
                              ),
                              Switch(
                                value: quizMode,
                                onChanged: (value) {
                                  setState(() {
                                    quizMode = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Column actionIcons(String title, IconData icon, bool isActive) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: isActive ? AppConstants.primaryColor : AppConstants.grey600,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(
            color: isActive ? AppConstants.primaryColor : AppConstants.grey500,
            fontWeight: FontWeight.bold,
            fontSize: AppConstants.small,
          ),
        )
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // Handle the picked file (e.g., display it, upload it, etc.)
      print('Picked file path: ${pickedFile.path}');
    } else {
      // Handle the case when no image is picked.
      print('No image selected.');
    }
  }
}

class LocationOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const LocationOption(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppConstants.primaryColor),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppConstants.black,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.medium,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppConstants.grey500,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.small,
                ),
              ),
            ],
          ),
        ],
      ),
      // title: Text(title),
      // subtitle: Text(subtitle),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String name;
  final String number;
  final String? imageUrl;

  const ContactTile(
      {super.key, required this.name, required this.number, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppConstants.primaryColor.withOpacity(.7),
            backgroundImage: imageUrl != null ? AssetImage(imageUrl!) : null,
            child: imageUrl == null ? Text(name[0]) : null,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: AppConstants.black,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.medium,
                ),
              ),
              Text(
                number,
                style: const TextStyle(
                  color: AppConstants.grey500,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.small,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
