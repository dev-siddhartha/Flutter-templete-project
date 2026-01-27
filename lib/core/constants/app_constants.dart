import 'package:flutter_template/core/utils/app_imports.dart';

OutlineInputBorder globalBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.r),
    borderSide: BorderSide(color: color, width: 0.2.w),
  );
}
