import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricAuthEnabled = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';
  String _selectedTheme = 'System Default';

  final List<String> _languages = ['English', 'Tagalog', 'Spanish', 'Japanese'];
  final List<String> _currencies = ['USD', 'PHP', 'EUR', 'JPY'];
  final List<String> _themes = ['System Default', 'Light', 'Dark'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Settings
            _buildSectionHeader('Account Settings'),
            _buildListTile(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () => _navigateToEditProfile(context),
            ),
            _buildListTile(
              icon: Icons.security_outlined,
              title: 'Privacy Settings',
              onTap: () => _showPrivacySettings(context),
            ),
            _buildListTile(
              icon: Icons.credit_card_outlined,
              title: 'Payment Methods',
              onTap: () => _showPaymentMethods(context),
            ),

            // App Preferences
            _buildSectionHeader('App Preferences'),
            _buildSwitchTile(
              icon: Icons.notifications_outlined,
              title: 'Push Notifications',
              value: _notificationsEnabled,
              onChanged: (value) => setState(() => _notificationsEnabled = value),
            ),
            _buildSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              value: _darkModeEnabled,
              onChanged: (value) => setState(() => _darkModeEnabled = value),
            ),
            _buildDropdownTile(
              icon: Icons.language_outlined,
              title: 'Language',
              value: _selectedLanguage,
              items: _languages,
              onChanged: (value) => setState(() => _selectedLanguage = value!),
            ),
            _buildDropdownTile(
              icon: Icons.currency_exchange_outlined,
              title: 'Currency',
              value: _selectedCurrency,
              items: _currencies,
              onChanged: (value) => setState(() => _selectedCurrency = value!),
            ),
            _buildDropdownTile(
              icon: Icons.palette_outlined,
              title: 'Theme',
              value: _selectedTheme,
              items: _themes,
              onChanged: (value) => setState(() => _selectedTheme = value!),
            ),

            // Security
            _buildSectionHeader('Security'),
            _buildSwitchTile(
              icon: Icons.fingerprint_outlined,
              title: 'Biometric Authentication',
              value: _biometricAuthEnabled,
              onChanged: (value) => setState(() => _biometricAuthEnabled = value),
            ),
            _buildListTile(
              icon: Icons.lock_outlined,
              title: 'Change Password',
              onTap: () => _showChangePasswordDialog(context),
            ),

            // App Info & Support
            _buildSectionHeader('About'),
            _buildListTile(
              icon: Icons.info_outline,
              title: 'About LakbayNow',
              onTap: () => _showAboutDialog(context),
            ),
            _buildListTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => _showHelpSupport(context),
            ),
            _buildListTile(
              icon: Icons.star_outline,
              title: 'Rate the App',
              onTap: () => _rateApp(context),
            ),
            _buildListTile(
              icon: Icons.share_outlined,
              title: 'Share App',
              onTap: () => _shareApp(context),
            ),
            
            // Legal
            _buildSectionHeader('Legal'),
            _buildListTile(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              onTap: () => _showTerms(context),
            ),
            _buildListTile(
              icon: Icons.verified_user_outlined,
              title: 'Privacy Policy',
              onTap: () => _showPrivacyPolicy(context),
            ),
            
            const SizedBox(height: 32),
            Center(
              child: Text(
                'LakbayNow v1.0.0',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right_outlined),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, size: 24),
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // Navigation methods
  void _navigateToEditProfile(BuildContext context) {
    // Implement profile editing navigation
  }

  void _showPrivacySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Settings'),
        content: const Text('Privacy settings will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethods(BuildContext context) {
    // Implement payment methods dialog
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement password change logic
              Navigator.pop(context);
            },
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'LakbayNow',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2023 LakbayNow Travel App',
    );
  }

  void _showHelpSupport(BuildContext context) {
    // Implement help and support navigation
  }

  void _rateApp(BuildContext context) {
    // Implement app rating
  }

  void _shareApp(BuildContext context) {
    // Implement app sharing
  }

  void _showTerms(BuildContext context) {
    // Implement terms view
  }

  void _showPrivacyPolicy(BuildContext context) {
    // Implement privacy policy view
  }
}