import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/auth/widgets/social_login_widget.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
   SignInScreen({Key? key,required this.exitFromApp}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

   bool _canExit = GetPlatform.isWeb ? true : false;

  final GlobalKey<FormState> customerSignInKey = GlobalKey<FormState>();

  @override
  void initState() {
    requestFocus();
    super.initState();
  }

  requestFocus() async{
    Timer(Duration(seconds: 1), () {
      _phoneFocus.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr, style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        }else {
          return true;
        }
      },
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : !widget.exitFromApp ? AppBar( elevation: 0, backgroundColor: Colors.transparent) : null,
        body: SafeArea(child: Center(
          child: FooterBaseView(
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: Center(
                  child: Container(
                    width: context.width > 700 ? 700 : context.width,
                    padding: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
                    decoration: context.width > 700 ? BoxDecoration(
                      color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
                    ) : null,
                    child: GetBuilder<AuthController>(
                        initState:(state){
                          Get.find<AuthController>().fetchUserNamePassword();
                        },
                        builder: (authController) {

                      return Form(
                        key: customerSignInKey,
                        child: Column(children: [
                          Image.asset(
                            Images.logo,
                            width: Dimensions.LOGO_SIZE,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE),

                          CustomTextField(
                            title: 'email_phone'.tr,
                            hintText: 'enter_email_or_phone'.tr,
                            controller: authController.signInPhoneController,
                            focusNode: _phoneFocus,
                            nextFocus: _passwordFocus,
                            capitalization: TextCapitalization.words,
                            onCountryChanged: (CountryCode countryCode) =>
                            authController.countryDialCodeForSignIn = countryCode.dialCode!,
                            onValidate: (String? value){
                              return (GetUtils.isPhoneNumber(value!) || GetUtils.isEmail(value)) ? null : 'enter_email_or_phone'.tr;
                            },
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          CustomTextField(
                            title: 'password'.tr,
                            hintText: '************'.tr,
                            controller: authController.signInPasswordController,
                            focusNode: _passwordFocus,
                            inputType: TextInputType.visiblePassword,
                            isPassword: true,
                            inputAction: TextInputAction.done,
                            onValidate: (String? value){
                              return FormValidation().isValidPassword(value!);
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  onTap: () => authController.toggleRememberMe(),
                                  title: Row(
                                    children: [
                                      SizedBox(
                                        width: 20.0,
                                        child: Checkbox(
                                          activeColor: Theme.of(context).primaryColor,
                                          value: authController.isActiveRememberMe,
                                          onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                      Text(
                                        'remember_me'.tr,
                                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  horizontalTitleGap: 0,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Get.toNamed(RouteHelper.getForgotPassRoute()),
                                  child: Text('${'forgot_password'.tr}', style: ubuntuRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.tertiary,
                                  )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          !authController.isLoading! ? CustomButton(
                            buttonText: 'sign_in'.tr,
                            onPressed:  ()  {
                              if(customerSignInKey.currentState!.validate()) {
                                _login(authController);
                              }
                            },
                          ):
                          Center(child: CircularProgressIndicator()),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          SocialLoginWidget(),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${'do_not_have_an_account'.tr} ',
                                style: ubuntuRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                ),
                              ),

                              TextButton(
                                onPressed: (){
                                  authController.signInPhoneController.clear();
                                  authController.signInPasswordController.clear();
                                  Get.toNamed(RouteHelper.getSignUpRoute());
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50,30),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                                ),
                                child: Text('sign_up_here'.tr, style: ubuntuRegular.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: Dimensions.fontSizeSmall,
                                )),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'continue_as'.tr,
                                style: ubuntuMedium.copyWith(color:Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50,30),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: (){
                                Get.find<CartController>().getCartData();
                                Get.offNamed(RouteHelper.getInitialRoute());
                              }, child:  Text(
                                'guest'.tr,
                                style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.primary),
                              ),)

                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),

                        ]),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  void _login(AuthController authController) async {
    authController.login();
  }
}
