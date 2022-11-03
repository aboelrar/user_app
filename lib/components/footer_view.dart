import 'package:get/get.dart';
import 'package:demandium/components/text_hover.dart';
import 'package:demandium/core/core_export.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    TextEditingController _newsLetterController = TextEditingController();
    Color _color = Theme.of(context).primaryColorLight;
    return Container(
      color: Theme.of(context).primaryColorDark,
      width: double.maxFinite,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE ),
                          FittedBox(
                            child: Text(Get.find<SplashController>().configModel.content!.businessName!, maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.w800,fontSize: 48,color: Theme.of(context).primaryColor),),
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          Text('news_letter'.tr, style: ubuntuRegular.copyWith(fontWeight: FontWeight.w600, color: _color)),
                          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Text('subscribe_to_our'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: _color)),
                          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          Container(
                            width: 400,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).primaryColor,
                                    blurRadius: 2,
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                Expanded(child: TextField(
                                  controller: _newsLetterController,
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColor),
                                  decoration: InputDecoration(
                                    hintText: 'your_email_address'.tr,
                                    hintStyle: ubuntuRegular.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeDefault),
                                    border: InputBorder.none,
                                  ),
                                  maxLines: 1,

                                )),
                                InkWell(
                                  onTap: (){
                                    String email = _newsLetterController.text.trim().toString();
                                    if (email.isEmpty) {
                                      customSnackBar('enter_email_address'.tr);
                                    }else if (GetUtils.isEmail(email)) {
                                      customSnackBar('enter_valid_email'.tr);
                                    }else{
                                      // Provider.of<NewsLetterProvider>(context, listen: false).addToNewsLetter(context, email).then((value) {
                                      //   _newsLetterController.clear();
                                      // });
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    child: Text('subscribe'.tr, style: ubuntuRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeDefault)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          GetBuilder<SplashController>(
                              builder: (splashController){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('follow_us_on'.tr, style: ubuntuRegular.copyWith(color: _color,fontSize: Dimensions.fontSizeDefault)),
                                    Container(height: 50,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: 2,
                                        itemBuilder: (BuildContext context, index){
                                          String name = 'facebook';
                                          String? icon;
                                          if(name=='facebook'){
                                            icon = Images.facebookIcon;
                                          }else if(name=='linkedin'){
                                            icon = Images.linkedinIcon;
                                          } else if(name=='youtube'){
                                            icon = Images.youtubeIcon;
                                          }else if(name=='twitter'){
                                            icon = Images.twitterIcon;
                                          }else if(name=='instagram'){
                                            icon = Images.instagramIcon;
                                          }else if(name=='pinterest'){
                                            icon = Images.pinterestIcon;
                                          }
                                          return 1 > 0 ?
                                          InkWell(
                                            onTap: (){
                                              _launchURL("splashProvider.configModel.socialMediaLink[index].link");
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Image.asset(icon!,height: Dimensions.PADDING_SIZE_EXTRA_LARGE,width: Dimensions.PADDING_SIZE_EXTRA_LARGE,fit: BoxFit.contain),
                                            ),
                                          ):SizedBox();

                                        },),
                                    ),
                                  ],
                                );
                              })

                        ],
                      )),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.PADDING_SIZE_LARGE * 2),
                        Text( 'download_our_app'.tr, style: ubuntuRegular.copyWith(color: _color,fontSize: Dimensions.fontSizeExtraLarge)),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Text( 'download_our_app_from_google_play_store'.tr, style: ubuntuBold.copyWith(color: _color,fontSize: Dimensions.fontSizeExtraSmall)),
                        const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(onTap:(){
                              _launchURL(Get.find<SplashController>().configModel.content!.appUrlAndroid!);
                            },child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(Images.playStoreIcon,height: 50,fit: BoxFit.contain),
                            )),
                            InkWell(onTap:(){
                              _launchURL(Get.find<SplashController>().configModel.content!.appUrlIos!);
                            },child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(Images.appStoreIcon,height: 50,fit: BoxFit.contain),
                            )),
                          ],)
                      ],
                    ),
                  ),
                  Expanded(flex: 2,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.PADDING_SIZE_LARGE * 2),
                      Text('useful_link'.tr, style: ubuntuRegular.copyWith(color: _color,fontSize: Dimensions.fontSizeExtraLarge)),
                      const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      FooterButton(title: 'privacy_policy'.tr, route: RouteHelper.getProfileRoute()),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'terms_and_conditions'.tr, route: RouteHelper.getAddressRoute("others")),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'about_us'.tr, route: RouteHelper.getAddressRoute("others")),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'contact'.tr, route: RouteHelper.getAddressRoute("others")),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'become_a_provider'.tr, route: RouteHelper.getAddressRoute("others")),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                    ],)),
                  Expanded(flex: 2,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.PADDING_SIZE_LARGE * 2),
                      Text('quick_links'.tr, style: ubuntuRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeExtraLarge)),
                      const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      FooterButton(title: 'contact_us'.tr, route: RouteHelper.getSupportRoute()),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'current_offers'.tr, route: RouteHelper.getSupportRoute()),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'trending_services'.tr, route: RouteHelper.getSupportRoute()),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'popular_services'.tr, route: RouteHelper.getSupportRoute()),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'categories'.tr, route: RouteHelper.getSupportRoute()),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    ],)),
                ],
              ),
            ),
            Divider(thickness: .5),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

            Container(
                width: double.maxFinite,

                color:Color(0xff253036),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: Center(child: Text('copy_right'.tr,style: ubuntuRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeDefault),)),
                )),
          ],
        ),
      ),
    );
  }
}
_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

class FooterButton extends StatelessWidget {
  final String title;
  final String route;
  final bool url;
  const FooterButton({required this.title, required this.route, this.url = false});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        hoverColor: Colors.transparent,
        onTap: route.isNotEmpty ? () async {
          if(url) {
            if(await canLaunchUrlString(route)) {
              launchUrlString(route, mode: LaunchMode.externalApplication);
            }
          }else {
            Get.toNamed(route);
          }
        } : null,
        child: Text(title, style: hovered ? ubuntuMedium.copyWith(color: Theme.of(context).errorColor, fontSize: Dimensions.fontSizeSmall)
            : ubuntuRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraSmall)),
      );
    });
  }
}