import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: AppTheme.gray.shade600,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
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
          Expanded(
            child: ListView(
              children: [
                _buildSettingsItem(
                    icon: Icons.lock_outline,
                    title: 'Privacy and Security',
                    iconColor: AppTheme.gray.shade600,
                    onTap: () {
                      context.go("/workspace/profile/setting/privacy-security");
                    }),
                _buildSettingsItem(
                    icon: Icons.access_time,
                    title: 'Data and Storage',
                    iconColor: AppTheme.error.shade600,
                    onTap: () {}),
                _buildSettingsItem(
                    icon: Icons.notifications_none,
                    title: 'Notification and Sound',
                    iconColor: AppTheme.success.shade600,
                    onTap: () {}),
                _buildSettingsItem(
                    icon: Icons.devices,
                    title: 'Manage device',
                    iconColor: AppTheme.gray.shade600,
                    onTap: () {}),
                _buildSettingsItem(
                    icon: Icons.palette_outlined,
                    title: 'Appearance',
                    iconColor: AppTheme.info.shade600,
                    onTap: () {}),
                _buildSettingsItem(
                    icon: Icons.shield_outlined,
                    title: 'Suite Admin',
                    iconColor: AppTheme.warning.shade600,
                    onTap: () {}),
                _buildSettingsItem(
                    icon: Icons.logout,
                    title: 'Log out',
                    textColor: AppTheme.error.shade600,
                    iconColor: AppTheme.error.shade600,
                    onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    Color textColor = Colors.black87,
    required Color iconColor,
    required Function onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
