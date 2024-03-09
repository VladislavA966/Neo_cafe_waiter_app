import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  const SearchField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 166,
      left: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        height: 50,
        width: double.infinity,
        child: Material(
          borderRadius: BorderRadius.circular(100),
          clipBehavior: Clip.antiAlias,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.grey,
              hintText: 'Поиск',
              contentPadding: const EdgeInsets.only(left: 20),
              suffixIcon: Container(
                decoration: const BoxDecoration(
                  color: AppColors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
