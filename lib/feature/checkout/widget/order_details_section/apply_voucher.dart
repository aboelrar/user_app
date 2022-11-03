import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ApplyVoucher extends StatelessWidget {
  const ApplyVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6).withOpacity(.3), width: 1)),
      child: Center(
        child: GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getVoucherRoute());
          },
          child: Row(
            children: [
              const SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
              Image.asset(Images.couponLogo),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text('apply_a_voucher'.tr,style: ubuntuMedium.copyWith(color:Get.isDarkMode? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6):Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
