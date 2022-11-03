import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/voucher/controller/coupon_controller.dart';

class ShowVoucher extends StatelessWidget {
  const ShowVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
      builder: (couponController){
        return couponController.coupon != null ? Card(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(Images.couponIcon,width: 20.0,height: 20.0,),
                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                      Text("${couponController.coupon!.couponCode! }", style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                      Text("applied".tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),),),

                    ],
                  ),

                  TextButton(onPressed: (){
                    Get.toNamed(RouteHelper.getVoucherRoute());
                  }, child: Text('edit'.tr, style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColor),),)




                ],
              ),
            ),
          ),
        ): ApplyVoucher();
      }
    );
  }
}
