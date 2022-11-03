import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class LanguageScreen extends StatelessWidget {
  final String fromPage;

  const LanguageScreen({Key? key, required this.fromPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    final List<MenuModel> _menuList = [
      MenuModel(icon: Images.profile, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.customerCare, title: 'help_&_support'.tr, route: RouteHelper.getSupportRoute()),
    ];
    _menuList.add(MenuModel(icon: Images.logout, title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: ''));

    return Scaffold(
      appBar:fromPage == "fromSettingsPage" ? CustomAppBar(title: "language".tr) : null,
      body: GetBuilder<LocalizationController>(
        builder: (localizationController){
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        width: Dimensions.WEB_MAX_WIDTH,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                          if(fromPage != "fromSettingsPage")
                            Image.asset(
                              Images.logo,
                              width: Dimensions.LOGO_SIZE,
                            ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE),
                          Align(
                              alignment:Get.find<LocalizationController>().isLtr ?  Alignment.centerLeft : Alignment.centerRight,
                              child: Text('select_language'.tr,style: ubuntuMedium,)),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                          GridView.builder(
                            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_RADIUS),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 3 : 2,
                              childAspectRatio: (1/1),
                            ),
                            itemCount: localizationController.languages.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => LanguageWidget(
                              languageModel: localizationController.languages[index],
                              localizationController: localizationController, index: index,
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Align(
                              alignment:Get.find<LocalizationController>().isLtr ?  Alignment.centerLeft : Alignment.centerRight,
                              child: Text('you_can_change_language'.tr,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5)),)),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
              if(fromPage != "fromSettingsPage")

                CustomButton(
                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  onPressed: (){
                    Get.find<SplashController>().saveSplashSeenValue(true);
                    localizationController.setLanguage(Locale(
                      AppConstants.languages[localizationController.selectedIndex].languageCode!,
                      AppConstants.languages[localizationController.selectedIndex].countryCode,
                    ));
                    if(fromPage != 'fromSettingsPage'){
                      Get.offNamed(RouteHelper.onBoardScreen);
                    }
                  },
                  buttonText: 'save'.tr),
              SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.PADDING_SIZE_DEFAULT : 0),
            ],
          );
        },
      ),
    );
  }
}
