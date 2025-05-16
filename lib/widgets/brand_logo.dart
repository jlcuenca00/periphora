import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandLogo extends StatelessWidget {
  final double size;

  const BrandLogo({this.size = 48, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.devices_other, size: size, color: AppColors.primary),
        SizedBox(width: 8),
        Text(
          'Periphora',
          style: GoogleFonts.poppins(
            fontSize: size * 0.7,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ).createShader(Rect.fromLTWH(0, 0, size * 2, size)),
          ),
        ),
      ],
    );
  }
}
