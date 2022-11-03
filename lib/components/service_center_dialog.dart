import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ServiceCenterDialog extends StatefulWidget {
  final Service? service;
  final CartModel? cart;
  final int? cartIndex;
  final bool? isFromDetails;

  ServiceCenterDialog(
      {required this.service,
      this.cart,
      this.cartIndex,
      this.isFromDetails = false,
      });

  @override
  State<ServiceCenterDialog> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ServiceCenterDialog> {
  @override
  void initState() {
    Get.find<CartController>().setInitialCartList(widget.service!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(ResponsiveHelper.isDesktop(context))
    return  Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: pointerInterceptor(),
    );
    return pointerInterceptor();
  }

  pointerInterceptor(){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.CART_DIALOG_PADDING),
      child: PointerInterceptor(
        child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          padding: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child:  GetBuilder<CartController>(builder: (cartControllerInit) {
              return GetBuilder<ServiceController>(builder: (serviceController) {
                if(widget.service!.variationsAppFormat!.zoneWiseVariations != null)
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT,left:  Dimensions.PADDING_SIZE_DEFAULT,top:  150,),
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                                    bottom:  Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: cartControllerInit.initialCartList.length,
                                            itemBuilder: (context, index) {
                                              //variation item
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_DEFAULT),
                                                child: Container(
                                                  height: 74.0,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).hoverColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_DEFAULT))
                                                  ),
                                                  child: GetBuilder<CartController>(builder: (cartController){
                                                    return Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                cartControllerInit.initialCartList[index].variantKey.replaceAll('-', ' '), style: ubuntuMedium,
                                                                maxLines: 2, overflow: TextOverflow.ellipsis,
                                                              ),
                                                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                                              Text(
                                                                  PriceConverter.convertPrice(double.parse(cartControllerInit.initialCartList[index].price.toString()),isShowLongPrice:true),
                                                                  style: ubuntuMedium.copyWith(color:  Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault)),
                                                            ],
                                                          ),
                                                        ),
                                                        // Expanded(child: SizedBox()),
                                                        Expanded( flex:1,
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                            cartControllerInit.initialCartList[index].quantity > 0 ? InkWell(
                                                              onTap: (){
                                                                cartController.updateQuantity(index, false);
                                                              },
                                                              child: Container(
                                                                height: 30, width: 30,
                                                                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                                                decoration: BoxDecoration(shape: BoxShape.circle, color:  Theme.of(context).colorScheme.secondary),
                                                                alignment: Alignment.center,
                                                                child: Icon(Icons.remove , size: 15, color:Theme.of(context).cardColor,),
                                                              ),
                                                            ) : SizedBox(),

                                                            cartControllerInit.initialCartList[index].quantity > 0 ? Text(
                                                              cartControllerInit.initialCartList[index].quantity.toString(),
                                                            ) : SizedBox(),

                                                            GestureDetector(
                                                              onTap: (){
                                                                cartController.updateQuantity(index, true);
                                                              },
                                                              child: Container(
                                                                height: 30, width: 30,
                                                                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color:  Theme.of(context).colorScheme.secondary
                                                                ),
                                                                alignment: Alignment.center,
                                                                child: Icon(
                                                                  Icons.add ,
                                                                  size: 15,
                                                                  color:Theme.of(context).cardColor,
                                                                ),
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ]),
                                                    );
                                                  },
                                                  ),
                                                ),
                                              );
                                            }),
                                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                      ]),
                                ),
                              ]),
                        ),
                      ),
                      Positioned(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20.0,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_DEFAULT)),
                                    child: CustomImage(
                                      image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${widget.service!.thumbnail}',
                                      height: Dimensions.IMAGE_SIZE_MEDIUM,
                                      width: Dimensions.IMAGE_SIZE_MEDIUM,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () => Get.back(),
                                      child: Icon(Icons.close)),
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                                  Text(
                                    widget.service!.name!,
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: Dimensions.PADDING_SIZE_RADIUS,),
                                  Text(
                                    "${widget.service!.variationsAppFormat!.zoneWiseVariations!.length} ${'options_available'.tr}",
                                    style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5)),
                                  ),
                                ]),
                          ],
                        ),
                      ),),
                      Positioned(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT,
                        bottom:  Dimensions.PADDING_SIZE_DEFAULT,
                        child:  GetBuilder<CartController>(builder: (cartController) {
                        bool _addToCart = true;
                        return cartController.isLoading ? Center(child: CircularProgressIndicator()) : CustomButton(
                            onPressed:cartControllerInit.isButton ? () async{
                              if(_addToCart) {
                                _addToCart = false;
                                if(Get.find<AuthController>().isLoggedIn()){
                                  await cartController.addMultipleCartToServer();
                                  await cartController.getCartListFromServer();
                                  // Get.back();

                                }else{
                                  cartController.addDataToCart();
                                }
                              }
                            }: null,
                            buttonText: "add_to_cart".tr);
                      }),)
                    ],
                  );
                return Container(
                    height: Get.height / 7,
                    child: Center(child: Text('no_variation_is_available'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)));
              });
            }
          ),
        ),
      ),
    );
  }
}
