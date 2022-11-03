import 'package:get/get.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/feature/home/widget/campaign_view.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/widget/category_view.dart';
import 'package:demandium/feature/home/widget/random_campaign_view.dart';
import 'web_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<BannerController>().getBannerList(reload);
    Get.find<CategoryController>().getCategoryList(1,reload);
    Get.find<ServiceController>().getPopularServiceList(1,reload);
    Get.find<CampaignController>().getCampaignList(reload);
    Get.find<ServiceController>().getRecommendedServiceList(1, reload);
    Get.find<ServiceController>().getAllServiceList(1,reload);
  }


  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    HomeScreen.loadData(false);
  }

  homeAppBar(){
    if(ResponsiveHelper.isDesktop(context)){
      return WebMenuBar();
    }else{
      return AddressAppBar(backButton: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Container(
      child: Scaffold(
        appBar: homeAppBar(),
        body: ResponsiveHelper.isDesktop(context) ? WebHomeScreen(scrollController: _scrollController) : SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await Get.find<BannerController>().getBannerList(true);
              await Get.find<CategoryController>().getCategoryList(1,true);
              await Get.find<ServiceController>().getPopularServiceList(1,true,);
              await Get.find<CampaignController>().getCampaignList(true);
              await Get.find<ServiceController>().getRecommendedServiceList(1,true);
              await Get.find<ServiceController>().getAllServiceList(1,true);
            },
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                child:
                CustomScrollView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: 10.0,),),
                    // Search Button
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverDelegate(
                            extentSize: 50,
                            child: InkWell(
                              onTap: () => Get.toNamed(RouteHelper.getSearchResultRoute()),
                              child: Padding(
                                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT,top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Container(
                                  padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border:Get.isDarkMode ? Border.all(color: Colors.grey.shade700):null,
                                      boxShadow:Get.isDarkMode ?null: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                                      color: Theme.of(context).cardColor
                                  ),
                                  child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween, children: [
                                    Text('search_services'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),),
                                      // child: Image.asset(Images.searchButton),
                                      child: Icon(Icons.search_rounded,color: Theme.of(context).primaryColorLight,),
                                    ),
                                  ]),
                                ),
                              ),
                            ))),
                    SliverToBoxAdapter(
                      child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(children: [
                        BannerView(),
                        CategoryView(),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        RandomCampaignView(),
                        PopularServiceView(),
                        CampaignView(),
                        RecommendedServiceView(),
                        GetBuilder<ServiceController>(builder: (serviceController) {
                          return PaginatedListView(
                            scrollController: _scrollController,
                            totalSize: serviceController.serviceContent != null ? serviceController.serviceContent!.total! : null,
                            offset: serviceController.serviceContent != null ? serviceController.serviceContent!.currentPage != null ? serviceController.serviceContent!.currentPage! + 1 : null : null,
                            onPaginate: (int offset) async => await serviceController.getAllServiceList(offset, false),
                            itemView: ServiceViewVertical(
                              service: serviceController.serviceContent != null ? serviceController.allService : null,
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                              ),
                              type: 'others',
                              noDataType: NoDataType.HOME,
                            ),
                          );
                        }),
                        SizedBox(height: 100,),
                      ]))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget? child;
  double? extentSize;

  SliverDelegate({@required this.child,@required this.extentSize});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child!;
  }

  @override
  double get maxExtent => extentSize!;

  @override
  double get minExtent => extentSize!;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != maxExtent || child != oldDelegate.child;
  }
}
