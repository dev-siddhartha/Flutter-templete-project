import 'dart:io';

import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/dashboard/data/constants/dashboard_constants.dart';

class BottomNavWidget extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const BottomNavWidget(
      {super.key, required this.currentIndex, required this.onTabSelected});

  @override
  BottomNavWidgetState createState() => BottomNavWidgetState();
}

class BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6.0),
            blurRadius: 6.0,
            spreadRadius: 3.0,
            color: Colors.black.withAlpha(50),
          )
        ],
        borderRadius: BorderRadius.circular(10.r),
        color: context.isDark ? AppColors.grey[800] : AppColors.grey[200],
      ),
      child: BottomAppBar(
        elevation: 20.r,
        height: Platform.isIOS ? 60.h : 70.h,
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        shadowColor: Colors.transparent,
        notchMargin: 6.h,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 3,
              child: _buildNavItem(
                label: BottomNavString.home,
                icon: Icons.home,
                index: 0,
              ),
            ),
            Expanded(
              flex: 3,
              child: _buildNavItem(
                label: BottomNavString.history,
                icon: Icons.history,
                index: 1,
              ),
            ),
            Expanded(
              flex: 3,
              child: _buildNavItem(
                label: BottomNavString.profile,
                icon: Icons.person,
                index: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _buildNavItem(
      {required String label, required IconData icon, required int index}) {
    final isSelected = widget.currentIndex == index;
    return InkWell(
      onTap: () => widget.onTabSelected(index),
      child: Column(
        spacing: 5.h,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          5.verticalSpace,
          Icon(
            icon,
            size: 25.w,
            color: isSelected
                ? AppColors.primaryColor
                : context.isDark
                    ? AppColors.grey[300]
                    : AppColors.grey[800],
          ),
          TextWidget(
            label,
            textType: TextType.custom,
            textOptions:
                TextOptions(fontWeight: isSelected ? FontWeight.w600 : null),
            color: isSelected
                ? AppColors.primaryColor
                : context.isDark
                    ? AppColors.grey[300]
                    : AppColors.grey[800],
          ),
        ],
      ),
    );
  }
}
