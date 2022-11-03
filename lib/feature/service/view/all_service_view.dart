import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/core/core_export.dart';

class AllServiceView extends StatelessWidget {
  final String fromPage;
  AllServiceView({required this.fromPage});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(title: 'available_service'.tr,showCart: true,),
      body: _buildBody(fromPage,context,_scrollController),
    );
  }

  Widget _buildBody(String fromPage,BuildContext context,ScrollController scrollController){
    if(fromPage == 'fromPopularServiceView'){
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getPopularServiceList(1,true);
        },
        builder: (serviceController){
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: PaginatedListView(
                  scrollController: scrollController,
                  totalSize: serviceController.popularBasedServiceContent != null ? serviceController.popularBasedServiceContent!.total! : null,
                  offset: serviceController.popularBasedServiceContent != null ? serviceController.popularBasedServiceContent!.currentPage != null ? serviceController.popularBasedServiceContent!.currentPage! + 1 : null : null,
                  onPaginate: (int offset) async => await serviceController.getPopularServiceList(offset, false),
                  itemView: ServiceViewVertical(
                    service: serviceController.popularBasedServiceContent != null ? serviceController.popularServiceList : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                      vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                    ),
                    type: 'others',
                    noDataType: NoDataType.HOME,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }else if(fromPage == 'fromCampaign'){
      return GetBuilder<ServiceController>(
        builder: (serviceController){
          return _buildWidget(serviceController.campaignBasedServiceList!,context);
        },
      );
    }else if(fromPage == 'fromRecommendedScreen'){
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getRecommendedServiceList(1,true);
        },
        builder: (serviceController){
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: PaginatedListView(
                  scrollController: scrollController,
                  totalSize: serviceController.recommendedBasedServiceContent != null ? serviceController.recommendedBasedServiceContent!.total! : null,
                  offset: serviceController.recommendedBasedServiceContent != null ? serviceController.recommendedBasedServiceContent!.currentPage != null ? serviceController.recommendedBasedServiceContent!.currentPage! + 1 : null : null,
                  onPaginate: (int offset) async => await serviceController.getRecommendedServiceList(offset, false),
                  itemView: ServiceViewVertical(
                    service: serviceController.recommendedBasedServiceContent != null ? serviceController.recommendedServiceList : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                      vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                    ),
                    type: 'others',
                    noDataType: NoDataType.HOME,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }else if(fromPage == 'allServices'){
      return GetBuilder<ServiceController>(builder: (serviceController) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PaginatedListView(
                scrollController: scrollController,
                totalSize: serviceController.serviceContent != null ? serviceController.serviceContent!.total! : null,
                offset: serviceController.serviceContent != null ? serviceController.serviceContent!.to != null ? serviceController.serviceContent!.to : null : null,
                onPaginate: (int offset) async => await serviceController.getAllServiceList(offset, false),
                itemView: ServiceViewVertical(
                  service: serviceController.serviceContent != null ? serviceController.allService : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                    vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                  ),
                  type: 'others',
                  noDataType: NoDataType.HOME,
                ),
              ),
            ),
          ],
        );
      });
    }else{
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getSubCategoryBasedServiceList(fromPage,false,isShouldUpdate: true);
        },
        builder: (serviceController){
          return _buildWidget(serviceController.subCategoryBasedServiceList ,context);
        },
      );
    }
  }

  Widget _buildWidget(List<Service>? serviceList,BuildContext context){
    return FooterBaseView(
      isCenter:(serviceList == null || serviceList.length == 0),
      child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child:(serviceList != null && serviceList.length == 0) ?  NoDataScreen(text: 'no_services_found'.tr,type: NoDataType.SERVICE,) :  serviceList != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: CustomScrollView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              if(ResponsiveHelper.isWeb())
              SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,)),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                  mainAxisSpacing:  Dimensions.PADDING_SIZE_DEFAULT,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 : .75,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                  mainAxisExtent: 240,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    Get.find<ServiceController>().getServiceDiscount(serviceList[index]);
                    return ServiceWidgetVertical(service: serviceList[index],  isAvailable: true,fromType: fromPage,);
                  },
                  childCount: serviceList.length,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: Dimensions.WEB_CATEGORY_SIZE,)),
            ],
          ),
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

