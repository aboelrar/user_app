import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class WebPopularServiceView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      initState: (state){
        Get.find<ServiceController>().getPopularServiceList(1,true);
      },
      builder: (serviceController){
        if(serviceController.popularServiceList != null && serviceController.popularServiceList!.length == 0){
          return SizedBox();
        }else{
          if(serviceController.popularServiceList != null){
            List<Service>? _serviceList = serviceController.popularServiceList;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('popular_services'.tr, style: ubuntuMedium.copyWith(fontSize: 24)),
                        InkWell(
                            onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromPopularServiceView")),
                            child: Text('see_all'.tr, style: ubuntuMedium.copyWith(fontSize: 16,color: Theme.of(context).primaryColor))),
                      ],
                    ),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, childAspectRatio: .7,
                      crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL, mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    itemCount: _serviceList!.length > 5 ? 6 : _serviceList.length,
                    itemBuilder: (context, index){
                      if(index == 5) {
                        return InkWell(
                          onTap: () => Get.toNamed(RouteHelper.getPopularFoodRoute()),
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              boxShadow: [BoxShadow(
                                color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                                blurRadius: 5, spreadRadius: 1,
                              )],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '+${_serviceList.length-5}\n${'more'.tr}', textAlign: TextAlign.center,
                              style: ubuntuBold.copyWith(fontSize: 24, color: Theme.of(context).cardColor),
                            ),
                          ),
                        );
                      }

                      return InkWell(
                        onTap: () {
                          //TODO: Product Details
                          Get.toNamed(
                            RouteHelper.getServiceRoute(_serviceList[index].id!),
                            arguments: ServiceDetailsScreen(serviceID: _serviceList[index].id!),
                          );

                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            boxShadow: [BoxShadow(
                              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                              blurRadius: 5, spreadRadius: 1,
                            )],
                          ),
                          child: Column(children: [


                            Expanded(flex: 2,
                              child: SizedBox(
                                width: double.maxFinite,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                  child: CustomImage(
                                    image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${_serviceList[index].thumbnail}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 3,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                Text(
                                  _serviceList[index].name!,
                                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                Text(
                                  _serviceList[index].shortDescription!,
                                  style: ubuntuLight.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                  maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                                RatingBar(
                                  rating: double.parse(_serviceList[index].avgRating.toString()), size: 15,
                                  ratingCount: _serviceList[index].ratingCount,
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                                Row(
                                  children: [
                                    if(_serviceList[index].variationsAppFormat!.defaultPrice != null )
                                      Expanded(flex: 3,
                                        child: Text(
                                          PriceConverter.convertPrice(
                                            double.parse(_serviceList[index].variationsAppFormat!.defaultPrice.toString()),
                                            discount: 2.0, discountType: "DiscountType",
                                          ),
                                          style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: (){},
                                        child: Icon(Icons.add, color: Theme.of(context).primaryColor, size: Dimensions.PADDING_SIZE_LARGE),
                                      ),
                                    ),


                                  ],
                                ),
                              ]),
                            ),

                          ]),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }else{
            return WebCampaignShimmer(enabled: true,);
          }
        }
      },
    );
  }
}

class WebCampaignShimmer extends StatelessWidget {
  final bool enabled;
  WebCampaignShimmer({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, childAspectRatio: (1/0.35),
        crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE, mainAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      itemCount: 6,
      itemBuilder: (context, index){
        return Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: enabled,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Container(
                height: 90, width: 90,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Colors.grey[300]),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 100, color: Colors.grey[300]),
                    SizedBox(height: 5),

                    Container(height: 10, width: 130, color: Colors.grey[300]),
                    SizedBox(height: 5),

                    RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                    SizedBox(height: 5),

                    Container(height: 10, width: 30, color: Colors.grey[300]),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}

