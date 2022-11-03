import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';

class ContactUsPage extends StatelessWidget {

  ContactUsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'contact_us'.tr,),
      body: Center(
        child: FooterBaseView(
          child: WebShadowWrap(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(Images.helpAndSupport,width: 172,height: 129,)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                  contactWithEmailOrPhone('contact_us_through_email'.tr,"${'you_can_send_us_email_through'.tr}\n ${Get.find<SplashController>().configModel.content!.businessPhone.toString()}","typically_the_support_team_send_you_any_feedback".tr,context),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                  contactWithEmailOrPhone('contact_us_through_phone'.tr,'contact_us_through_our_customer_care_number'.tr,"talk_with_our_customer".tr,context),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                  //email and call section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _emailCallButton(
                        context,
                        'email'.tr,
                        Icons.email,
                        email
                      ),
                      _emailCallButton(
                        context,
                        'call'.tr,
                        Icons.call,
                        launchUri
                      ),

                    ],
                  ),
                  Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget contactWithEmailOrPhone(String title,String subTitle,String message,context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
              Text(message,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),),
            ],
          ),
        ),
      ],
    );
  }

  _emailCallButton(context,String title,IconData iconData,Uri uri){
    return ElevatedButton(
        onPressed: () async{
           await launchUrl(uri);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(color:Theme.of(context).cardColor),
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius:const BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE)))),
        child: Row(
          children: [
            Icon(iconData,color:Theme.of(context).primaryColorLight),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text(title,style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColorLight))
          ],
        ));
  }

  //dummy data willl be removed soon
  final Uri launchUri =  Uri(
    scheme: 'tel',
    path: Get.find<SplashController>().configModel.content!.businessPhone.toString(),
  );
  final Uri email =  Uri(
    scheme: 'mailto',
    path: Get.find<SplashController>().configModel.content!.businessEmail,
  );
}