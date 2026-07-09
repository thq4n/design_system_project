import 'package:flutter/material.dart';

/// Một hành động trong bottom sheet chọn nhanh (ví dụ: Chụp ảnh, Thư viện).
class DSBottomSheetAction {
  const DSBottomSheetAction({
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool isDestructive;
}
