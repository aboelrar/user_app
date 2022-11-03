import 'package:get/get.dart';
import 'package:demandium/components/web_search_widget.dart';
import 'package:demandium/core/core_export.dart';

class WebMenuBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      width: Dimensions.WEB_MAX_WIDTH,
      decoration: BoxDecoration(
          boxShadow: cardShadow,
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.RADIUS_LARGE),bottomLeft: Radius.circular(Dimensions.RADIUS_LARGE))
      ),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Row(children: [

        InkWell(
          onTap: () => Get.toNamed(RouteHelper.getInitialRoute()),
          child: Image.asset(Images.logo, height: 50, width: 50),
        ),

        Get.find<LocationController>().getUserAddress() != null ? Expanded(child: InkWell(
          onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: GetBuilder<LocationController>(builder: (locationController) {
              return Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    locationController.getUserAddress()!.addressType == 'home' ? Icons.home_filled
                        : locationController.getUserAddress()!.addressType == 'office' ? Icons.work : Icons.location_on,
                    size: 20, color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Flexible(
                    child: Text(
                      locationController.getUserAddress()!.address!,
                      style: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color, fontSize: Dimensions.fontSizeSmall,
                      ),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor),
                ],
              );
            }),
          ),
        )) : Expanded(child: SizedBox()),
        MenuButtonWeb( title: 'home'.tr, onTap: () => Get.toNamed(RouteHelper.getInitialRoute())),
        SizedBox(width: 20),
        MenuButtonWeb( title: 'categories'.tr, onTap: () => Get.toNamed(RouteHelper.getCategoryRoute('homePage','123'))),
        SizedBox(width: 20),
        MenuButtonWeb( title: 'services'.tr, onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute('allServices'))),
        SizedBox(width: 20),
        ///search widget
        SearchWidgetWeb(),
        SizedBox(width: 20),
        MenuButtonWebIcon( icon: Icons.shopping_cart, isCart: true, onTap: () => Get.toNamed(RouteHelper.getCartRoute())),
        SizedBox(width: 20),
        MenuButtonWebIcon(icon: Icons.menu, onTap: () {
          Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
        }),
        SizedBox(width: 20),
        /*GetBuilder<AuthController>(builder: (authController) {
          return MenuButtonWeb(
            icon: authController.isLoggedIn() ? Icons.shopping_bag : Icons.lock,
            title: authController.isLoggedIn() ? 'my_orders'.tr : 'sign_in'.tr,
            onTap: () => Get.toNamed(authController.isLoggedIn() ? RouteHelper.getMainRoute('order') : RouteHelper.getSignInRoute(RouteHelper.main)),
          );
        }),*/

        GetBuilder<AuthController>(
            builder: (authController){
              return InkWell(
                onTap: () {
                  print("okay");
                  Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  ),
                  child: Row(children: [
                    Image.asset(Images.webSignInButton,width: 20.0,height: 20.0,),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                    Text(authController.isLoggedIn() ? 'my_orders'.tr : 'sign_in'.tr, style: ubuntuRegular.copyWith(color: Colors.white)),
                  ]),
                ),
              );
            }
        ),

      ]),
    ));
  }
  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, 70);
}

class MenuButtonWebIcon extends StatelessWidget {
  final IconData? icon;
  final bool isCart;
  final Function() onTap;
  MenuButtonWebIcon({@required this.icon, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        Stack(clipBehavior: Clip.none, children: [

          Icon(icon, size: 20),

          isCart ? GetBuilder<CartController>(builder: (cartController) {
            return cartController.cartList.length > 0 ? Positioned(
              top: -5, right: -5,
              child: Container(
                height: 15, width: 15, alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                child: Text(
                  cartController.cartList.length.toString(),
                  style: ubuntuRegular.copyWith(fontSize: 12, color: Theme.of(context).cardColor),
                ),
              ),
            ) : SizedBox();
          }) : SizedBox(),
        ]),
        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      ]),
    );
  }
}

class MenuButtonWeb extends StatelessWidget {
  final String? title;
  final bool isCart;
  final Function() onTap;
  MenuButtonWeb({@required this.title, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        Stack(clipBehavior: Clip.none, children: [
          isCart ? GetBuilder<CartController>(builder: (cartController) {
            return cartController.cartList.length > 0 ? Positioned(
              top: -5, right: -5,
              child: Container(
                height: 15, width: 15, alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                child: Text(
                  cartController.cartList.length.toString(),
                  style: ubuntuRegular.copyWith(fontSize: 12, color: Theme.of(context).cardColor),
                ),
              ),
            ) : SizedBox();
          }) : SizedBox(),
        ]),
        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

        Text(title!, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
      ]),
    );
  }
}

