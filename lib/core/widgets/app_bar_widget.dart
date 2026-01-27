import 'package:flutter_template/core/utils/app_imports.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? leadingWidth;
  final bool showBackButton;
  final Widget? customTitle;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? color;
  final double? height;
  final BoxBorder? borderSide;

  const AppBarWidget({
    super.key,
    this.title,
    this.showBackButton = true,
    this.actions,
    this.customTitle,
    this.leadingWidth,
    this.centerTitle = false,
    this.color,
    this.height,
    this.borderSide,
  }) : assert((customTitle == null) || (title == null),
            "Provide either title or customTitle");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: borderSide ??
            Border(
              bottom: BorderSide(
                width: 1,
                color: context.isDark ? Colors.black : const Color(0xFFE5E7EB),
              ),
            ),
      ),
      child: AppBar(
        backgroundColor: color,
        centerTitle: centerTitle,
        leading: showBackButton ? const BackButtonWidget() : null,
        automaticallyImplyLeading: false,
        title: customTitle ??
            (title != null
                ? TextWidget(
                    title!,
                    textType: TextType.custom,
                    textOptions: TextOptions(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : null),
        actions: [...?actions, 10.horizontalSpace],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 50.h);
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(left: 12),
        child: Icon(
          Icons.arrow_back_ios,
        )).onTap(() {
      /// so that i can navigate from tab to tab in home screen
      Navigator.maybePop(context);
    });
  }
}
