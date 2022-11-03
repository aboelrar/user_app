import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

  @override
  void initState() {
    Get.find<AuthController>().contactNumberController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:'forgot_password'.tr),
      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Center(child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
          ) : null,
          child: GetBuilder<AuthController>(
            builder: (authController){
              return Column(children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Image.asset(Images.forgotPass,width: 100,height: 100,),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                Row(
                  children: [
                    CodePickerWidget(
                      onChanged: (CountryCode countryCode) =>
                      authController.countryDialCode = countryCode.dialCode!,
                      initialSelection: authController.countryDialCode,
                      favorite: [authController.countryDialCode],
                      showDropDownButton: true,
                      padding: EdgeInsets.zero,
                      showFlagMain: true,
                      dialogBackgroundColor: Theme.of(context).cardColor,
                      textStyle: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                          hintText: 'enter_phone_number'.tr,
                          controller: authController.contactNumberController,
                          inputType: TextInputType.phone,
                          countryDialCode: authController.countryDialCode,
                          onCountryChanged: (CountryCode countryCode) => authController.countryDialCode = countryCode.dialCode!,
                          onValidate: (String? value){
                            return FormValidation().isValidLength(value!);
                          }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                GetBuilder<AuthController>(builder: (authController) {
                  return !authController.isLoading! ? CustomButton(
                    buttonText: 'send_otp'.tr,
                    onPressed: () => _forgetPass(),
                  ) : Center(child: CircularProgressIndicator());
                }),
              ]);
            },
          ),
        )),
      )))),
    );
  }

  void _forgetPass() async {

    if(Get.find<AuthController>().contactNumberController.value.text.isNotEmpty){
      Get.find<AuthController>().forgetPassword();
    }else{
      customSnackBar('enter_phone_number'.tr);
    }

  }
}

