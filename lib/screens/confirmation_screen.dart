import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ConfirmationScreen extends StatelessWidget {
  final String orderNumber = 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, size: 100, color: AppColors.success),
              SizedBox(height: 24),
              Text('Thank you for your order!', style: Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
              SizedBox(height: 12),
              Text(
                'Your order #$orderNumber has been placed successfully.\nYou will receive a confirmation email shortly.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  backgroundColor: AppColors.primary,
                ),
                child: Text('Back to Home', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('View Orders feature coming soon!')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  side: BorderSide(color: AppColors.primary),
                ),
                child: Text('View Orders', style: TextStyle(fontSize: 18, color: AppColors.primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
