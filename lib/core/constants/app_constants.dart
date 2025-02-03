import 'package:flutter_template/core/utils/app_imports.dart';

OutlineInputBorder globalBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: BorderSide(color: color),
  );
}
