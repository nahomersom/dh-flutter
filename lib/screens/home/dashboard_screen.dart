import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/messages/messages_screen.dart';
import 'package:dh_flutter_v2/screens/workspace.dart';
import 'package:dh_flutter_v2/widgets/team-item.dart';
import 'package:dh_flutter_v2/widgets/team_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  SampleItem? selectedItem;

  bool _isExpanded = true;
  // Controls the expanded/collapsed state
  bool _isSecondItemExpanded = false;
  final List<Map<String, dynamic>> surveyData = [
    {
      "name": "MG",
      "hasProfileImage": false,
      "profileUrl": null,
    },
    {
      "name": "TD",
      "hasProfileImage": false,
      "profileUrl": null,
    },
    {
      "name": "TD",
      "hasProfileImage": false,
      "profileUrl": null,
    }
  ];

  final List<Map<String, dynamic>> calendarsData = [
    {
      "name": "MG",
      "hasProfileImage": false,
      "profileUrl": null,
    },
    {
      "name": "TD",
      "hasProfileImage": true,
      "profileUrl": "assets/images/person-profile.png",
    },
  ];

  final List<Map<String, dynamic>> cloudsData = [
    {
      "name": "MG",
      "hasProfileImage": false,
      "profileUrl": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeH = size.height;
    final sizeW = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppTheme.gray.shade200,
                      width: AppConstants.small,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: TimerCard(
                    title: 'Today',
                    imageUrl: 'assets/images/today.png',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TimerCard(
                    title: 'Scheduled',
                    imageUrl: 'assets/images/scheduled.png',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TimerCard(
                    title: 'Assigned to me',
                    imageUrl: 'assets/images/person.png',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: _isExpanded
                    ? Border.all(
                        color: const Color(
                            0xffE5E5E6), // Full border when expanded
                        width: 1.5,
                      )
                    : const Border(
                        bottom: BorderSide(
                          color: Color(
                              0xffE5E5E6), // Only bottom border when collapsed
                          width: 1.5,
                        ),
                      ),
                borderRadius: _isExpanded
                    ? BorderRadius.circular(
                        10.0) // Rounded border when expanded
                    : BorderRadius.zero, // No border radius when collapsed
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded =
                                !_isExpanded; // Toggle expanded/collapsed state
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              _isExpanded
                                  ? Icons.keyboard_arrow_up_outlined
                                  : Icons.keyboard_arrow_down_outlined,
                              color: const Color(0xff7C7C7C),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Development Team',
                              style: TextStyle(
                                color: _isExpanded
                                    ? const Color(
                                        0xff4525A0) // Purple when expanded
                                    : const Color(
                                        0xff2B2B2C), // Black when collapsed
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<SampleItem>(
                        iconColor: const Color(0xff7C7C7D),
                        initialValue: selectedItem,
                        onSelected: (SampleItem item) {
                          setState(() {
                            selectedItem = item;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<SampleItem>>[
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemOne,
                            child: Text('Item 1'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemTwo,
                            child: Text('Item 2'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemThree,
                            child: Text('Item 3'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration:
                        const Duration(milliseconds: 300), // Animation duration
                    curve: Curves.easeInOut, // Animation curve
                    child: _isExpanded
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              TeamItems(
                                users: surveyData,
                                title: 'Survey review and analysis',
                                time: '1:00 PM',
                              ),
                              const Divider(
                                height: 30,
                                color: Color(0xff7C7C7C),
                                thickness: 0.5,
                              ),
                              TeamItems(
                                users: calendarsData,
                                title: 'Calendar Integration',
                                time: '5:00 PM',
                              ),
                              const Divider(
                                height: 30,
                                color: Color(0xff7C7C7C),
                                thickness: 0.5,
                              ),
                              TeamItems(
                                users: cloudsData,
                                title:
                                    'Cloud-based backend for task data and messages',
                                time: '5:00 PM',
                                isAlert: true,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () =>
                                      _showCreateTaskSheet(context),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xff4525A2),
                                      width: 1.0,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 24,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Color(0xff4525A2),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Add Task',
                                        style: TextStyle(
                                          color: Color(0xff4525A2),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(), // Empty widget when collapsed
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: _isSecondItemExpanded
                    ? Border.all(
                        color: const Color(
                            0xffE5E5E6), // Full border when expanded
                        width: 1.5,
                      )
                    : const Border(
                        bottom: BorderSide(
                          color: Color(
                              0xffE5E5E6), // Only bottom border when collapsed
                          width: 1.5,
                        ),
                      ),
                borderRadius: _isSecondItemExpanded
                    ? BorderRadius.circular(
                        10.0) // Rounded border when expanded
                    : BorderRadius.zero, // No border radius when collapsed
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSecondItemExpanded =
                                !_isSecondItemExpanded; // Toggle expanded/collapsed state
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              _isSecondItemExpanded
                                  ? Icons.keyboard_arrow_up_outlined
                                  : Icons.keyboard_arrow_down_outlined,
                              color: const Color(0xff7C7C7C),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'AIG Study Team',
                              style: TextStyle(
                                color: _isSecondItemExpanded
                                    ? const Color(
                                        0xff4525A0) // Purple when expanded
                                    : const Color(
                                        0xff2B2B2C), // Black when collapsed
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<SampleItem>(
                        iconColor: const Color(0xff7C7C7D),
                        initialValue: selectedItem,
                        onSelected: (SampleItem item) {
                          setState(() {
                            selectedItem = item;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<SampleItem>>[
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemOne,
                            child: Text('Item 1'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemTwo,
                            child: Text('Item 2'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemThree,
                            child: Text('Item 3'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration:
                        const Duration(milliseconds: 300), // Animation duration
                    curve: Curves.easeInOut, // Animation curve
                    child: _isSecondItemExpanded
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              TeamItems(
                                users: surveyData,
                                title: 'Survey review and analysis',
                                time: '1:00 PM',
                              ),
                              const Divider(
                                height: 30,
                                color: Color(0xff7C7C7C),
                                thickness: 0.5,
                              ),
                              TeamItems(
                                users: calendarsData,
                                title: 'Calendar Integration',
                                time: '5:00 PM',
                              ),
                              const Divider(
                                height: 30,
                                color: Color(0xff7C7C7C),
                                thickness: 0.5,
                              ),
                              TeamItems(
                                users: cloudsData,
                                title:
                                    'Cloud-based backend for task data and messages',
                                time: '5:00 PM',
                                isAlert: true,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () =>
                                      _showCreateTaskSheet(context),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xff4525A2),
                                      width: 1.0,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 24,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Color(0xff4525A2),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Add Task',
                                        style: TextStyle(
                                          color: Color(0xff4525A2),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(), // Empty widget when collapsed
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showCreateTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 1.0,
          builder: (_, ScrollController scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        margin: const EdgeInsets.only(top: 7),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(
                              width: 3,
                              color: const Color(0xffA5A5A6),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Task',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2B2B2C),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xff515152),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the modal
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Task Name
                    const Text(
                      'Task Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF2B2B2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Insert task name',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF7C7C7D),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12), // Center vertically
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD6D6D7),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Category
                    const Text(
                      'Assign Member (Optional)',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF2B2B2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        hint: const Text(
                          'Select Member', // Hint text
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF7C7C7D),
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD6D6D7),
                            ),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Work',
                            child: Text('Work'),
                          ),
                          DropdownMenuItem(
                            value: 'Personal',
                            child: Text('Personal'),
                          ),
                        ],
                        onChanged: (value) {
                          // Handle dropdown change
                        },
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Date Picker
                    const Text(
                      'Due Date (Optional)',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF2B2B2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Insert Due Date',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF7C7C7D),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD6D6D7),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Color(0xff7C7C7D),
                            ),
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              // Handle date selection
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Time Picker
                    const Text(
                      'Due Time (Optional)',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF2B2B2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Insert Due Time',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF7C7C7D),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD6D6D7),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.access_time,
                              color: Color(0xff7C7C7D),
                            ),
                            onPressed: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              // Handle time selection
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    // Create Task Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the modal
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4525A2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Create Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
