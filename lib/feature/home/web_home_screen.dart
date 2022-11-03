import 'package:get/get.dart';
import 'package:demandium/components/footer_view.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/widget/category_view.dart';

class WebHomeScreen extends StatelessWidget {
  final ScrollController? scrollController;
  WebHomeScreen({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    Get.find<BannerController>().setCurrentIndex(0, false);
    return CustomScrollView(
      controller: scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,)),
        SliverToBoxAdapter(
          child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH,child: WebBannerView())),
        ),
        SliverToBoxAdapter(child: CategoryView(),),
        SliverToBoxAdapter(
          child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // WebRecommendedServiceView(),
                Expanded(child: WebPopularServiceView()),
              ]))),
        ),

        SliverToBoxAdapter(child: Center(
          child: SizedBox(
            width: Dimensions.WEB_MAX_WIDTH,
            child: Column(
              children: [
                GetBuilder<ServiceController>(builder: (serviceController) {
                  if(serviceController.serviceContent != null)
                  return PaginatedListView(
                    scrollController: _scrollController,
                    totalSize: serviceController.serviceContent!.total != null ? serviceController.serviceContent!.total! : null,
                    offset: serviceController.serviceContent!.to != null ? serviceController.serviceContent!.to! : null,
                    onPaginate: (int offset) async => await serviceController.getAllServiceList(offset,false),
                    itemView: ServiceViewVertical(
                      service: serviceController.serviceContent != null ? serviceController.serviceContent!.serviceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                      ),
                      type: 'others',
                    ),
                  );
                  return SizedBox();
                }),
              ],
            ),
          ),
        ),),
        SliverToBoxAdapter(child: SizedBox(height: 100.0,),),
        SliverToBoxAdapter(child: FooterView(),),
      ],
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}
