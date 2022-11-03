import 'package:get/get.dart';
import 'package:demandium/components/footer_view.dart';
import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/core/helper/decorated_tab_bar.dart';
import '../widget/service_details_faq_section.dart';
import '../widget/service_overview.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String serviceID;

  const ServiceDetailsScreen({Key? key, required this.serviceID}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<ServiceTabController>().pageSize??0;
        if (Get.find<ServiceTabController>().offset! < pageSize) {
          Get.find<ServiceTabController>().getServiceReview(widget.serviceID, Get.find<ServiceTabController>().offset!+1);
        }}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppBar(centerTitle: false, title: 'service_details'.tr,showCart: true,),
      body: GetBuilder<ServiceDetailsController>(
          initState: (state) {
            Get.find<ServiceDetailsController>().getServiceDetails(widget.serviceID);},
          builder: (serviceController) {
            if(serviceController.service != null){
              Service? service = serviceController.service;
              Discount _discount = PriceConverter.discountCalculation(service!);
              double _lowestPrice = 0.0;
              if(service.variationsAppFormat!.zoneWiseVariations != null){
                _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
                for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                  if (service.variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
                    _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                  }
                }
              }
              return  CustomScrollView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                        extentSize: 120,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.isDesktop(context) ? (Get.width - Dimensions.WEB_MAX_WIDTH)/2 : 0,
                          ),
                          width: Dimensions.WEB_MAX_WIDTH, height: Dimensions.SERVICE_BANNER_SIZE,
                          child: Center(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,),
                            child: Text(service.name ?? '',
                                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white)),
                          )),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(opacity: .6,
                                image: NetworkImage('${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.coverImage}',),
                                fit: BoxFit.cover),
                          ),
                        ),
                      )),
                  SliverToBoxAdapter(child: Center(
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT ,vertical:Dimensions.PADDING_SIZE_DEFAULT),
                      child: Container(
                        width: Dimensions.WEB_MAX_WIDTH,
                        height: ResponsiveHelper.isMobile(context) ? 180 : null,
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                          // border: Border.all(color: Theme.of(context).colorScheme.primary),
                          color:Get.isDarkMode ? Theme.of(context).colorScheme.primary.withOpacity(.2):Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                          boxShadow: cardShadow,
                        ),
                        child:
                        Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      child: CustomImage(
                                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.thumbnail}',
                                        fit: BoxFit.cover,
                                        placeholder: Images.placeholder, height: 105, width: Dimensions.IMAGE_SIZE_MEDIUM,
                                      ),
                                    ),
                                    DiscountTag(fromTop: 0,
                                        color: Theme.of(context).errorColor,
                                        discount: _discount.discountAmount!,
                                        discountType: _discount.discountAmountType)
                                  ],
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                                Row(
                                  children: [
                                    SizedBox(height: 25,
                                      child: Row(
                                        children: [
                                          Gaps.horizontalGapOf(3),
                                          Image(image: AssetImage(Images.starIcon)),
                                          Gaps.horizontalGapOf(5),
                                          Text(
                                              service.avgRating!.toStringAsFixed(2),
                                              style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.secondary)),
                                        ],
                                      ),
                                    ),
                                    Gaps.horizontalGapOf(5),
                                    Text(
                                        "(${service.ratingCount})",
                                        style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)))
                                  ],
                                ),
                              ],
                            ),
                            //description price and add to card
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  //price with discount
                                  if(_discount.discountAmount! > 0)
                                    Text(PriceConverter.convertPrice(_lowestPrice,isShowLongPrice: true),
                                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                          decoration: TextDecoration.lineThrough,
                                          color: Theme.of(context).errorColor.withOpacity(.8)),
                                    ),
                                  _discount.discountAmount! > 0 ?
                                  Text(PriceConverter.convertPrice(
                                    _lowestPrice,
                                    discount: _discount.discountAmount!.toDouble(),
                                    discountType: _discount.discountAmountType,
                                    isShowLongPrice:true,
                                  ),
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.PADDING_SIZE_DEFAULT, color:Get.isDarkMode ? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                  ): Text(
                                    PriceConverter.convertPrice(double.parse(_lowestPrice.toString())),
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                                        color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Text(
                                    serviceController.service!.shortDescription!,
                                    textAlign: TextAlign.start, maxLines: 3,
                                    style: ubuntuRegular.copyWith(
                                        fontSize: 14.0,
                                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)
                                    ),),
                                  Divider(),
                                  Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          scaffoldState.currentState!.showBottomSheet((context) => ServiceCenterDialog(isFromDetails: true, service: service),
                                            backgroundColor: Colors.transparent,
                                          );
                                        },
                                        child: Text("add".tr+' +',style: ubuntuRegular.copyWith(color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),),
                  GetBuilder<ServiceTabController>(
                    builder: (serviceTabController) {
                      return SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverDelegate(
                          extentSize: 55,
                          child: Container(
                            color: Theme.of(context).cardColor,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                child: Container(
                                  width: Dimensions.WEB_MAX_WIDTH,
                                  color: Theme.of(context).cardColor,
                                  child: DecoratedTabBar(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    tabBar: TabBar(
                                        padding: EdgeInsets.only(top: 3),
                                        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.4),
                                        controller: serviceTabController.controller!,
                                        labelColor:Get.isDarkMode? Colors.white : Theme.of(context).primaryColor,
                                        labelStyle: ubuntuBold,
                                        indicatorColor: Theme.of(context).colorScheme.primary,
                                        indicatorPadding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                        labelPadding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        indicatorWeight: 2,
                                        onTap: (int? index) {
                                          switch (index) {
                                            case 0:
                                              serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.serviceOverview);
                                              break;
                                            case 1:
                                              serviceTabController.serviceDetailsTabs().length > 2 ?
                                              serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.faq):
                                              serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                                              break;
                                            case 2:
                                              serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                                              break;
                                          }
                                        },
                                        tabs: serviceTabController.serviceDetailsTabs()
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  GetBuilder<ServiceTabController>(
                      initState: (state){
                        Get.find<ServiceTabController>().getServiceReview(serviceController.service!.id!,1);
                      },
                      builder: (controller) {
                        if(controller.servicePageCurrentState == ServiceTabControllerState.serviceOverview){
                          return ServiceOverview(description:service.description!);
                        }else if(controller.servicePageCurrentState == ServiceTabControllerState.faq){
                          return ServiceDetailsFaqSection();
                        }else if(controller.reviewList.isNotEmpty){
                          print("inside_is_not_empty");
                          return ServiceDetailsReview(
                            serviceID: serviceController.service!.id!,
                            reviewList: controller.reviewList, rating : controller.rating,);
                        }else{
                          print("empty");
                          return  SliverToBoxAdapter(child: EmptyReviewWidget());
                        }
                      }),
                  ResponsiveHelper.isDesktop(context) ?   SliverToBoxAdapter(child: FooterView()) : SliverToBoxAdapter(),
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

