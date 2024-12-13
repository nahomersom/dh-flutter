import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();
  TimeOfDay _startTime =
      const TimeOfDay(hour: 17, minute: 30); // Example start time
  TimeOfDay _endTime = const TimeOfDay(hour: 12, minute: 0); // Example end time

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(
            height: 35,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: AppConstants.smallMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstants.large)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Save',
                      style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstants.large)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: AppConstants.mediumMargin,
            ),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Add title',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          // // Add Guest
          // ListTile(
          //   leading: const Icon(Icons.person_add, color: Colors.green),
          //   title: const Text('Add Guest'),
          //   subtitle: const Text('Guest permission'),
          //   trailing: const Text('Invite others',
          //       style: TextStyle(color: Colors.blue)),
          //   onTap: () {
          //     // Handle add guest action
          //   },
          // ),
          // const Divider(),

          // Time and Date

          ListTile(
            leading: const Icon(Icons.watch_later_outlined, color: Colors.red),
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _selectTime(context, true),
                      child: Text(
                        _startTime.format(context),
                        style: const TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.xxxLarge),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Text(
                        DateFormat.yMMMd().format(_selectedDate),
                        style: const TextStyle(
                            color: AppConstants.grey600,
                            fontSize: AppConstants.medium),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "  >  ",
                  style: TextStyle(
                      color: AppConstants.grey600,
                      fontSize: AppConstants.xxxxLarge),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _selectTime(context, false),
                      child: Text(
                        _endTime.format(context),
                        style: const TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.xxxLarge),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () => _selectEndDate(context),
                      child: Text(
                        DateFormat.yMMMd().format(_selectedEndDate),
                        style: const TextStyle(
                            color: AppConstants.grey600,
                            fontSize: AppConstants.medium),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),

          // Video Meeting
          // ListTile(
          //   leading: const Icon(Icons.videocam, color: Colors.blue),
          //   title: const Text('Video Meeting'),
          //   subtitle: const Text('Video Meeting Settings'),
          //   trailing: Switch(
          //     value: _videoMeetingEnabled,
          //     onChanged: (value) {
          //       setState(() {
          //         _videoMeetingEnabled = value;
          //       });
          //     },
          //   ),
          //   onTap: () {
          //     // Handle video meeting settings
          //   },
          // ),
          // const Divider(),

          // Add Rooms
          // ListTile(
          //   leading: const Icon(Icons.meeting_room, color: Colors.yellow),
          //   title: const Text('Add rooms'),
          //   onTap: () {
          //     // Handle add rooms
          //   },
          // ),
          // const Divider(),

          // Add Location
          ListTile(
            leading: const Icon(Icons.location_on_outlined,
                color: Colors.deepPurple),
            title: const Text('Add Location'),
            onTap: () {
              // Handle add location
            },
          ),
          const Divider(),

          // Add Description
          ListTile(
            leading: const Icon(Icons.notes, color: Colors.orange),
            title: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Add description',
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
          const Divider(),

          // Add Attachment
          ListTile(
            leading: const Icon(Icons.attach_file, color: Colors.blue),
            title: const Text('Add attachment'),
            onTap: () {
              // Handle add attachment
            },
          ),
        ],
      ),
    );
  }
}
