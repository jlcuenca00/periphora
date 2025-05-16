import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 60, color: AppColors.textPrimary),
            ),
            SizedBox(height: 16),
            Text(
              'Alex Mercer',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 8),
            Text(
              'merceralex@example.com',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _buildOptionTile(Icons.history, 'Order History'),
                  _buildOptionTile(Icons.settings, 'Settings'),
                  _buildOptionTile(Icons.logout, 'Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.textSecondary),
        onTap: () {
          // TODO: Implement navigation or actions
        },
      ),
    );
  }
}
