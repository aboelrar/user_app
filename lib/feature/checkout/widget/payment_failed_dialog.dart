import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class PaymentFailedDialog extends StatelessWidget {
  final String? orderID;
  PaymentFailedDialog({required this.orderID});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Image.asset(Images.warning, width: 70, height: 70),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              'are_you_agree_with_this_order_fail'.tr, textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          //   child: Text(
          //     'if_you_do_not_pay'.tr,
          //     style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center,
          //   ),
          // ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          // GetBuilder<ServiceBookingController>(builder: (orderController) {
          //   return !orderController.isLoading ? Column(children: [
          //     Get.find<CheckOutController>().selectedPaymentMethod == PaymentMethodName.COS ? CustomButton(
          //       buttonText: 'switch_to_cash_on_delivery'.tr,
          //       onPressed: (){},
          //       radius: Dimensions.RADIUS_SMALL, height: 40,
          //     ) : SizedBox(),
          //
          //     SizedBox(
          //       width: Get.find<CheckOutController>().selectedPaymentMethod == PaymentMethodName.COS ? Dimensions.PADDING_SIZE_LARGE : 0,
          //     ),
          //
          //     TextButton(
          //       onPressed: () {
          //         Get.offAllNamed(RouteHelper.getInitialRoute());
          //       },
          //       style: TextButton.styleFrom(
          //         backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(Dimensions.WEB_MAX_WIDTH, 40), padding: EdgeInsets.zero,
          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
          //       ),
          //       child: Text('continue_with_order_fail'.tr, textAlign: TextAlign.center, style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)),
          //     ),
          //   ]) : Center(child: CircularProgressIndicator());
          // }),

          TextButton(
            onPressed: () {
              Get.offAllNamed(RouteHelper.getInitialRoute());
            },
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(Dimensions.WEB_MAX_WIDTH, 40), padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
            ),
            child: Text('continue_with_order_fail'.tr, textAlign: TextAlign.center, style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)),
          ),

        ]),
      )),
    );
  }
}
