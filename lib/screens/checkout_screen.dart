import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String address = '';
  String city = '';
  String zip = '';
  String paymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shipping Information', style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 16),

              _buildTextField(
                label: 'Full Name',
                icon: Icons.person,
                validator: (val) => val == null || val.isEmpty ? 'Please enter your name' : null,
                onSaved: (val) => name = val ?? '',
              ),

              SizedBox(height: 16),

              _buildTextField(
                label: 'Address',
                icon: Icons.location_on,
                validator: (val) => val == null || val.isEmpty ? 'Please enter your address' : null,
                onSaved: (val) => address = val ?? '',
              ),

              SizedBox(height: 16),

              _buildTextField(
                label: 'City',
                icon: Icons.location_city,
                validator: (val) => val == null || val.isEmpty ? 'Please enter your city' : null,
                onSaved: (val) => city = val ?? '',
              ),

              SizedBox(height: 16),

              _buildTextField(
                label: 'ZIP Code',
                icon: Icons.local_post_office,
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Please enter ZIP code' : null,
                onSaved: (val) => zip = val ?? '',
              ),

              SizedBox(height: 32),

              Text('Payment Method', style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 16),

              Row(
                children: [
                  _paymentOptionCard('Credit Card', Icons.credit_card, selected: paymentMethod == 'Credit Card', onTap: () => setState(() => paymentMethod = 'Credit Card')),
                  SizedBox(width: 16),
                  _paymentOptionCard('PayPal', Icons.account_balance_wallet, selected: paymentMethod == 'PayPal', onTap: () => setState(() => paymentMethod = 'PayPal')),
                ],
              ),

              SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pushNamed(context, '/confirmation');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Place Order', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      style: TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _paymentOptionCard(String title, IconData icon, {required bool selected, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: selected ? null : Border.all(color: AppColors.border),
            boxShadow: selected
                ? [BoxShadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 6))]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36, color: selected ? AppColors.textPrimary : AppColors.textSecondary),
              SizedBox(height: 12),
              Text(title, style: TextStyle(color: selected ? AppColors.textPrimary : AppColors.textSecondary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
