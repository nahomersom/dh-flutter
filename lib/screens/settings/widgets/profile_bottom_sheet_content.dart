import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileBottomSheetContent extends StatefulWidget {
  const ProfileBottomSheetContent({Key? key}) : super(key: key);

  @override
  State<ProfileBottomSheetContent> createState() =>
      _ProfileBottomSheetContentState();
}

class _ProfileBottomSheetContentState extends State<ProfileBottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 16),
              // Organization Section using ExpansionTile
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  tilePadding: EdgeInsets.symmetric(vertical: 14),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.groups_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    'Kite Technologies',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.baseBlack),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _OrganizationItem(
                            icon: Icons.person_4_outlined,
                            title: 'Personal',
                            count: '3',
                            color: AppTheme.info.shade600,
                          ),
                          const SizedBox(height: 16),
                          _OrganizationItem(
                            icon: Icons.groups_outlined,
                            title: 'Neo Fintech Solutions',
                            count: '12',
                            color: AppTheme.warning.shade600,
                          ),
                          const SizedBox(height: 24),
                          OutlinedButton(
                            onPressed: () {
                              context.go(
                                  "/workspace/profile/create-organization-setting");
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.primary.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side:
                                  BorderSide(color: AppTheme.primary.shade600),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                SizedBox(width: 8),
                                Text(
                                  'Create Organization',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Menu Items
              _MenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.contact_page_outlined,
                title: 'Contacts',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.phone_callback_outlined,
                title: 'Call History',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.wifi_calling_outlined,
                title: 'Recoded Calls',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.lightbulb_outline,
                title: 'Tips',
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrganizationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;
  final Color color;

  const _OrganizationItem({
    required this.icon,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.primary.shade400,
            shape: BoxShape.circle,
          ),
          child: Text(
            count,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap,
    );
  }
}
