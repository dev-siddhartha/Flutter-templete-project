import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/widgets/pagination/newton_cradle.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Pull-to-refresh + infinite-scroll pagination, merged into one widget.
///
/// Pass [onLoading] to enable pull-up pagination (infinite scroll); omit it
/// to use this purely as a pull-to-refresh wrapper.
///
/// [showCradleFooter]: true by default, shows the cradle animation while
/// fetching the next page.
class PaginationWidget extends StatefulWidget {
  final Function() onRefresh;
  final Function()? onLoading;
  final Widget child;
  final bool showRefresh;
  final ScrollController? scrollController;
  final bool showCradleFooter;
  final Widget? header;

  const PaginationWidget({
    super.key,
    required this.onRefresh,
    this.onLoading,
    required this.child,
    this.showRefresh = true,
    this.scrollController,
    this.showCradleFooter = true,
    this.header,
  });

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      scrollController: widget.scrollController,
      enablePullUp: widget.onLoading != null,
      enablePullDown: widget.showRefresh,
      onRefresh: () async {
        widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      onLoading: widget.onLoading == null
          ? null
          : () async {
              widget.onLoading!();
              _refreshController.loadComplete();
            },
      header: widget.header ??
          WaterDropHeader(
            complete: const SizedBox(),
            waterDropColor: Theme.of(context).brightness == Brightness.light
                ? context.primaryColor
                : AppColors.whiteColor,
            idleIcon: Icon(
              Icons.autorenew,
              size: 15,
              color: context.isDark ? AppColors.blackColor : AppColors.whiteColor,
            ),
          ),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (!widget.showCradleFooter) {
            return const SizedBox();
          }
          if (mode == LoadStatus.idle) {
            body = NewtonCradle(size: 50.w, color: context.primaryColor);
          } else if (mode == LoadStatus.loading) {
            body = NewtonCradle(size: 50.w, color: context.primaryColor);
          } else if (mode == LoadStatus.failed) {
            body = const SldsText("Load Failed! Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = NewtonCradle(size: 50.w, color: context.primaryColor);
          } else {
            body = const SizedBox();
          }
          return SizedBox(
            height: 55.0.h,
            child: Center(child: body),
          );
        },
      ),
      child: widget.child,
    );
  }
}
