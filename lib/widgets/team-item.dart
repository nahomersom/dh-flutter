import 'package:dh_flutter_v2/widgets/stacked-avatar.dart';
import 'package:flutter/material.dart';

class TeamItems extends StatefulWidget {
  const TeamItems({
    super.key,
    required this.users,
    required this.title,
    required this.time,
    this.isAlert = false,
  });

  final List<Map<String, dynamic>> users;
  final String title;
  final String time;
  final bool isAlert;

  @override
  State<TeamItems> createState() => _TeamItemsState();
}

class _TeamItemsState extends State<TeamItems> {
  bool? checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  SizedBox(
                    height: 14,
                    width: 14,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => const BorderSide(
                          width: 1.0,
                          color: Color(0xff7C7C7C),
                        ),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: checkBoxValue,
                      onChanged: (value) => {
                        setState(() {
                          checkBoxValue = value;
                        }),
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color(0xff2B2B2C),
                        fontSize: 18,
                      ),
                      maxLines: null, // Allow unlimited lines
                      softWrap: true, // Enable text wrapping
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              '0%',
              style: TextStyle(
                color: widget.isAlert ? Colors.red : Color(0xff7C7C7D),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: widget.isAlert
                          ? Color(0xffFBD9D7)
                          : Color(0xffFEF2CC),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 15,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule_outlined,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Oct 12',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                StackedAvatars(
                  users: widget.users,
                  bgColors: const [
                    Colors.blue, // Background color for the first avatar
                    Colors.green,
                    Colors.yellow // Background color for the second avatar
                  ],
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              child: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: Color(0xffF2F2F2),
                  shape: BoxShape.circle, // Makes the container circular
                ),
                child: const Center(
                  child: Icon(
                    Icons.more_horiz_outlined,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
