import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';

class OfferScreen extends GetView<ServiceController> {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(
        isBackButtonExist: false,
        title: 'offers'.tr,
      ),
      body: GetBuilder<ServiceController>(
        initState: (state) async {
         await controller.getOffersList(1,true);
        },
        builder: (serviceController){
          if( serviceController.offerBasedServiceList == null){
            return Center(child: FooterBaseView(child: WebShadowWrap(child: Center(child: CircularProgressIndicator()))));
          }else{
            List<Service> serviceList = serviceController.offerBasedServiceList!;
              return FooterBaseView(
                scrollController: _scrollController,
                isCenter: (serviceList.length == 0),
                child:serviceList.length > 0 ?  Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.PADDING_FOR_CHATTING_BUTTON),
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: PaginatedListView(
                      scrollController: _scrollController,
                      totalSize: serviceController.offerBasedServiceContent != null ? serviceController.offerBasedServiceContent!.total! : null,
                      offset: serviceController.offerBasedServiceContent != null ? serviceController.offerBasedServiceContent!.currentPage != null ? serviceController.offerBasedServiceContent!.currentPage! + 1 : null : null,
                      onPaginate: (int offset) async => await serviceController.getOffersList(offset, false),
                      itemView: ServiceViewVertical(
                        service: serviceList,
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                        ),
                        type: 'others',
                        noDataType: NoDataType.HOME,
                      ),
                    ),
                  ),
                ):
                NoDataScreen(
                  text: "no_offer_found".tr,
                  type:  NoDataType.OFFERS,
                ),
              );
          }
        },
      ),
    );
  }
}