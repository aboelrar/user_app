import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SocialLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      Center(child: Text('or'.tr, style: ubuntuRegular.copyWith(
          color:  Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
          fontSize: Dimensions.fontSizeSmall))),
      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

      Center(child: Text('sign_in_with'.tr, style: ubuntuRegular.copyWith(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
          fontSize: Dimensions.fontSizeSmall))),
      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [

          InkWell(
            onTap: () async {
              await Get.find<AuthController>().socialLogin();
              String id = '', token = '', email = '', medium ='';
              if(Get.find<AuthController>().googleAccount != null){
                id = Get.find<AuthController>().googleAccount!.id;
                email = Get.find<AuthController>().googleAccount!.email;
                token = Get.find<AuthController>().auth!.accessToken!;
                medium = 'google';
              }
              Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                email: email, token: token, uniqueId: id, medium: medium,
              ));

            },
            child: Container(
              height: 40, width: 40, alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE)),
              ),
              child: Image.asset(Images.google, height: 20, width: 20),
            ),
          ),
        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
        InkWell(
          onTap: () async{
            LoginResult _result = await FacebookAuth.instance.login();
            if (_result.status == LoginStatus.success) {
              Map _userData = await FacebookAuth.instance.getUserData();
              Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                email: _userData['email'], token: _result.accessToken!.token, uniqueId: _result.accessToken!.userId, medium: 'facebook',
              ));
            }
          },
          child: Container(
            height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE, width: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE, alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).shadowColor,
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE)),
            ),
            child: Image.asset(Images.facebook, height: 20, width: 20),
          ),
        ),
      ]),
    ]);
  }
}
