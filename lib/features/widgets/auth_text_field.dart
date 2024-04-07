import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String prefixImage;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final String? errorText;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    this.errorText,
    this.enabled = true,
    this.keyboardType,
    required this.hintText,
    required this.prefixImage,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          enabled: enabled,
          filled: true,
          fillColor: AppColors.grey,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: errorText != null
                ? Colors.red
                : const Color(
                    0xFF5F6366,
                  ),
          ),
          prefixIcon: Image.asset(
            prefixImage,
            color: errorText != null ? Colors.red : Colors.black,
          ),
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.grey,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(
                16,
              ),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
