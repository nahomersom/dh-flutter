import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dh_flutter_v2/bloc/task_bloc/task_bloc.dart';
import 'package:dh_flutter_v2/model/task_model.dart';
import 'package:dh_flutter_v2/routes/custom_page_route.dart';
import 'package:dh_flutter_v2/screens/screens.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:popup_menu/popup_menu.dart';

import '../../bloc/groups/groups_bloc.dart';
import '../../constants/constants.dart';
import '../../model/group_model.dart';
import '../../widgets/widgets.dart';

class AddListItemsScreen extends StatefulWidget {
  final bool isPersonal;
  final int? groupId;
  final int userId;
  const AddListItemsScreen(
      {super.key,
      required this.isPersonal,
      required this.userId,
      this.groupId});

  @override
  _AddListItemsScreenState createState() => _AddListItemsScreenState();
}

class _AddListItemsScreenState extends State<AddListItemsScreen> {
  Group? group;
  List<String> groupMembers = [];
  List<Task> tasks = [];
  List<Task> completedTasks = [];

  PopupMenu? menu;
  GlobalKey btnKey = GlobalKey();
  bool active = true;
  bool showAllTasks = true;

  String? _selectedDate;

  TextEditingController controller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TextEditingController priorityController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  List<String> assignedToController = [];

  @override
  void initState() {
    super.initState();
    widget.groupId != null ? _getGroupById(widget.groupId!) : null;
    widget.groupId != null
        // ? _getMyAssignedTasks()
        ? _getTasksByGroupId(widget.groupId!)
        : _getTaksICreated();
    menu = _popupInit();
  }

  PopupMenu _popupInit() {
    return PopupMenu(
      config: const MenuConfig(
          lineColor: AppConstants.grey300,
          backgroundColor: Color.fromARGB(255, 238, 238, 238),
          itemWidth: 200,
          itemHeight: 50,
          type: MenuType.list),
      context: context,
      items: [
        MenuItem(
          title: 'Show Group Info',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.info_outline, color: Colors.black),
        ),
        MenuItem(
          title: !showAllTasks ? 'Show All' : 'Show Completed',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.visibility_outlined, color: Colors.black),
        ),
        MenuItem(
          title: 'Select Task',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.task_alt, color: Colors.black),
        ),
        MenuItem(
          title: 'Delete Group',
          textStyle:
              const TextStyle(color: Colors.red, fontSize: AppConstants.medium),
          image: const Icon(Icons.cancel_outlined, color: Colors.red),
        ),
      ],
      onClickMenu: onClickMenu,
    );
  }

  void onClickMenu(MenuItemProvider item) {
    switch (item.menuTitle) {
      case 'Show Group Info':
        print('Show List Info');
        Navigator.push(
            context, customPageRoute(SettingScreen(groupId: widget.groupId!)));
        break;
      case 'Show Completed':
        _showCompletedTasks();
        print('Show Completed');
        break;
      case 'Show All':
        _getTasksByGroupId(widget.groupId!);
        print('Show all');
        break;
      case 'Select Task':
        print('Select Task');
        break;
      case 'Delete Tasks':
        print('Delete Tasks');
        break;
      case 'Delete Group':
        _deleteGroupById(widget.groupId!);
        print('Delete group');

        break;
    }
  }

  _showCompletedTasks() {
    completedTasks = [];
    showAllTasks = false;
    for (Task task in tasks) {
      if (task.status?.toLowerCase() == "done") {
        if (!completedTasks.contains(task)) {
          completedTasks.add(task);
        }
      }
      print(completedTasks);
    }
    setState(() {});
    menu = _popupInit();
  }

  _getTaksICreated() {
    BlocProvider.of<TaskBloc>(context).add(GetTasksICreated());
  }

  _getGroupById(int id) {
    BlocProvider.of<GroupsBloc>(context).add(GetGroupById(id: id));
  }

  _deleteGroupById(int id) {
    BlocProvider.of<GroupsBloc>(context).add(DeleteGroup(id: id));
  }

  _deleteTaskById(int id) {
    BlocProvider.of<TaskBloc>(context).add(RemoveTaskByIdEvent(taskId: id));
  }

  _getTasksByGroupId(int groupId) {
    showAllTasks = true;
    menu = _popupInit();
    setState(() {});
    BlocProvider.of<TaskBloc>(context)
        .add(GetTasksByGroupIdEvent(groupId: groupId));
  }

  // _getMyAssignedTasks() {
  //   BlocProvider.of<TaskBloc>(context).add(GetMyAssignedTasks());
  // }

  _getMyGroups() {
    BlocProvider.of<GroupsBloc>(context).add(GetMyGroups());
  }

  _createTask(
    String name,
    String description,
    String? deadline,
    String? priority,
    String? status,
    int groupId,
    List? assignedTo,
    int monitoredBy,
  ) {
    BlocProvider.of<TaskBloc>(context).add(CreateTaskEvent(
        name: name,
        description: description,
        priority: priority,
        status: status,
        groupId: groupId,
        assignedTo: assignedTo,
        deadline: deadline,
        monitoredBy: monitoredBy));
  }

  _updateTask(
    int taskId,
    String name,
    String description,
    String? deadline,
    String? priority,
    String? status,
    int groupId,
    List assignedTo,
    int monitoredBy,
  ) {
    BlocProvider.of<TaskBloc>(context).add(UpdateTaskByIdEvent(
        taskId: taskId,
        name: name,
        description: description,
        priority: priority,
        status: status,
        groupId: groupId,
        assignedTo: assignedTo,
        deadline: deadline,
        monitoredBy: monitoredBy));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, taskState) {
          if (taskState is RemoveTaskByIdError) {
            // Navigator.pop(context);
            SnackBarWidget.showSnackBar(context, taskState.errorMessage);
          }
          if (taskState is RemoveTaskByIdSuccess) {
            widget.isPersonal
                ? _getTaksICreated()
                : _getTasksByGroupId(widget.groupId!);
            // Navigator.pop(context);
            SnackBarWidget.showSuccessSnackBar(
                context, "Task removed successfully");
          }
          if (taskState is CreateTaskError) {
            Navigator.pop(context);
            SnackBarWidget.showSnackBar(context, taskState.errorMessage);
          }
          if (taskState is CreateTaskSuccess) {
            controller.clear();
            _getTasksByGroupId(widget.groupId!);
            Navigator.pop(context);
            SnackBarWidget.showSuccessSnackBar(
                context, "Task created successfully");
          }
          if (taskState is UpdateTaskByIdError) {
            controller.clear();
            Navigator.pop(context);
            SnackBarWidget.showSnackBar(context, taskState.errorMessage);
          }
          if (taskState is UpdateTaskByIdSuccess) {
            _getTasksByGroupId(widget.groupId!);
            Navigator.pop(context);

            SnackBarWidget.showSuccessSnackBar(
                context, "Task updated successfully");
          }
          if (taskState is GetTasksByGroupIdError) {
            SnackBarWidget.showSnackBar(context, taskState.errorMessage);
          }
          if (taskState is GetTasksByGroupIdSuccess) {
            tasks = [];
            if (widget.isPersonal) {
              tasks = taskState.tasks;
            } else {
              for (Task task in taskState.tasks) {
                tasks = [];

                for (TaskAssignee taskAssignee in task.taskAssignee ?? []) {
                  if (taskAssignee.memberId == widget.userId ||
                      task.monitoredBy == widget.userId) {
                    if (!tasks.contains(task)) {
                      tasks.add(task);
                    }
                  }
                }
              }
              setState(() {});
            }
            // tasks = taskState.tasks;
          }
          if (taskState is GetMyAssignedTasksError) {
            SnackBarWidget.showSnackBar(context, taskState.errorMessage);
          }
          if (taskState is GetMyAssignedTasksSuccess) {
            tasks = taskState.tasks;
          }
          if (taskState is GetTasksICreatedError) {
            SnackBarWidget.showSnackBar(context, taskState.errorMessage);
          }
          if (taskState is GetTasksICreatedSuccess) {
            tasks = taskState.tasks;
          }
        },
        builder: (context, taskState) {
          logger("$taskState", {});
          return BlocConsumer<GroupsBloc, GroupsState>(
            listener: (context, groupState) {
              if (groupState is DeleteGroupError) {
                SnackBarWidget.showSnackBar(context, groupState.errorMessage);
              }
              if (groupState is DeleteGroupSuccess) {
                _getMyGroups();
                Navigator.pop(context);
              }

              if (groupState is GetGroupByIdError) {
                SnackBarWidget.showSnackBar(context, groupState.errorMessage);
              }
              if (groupState is GetGroupByIdSuccess) {
                groupMembers = [];
                group = groupState.group;

                for (GroupMember groupMember in group?.orgGroupMembers ?? []) {
                  groupMembers.add(
                      '${groupMember.member?.firstName} ${groupMember.member?.lastName}');
                }
                setState(() {});
              }
            },
            builder: (context, groupState) {
              logger("$groupState", {});
              return SafeArea(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppConstants.largeMargin,
                        vertical: AppConstants.mediumMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                            const SizedBox(
                              width: 35,
                            ),
                            CustomText(
                              title: toCamelCase(group?.name ?? ""),
                              fontSize: AppConstants.xLarge,
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              key: btnKey,
                              onTap: () {
                                menu?.show(widgetKey: btnKey);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppConstants.grey500,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(
                                  Icons.more_horiz,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: AppConstants.smallMargin,
                      ),
                      child: ListView.builder(
                        itemCount: showAllTasks
                            ? tasks.length + 1
                            : completedTasks.length + 1,
                        itemBuilder: (context, index) {
                          showAllTasks ? tasks : tasks = completedTasks;
                          if (index == tasks.length) {
                            return ListTile(
                              leading: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppConstants.grey500)),
                                ),
                              ),
                              title: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Add Note',
                                ),
                                onChanged: (val) {
                                  controller.text = val;
                                  setState(() {});
                                },
                                controller: controller,
                                onSubmitted: (text) {
                                  FocusScope.of(context).unfocus();
                                  tasks[index].isEditing = false;
                                  setState(() {});
                                },
                              ),
                              trailing: controller.text != ""
                                  ? IconButton(
                                      icon: const Icon(Icons.info_outline),
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        _itemListDetail(false, 0);
                                      },
                                    )
                                  : null,
                            );
                          } else {
                            return ListTile(
                              leading: InkWell(
                                onTap: () {
                                  for (Task task in tasks) {
                                    if (widget.isPersonal) {
                                      setState(() {
                                        tasks[index].status = "Done";
                                      });

                                      _updateTask(
                                          tasks[index].id!,
                                          tasks[index].name ?? "",
                                          tasks[index].desc ?? "",
                                          tasks[index].deadline,
                                          tasks[index].priority,
                                          tasks[index].status,
                                          tasks[index].groupId!,
                                          tasks[index].taskAssignee ?? [],
                                          tasks[index].monitoredBy!);
                                    } else {
                                      for (TaskAssignee taskAssignee
                                          in task.taskAssignee ?? []) {
                                        if (taskAssignee.memberId ==
                                            widget.userId) {
                                          setState(() {
                                            tasks[index].status = "Done";
                                          });

                                          _updateTask(
                                              tasks[index].id!,
                                              tasks[index].name ?? "",
                                              tasks[index].desc ?? "",
                                              tasks[index].deadline,
                                              tasks[index].priority,
                                              tasks[index].status,
                                              tasks[index].groupId!,
                                              tasks[index].taskAssignee ?? [],
                                              tasks[index].monitoredBy!);
                                        } else {
                                          SnackBarWidget.showSnackBar(context,
                                              "You can't complete this task");
                                        }
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: tasks[index].status == "Done"
                                              ? AppConstants.primaryColor
                                              : AppConstants.grey500)),
                                  child: tasks[index].status == "Done"
                                      ? const Icon(
                                          Icons.check,
                                          color: AppConstants.primaryColor,
                                          size: 15,
                                        )
                                      : null,
                                ),
                              ),
                              title: tasks[index].isEditing == true
                                  ? TextField(
                                      controller: TextEditingController(
                                          text: tasks[index].name),
                                      onChanged: (val) {
                                        controller.text = val;
                                      },
                                      onSubmitted: (newValue) {
                                        setState(() {
                                          controller.text = newValue;
                                          tasks[index].name = newValue;
                                          tasks[index].isEditing = false;
                                        });
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        for (var task in tasks) {
                                          task.isEditing = false;
                                        }
                                        setState(() {
                                          tasks[index].isEditing = true;
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tasks[index].name ?? "",
                                            style: const TextStyle(
                                                color: AppConstants.black,
                                                fontSize: AppConstants.medium,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                              // subtitle: GridView.count(
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   crossAxisCount: 3,
                              //   // crossAxisSpacing: ,
                              //   childAspectRatio: 6,
                              //   // mainAxisSpacing: 100,
                              //   children: [
                              //     Text(
                              //       tasks[index].deadline != ""
                              //           ? formatDate(tasks[index].deadline!)
                              //           : "Not specified",
                              //       style: const TextStyle(
                              //           color: AppConstants.grey500,
                              //           fontSize: AppConstants.small),
                              //     ),
                              //     Text(
                              //       tasks[index].priority ?? "Not specified",
                              //       style: const TextStyle(
                              //           color: AppConstants.primaryColor,
                              //           fontSize: AppConstants.small),
                              //     ),
                              //     Text(
                              //       tasks[index].status ?? "Not specified",
                              //       style: const TextStyle(
                              //           color: Colors.green,
                              //           fontSize: AppConstants.small),
                              //     ),
                              //   ],
                              // ),
                              trailing: tasks[index].isEditing == true
                                  ? SizedBox(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon:
                                                const Icon(Icons.edit_outlined),
                                            onPressed: () {
                                              for (Task task in tasks) {
                                                for (TaskAssignee assignee
                                                    in task.taskAssignee ??
                                                        []) {
                                                  if (!assignedToController
                                                      .contains(
                                                          '${assignee.member?.firstName!} ${assignee.member?.lastName!}')) {
                                                    assignedToController.add(
                                                        '${assignee.member?.firstName!} ${assignee.member?.lastName!}');
                                                  }
                                                }
                                              }
                                              _selectedDate =
                                                  tasks[index].deadline;
                                              controller.text == ""
                                                  ? controller.text =
                                                      tasks[index].name ?? ""
                                                  : controller.text;
                                              priorityController.text =
                                                  tasks[index].priority ?? "";
                                              _descriptionController.text =
                                                  tasks[index].desc!;
                                              statusController.text =
                                                  tasks[index].status ?? "";
                                              assignedToController =
                                                  assignedToController;
                                              print("####${controller.text}");
                                              _itemListDetail(
                                                  true, tasks[index].id!);
                                            },
                                          ),
                                          IconButton(
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                _deleteTaskById(
                                                    tasks[index].id!);
                                              }),
                                        ],
                                      ),
                                    )
                                  : null,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ]),
              );
            },
          );
        },
      ),
    );
  }

  _itemListDetail(bool update, int id) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          String status = statusController.text;
          String priority = priorityController.text;
          String description = _descriptionController.text;
          List<int> assignTo = [];
          List<String> assignToNames = assignedToController;
          final formKey = GlobalKey<FormState>();

          return StatefulBuilder(builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * .7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: const EdgeInsets.all(12),
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
                              if (formKey.currentState!.validate()) {
                                // if (controller.text != "") {
                                if (update) {
                                  _updateTask(
                                      id,
                                      controller.text,
                                      description,
                                      _selectedDate == "null"
                                          ? null
                                          : _selectedDate?.toString(),
                                      priority,
                                      status,
                                      widget.groupId!,
                                      assignTo,
                                      widget.userId);
                                } else {
                                  print(widget.userId);
                                  _createTask(
                                      controller.text,
                                      description,
                                      _selectedDate == "" ||
                                              _selectedDate == null ||
                                              _selectedDate == "null"
                                          ? null
                                          : _selectedDate!.toString(),
                                      priority == "" ? null : priority,
                                      status == "" ? null : status,
                                      widget.groupId!,
                                      widget.isPersonal ? [] : assignTo,
                                      widget.userId);
                                }
                                // }
                              }
                              // Navigator.pop(context);
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
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.watch_later_outlined,
                          color: Colors.red),
                      title: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 360)),
                              );
                              if (picked != null) {
                                setState(() {
                                  final String formattedDateTime = picked
                                      .add(const Duration(days: 1))
                                      .toUtc()
                                      .toIso8601String();
                                  _selectedDate = formattedDateTime;
                                });
                              }
                            },
                            child: Text(
                              _selectedDate == "" || _selectedDate == null
                                  ? "Select deadline"
                                  : formatDate(_selectedDate!),
                              style: const TextStyle(
                                  color: AppConstants.grey600,
                                  fontSize: AppConstants.large),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.notes, color: Colors.orange),
                      title: TextFormField(
                        onTapOutside: (val) {},
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Add description',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.priority_high_outlined,
                          color: Colors.red),
                      title: CustomDropdown<String>(
                        // initialItem: !update ? null : priority,
                        onChanged: (value) {
                          priority = value!;
                          setState(() {});
                        },
                        validateOnChange: widget.isPersonal ? false : true,
                        validator: widget.isPersonal
                            ? null
                            : (val) {
                                if (priority == "") {
                                  return "Please select priority";
                                }
                                return null;
                              },
                        hintText: "Priority",
                        decoration: CustomDropdownDecoration(
                            hintStyle: const TextStyle(
                              color: AppConstants.grey600,
                              fontWeight: FontWeight.normal,
                              fontSize: AppConstants.medium,
                            ),
                            closedSuffixIcon: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: AppConstants.primaryColorVeryLight,
                                  borderRadius: BorderRadius.circular(0)),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppConstants.grey600,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.red.shade800,
                              fontWeight: FontWeight.normal,
                              fontSize: AppConstants.small,
                            ),
                            closedErrorBorder: Border.all(color: Colors.red)),
                        items: const [
                          "NoPriority",
                          "Low",
                          "Medium",
                          "High",
                          "Urgent"
                        ],
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.done, color: Colors.orange),
                      title: CustomDropdown<String>(
                        // initialItem: !update ? null : status,
                        onChanged: (value) {
                          status = value!;
                          setState(() {});
                        },
                        validateOnChange: widget.isPersonal ? false : true,
                        validator: widget.isPersonal
                            ? null
                            : (val) {
                                if (status == "") {
                                  return "Please select status";
                                }
                                return null;
                              },
                        hintText: "Status",
                        decoration: CustomDropdownDecoration(
                            hintStyle: const TextStyle(
                              color: AppConstants.grey600,
                              fontWeight: FontWeight.normal,
                              fontSize: AppConstants.medium,
                            ),
                            closedSuffixIcon: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: AppConstants.primaryColorVeryLight,
                                  borderRadius: BorderRadius.circular(0)),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppConstants.grey600,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.red.shade800,
                              fontWeight: FontWeight.normal,
                              fontSize: AppConstants.small,
                            ),
                            closedErrorBorder: Border.all(color: Colors.red)),
                        items: const [
                          "Backlog",
                          "Todo",
                          "InProgress",
                          "AwaitingReview",
                          "InReview",
                          "Done",
                        ],
                      ),
                    ),
                    const Divider(),
                    widget.isPersonal
                        ? Container()
                        : ListTile(
                            leading: const Icon(Icons.groups_2_outlined,
                                color: Colors.teal),
                            title: CustomDropdown<String>.multiSelect(
                              // initialItems: !update ? null : assignToNames,
                              onListChanged: (value) {
                                assignToNames = value;
                                assignTo.clear();
                                for (var name in assignToNames) {
                                  for (GroupMember groupMember
                                      in group?.orgGroupMembers ?? []) {
                                    if ('${groupMember.member?.firstName} ${groupMember.member?.lastName}' ==
                                        name) {
                                      if (!assignTo
                                          .contains(groupMember.member!.id!)) {
                                        assignTo.add(groupMember.member!.id!);
                                      } else {
                                        assignTo
                                            .remove(groupMember.member!.id!);
                                      }
                                    }
                                  }
                                  logger("*******$assignTo", {});
                                }

                                setState(() {});
                              },
                              validateOnChange: true,
                              listValidator: (val) {
                                if (assignTo.isEmpty) {
                                  return "Please select member to be assigned";
                                }
                                return null;
                              },
                              hintText: "Assign",
                              decoration: CustomDropdownDecoration(
                                  hintStyle: const TextStyle(
                                    color: AppConstants.grey600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppConstants.medium,
                                  ),
                                  closedSuffixIcon: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color:
                                            AppConstants.primaryColorVeryLight,
                                        borderRadius: BorderRadius.circular(0)),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppConstants.grey600,
                                    ),
                                  ),
                                  errorStyle: TextStyle(
                                    color: Colors.red.shade800,
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppConstants.small,
                                  ),
                                  closedErrorBorder:
                                      Border.all(color: Colors.red)),
                              items: groupMembers,
                            ),
                          ),
                    widget.isPersonal ? Container() : const Divider(),
                    ListTile(
                      leading:
                          const Icon(Icons.attach_file, color: Colors.blue),
                      title: const Text('Add attachment'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}

class ChecklistItem {
  String title;
  String? note;
  bool isChecked;
  bool isEditing;
  TextEditingController controller;

  ChecklistItem(this.title, {this.note, this.isChecked = false})
      : isEditing = false,
        controller = TextEditingController(text: title);
}

String formatDate(String dateTimeString) {
  if (dateTimeString != "") {
    DateTime dateTime = DateTime.parse(dateTimeString);

    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
  return "";
}
