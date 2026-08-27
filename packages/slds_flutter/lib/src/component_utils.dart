import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// a SLDSInputDecoration's border config util
OutlineInputBorder globalBorder(
    {required Color color, double? width, double? borderRadius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
    borderSide: BorderSide(color: color, width: width ?? 1.w),
  );
}
