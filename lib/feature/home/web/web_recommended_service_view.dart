import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class WebRecommendedServiceView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      initState: (state){
        Get.find<ServiceController>().getRecommendedServiceList(1,true);
      },
      builder: (serviceController){
        if(serviceController.recommendedServiceList != null && serviceController.recommendedServiceList!.length == 0){
          return SizedBox();
        }else{
          if(serviceController.recommendedServiceList != null){
            List<Service>? _serviceList = serviceController.recommendedServiceList;
            return Container(
              width: Dimensions.WEB_MAX_WIDTH / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Text('recommended_for_you'.tr, style: ubuntuMedium.copyWith(fontSize: 24)),
                  ),

                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _serviceList!.length > 2 ? 3 : _serviceList.length,
                    itemBuilder: (context, index){

                      Discount _discount = PriceConverter.discountCalculation(_serviceList[index]);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: InkWell(
                          onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromRecommendedScreen")),
                          child: ServiceModelView(
                            serviceList: _serviceList, discountAmountType: _discount.discountType, discountAmount: _discount.discountAmount, index: index,
                          ),
                        ),
                      );
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: CustomButton(
                      buttonText: 'see_all'.tr, onPressed: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromRecommendedScreen")),
                    ),
                  ),
                ],
              ),
            );
          }
          else{
            return WebCampaignShimmer(enabled: true,);
          }
        }
      },
    );
  }
}

class ServiceModelView extends StatelessWidget {
  final List<Service> serviceList;
  final int index;
  final int? discountAmount;
  final String? discountAmountType;

  const ServiceModelView({Key? key,
    required this.serviceList,
    required this.index,
    required this.discountAmount,
    required this.discountAmountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _lowestPrice = 0.0;
    if(serviceList[index].variationsAppFormat!.zoneWiseVariations != null){
       _lowestPrice = serviceList[index].variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
      for (var i = 0; i < serviceList[index].variationsAppFormat!.zoneWiseVariations!.length; i++) {
        if (serviceList[index].variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
          _lowestPrice = serviceList[index].variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
        }
      }
    }


    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor ,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow:Get.isDarkMode ?null: [BoxShadow(
          color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
          blurRadius: 5, spreadRadius: .5,
        )],
      ),
      child: Row(children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  child: CustomImage(
                    image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${serviceList[index].thumbnail}',
                    height: 90, width: 90, fit: BoxFit.cover,
                  ),
                ),

                if( discountAmount != null && discountAmount! > 0) Positioned.fill(
                  child: Align(alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).errorColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
                          topRight: Radius.circular(Dimensions.RADIUS_SMALL),
                        ),
                      ),
                      child: Text(
                        PriceConverter.percentageOrAmount('$discountAmount', discountAmountType!),
                        style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 2),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                serviceList[index].name!,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

              RatingBar(
                rating: double.parse(serviceList[index].avgRating.toString()), size: 15,
                ratingCount: serviceList[index].ratingCount,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

              Text(serviceList[index].shortDescription!,
                style: ubuntuLight.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(discountAmount! > 0)
                    Text(PriceConverter.convertPrice(_lowestPrice),
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                          decoration: TextDecoration.lineThrough,
                          color: Theme.of(context).errorColor.withOpacity(.8)),
                    ),

                  discountAmount! > 0?
                  Text(PriceConverter.convertPrice(_lowestPrice,
                      discount: discountAmount!.toDouble(),
                      discountType: discountAmountType
                  ),
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                        color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                  ): Text(PriceConverter.convertPrice(_lowestPrice),
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                        color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                  ),

                  // InkWell(
                  //   onTap: ()=>  Get.bottomSheet(ServiceCenterDialog(service: serviceList[index])),
                  //   child: Icon(Icons.add, color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor,
                  //       size: Dimensions.PADDING_SIZE_LARGE),
                  // ),
                ],
              ),
            ]),
          ),
        ),

      ]),
    );
  }
}


class WebCampaignShimmer extends StatelessWidget {
  final bool enabled;
  WebCampaignShimmer({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.WEB_MAX_WIDTH / 3.5,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
            itemCount: 5,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                child: Container(
                  height: 120, width: 200,
                  margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
                  ),
                  child: Shimmer(
                    duration: Duration(seconds: 1),
                    interval: Duration(seconds: 1),
                    enabled: enabled,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Container(
                        height: 120, width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            color: Colors.grey[300]
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                          Container(height: 15, width: 100, color: Colors.grey[300]),
                          SizedBox(height: 5),
                          RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                          SizedBox(height: 5),
                          Container(height: 10, width: 130, color: Colors.grey[300]),
                          SizedBox(height: 20),
                          Container(height: 10, width: 30, color: Colors.grey[300]),
                        ]),
                      ),
                    ]),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


