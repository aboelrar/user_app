import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';


class NewPassScreen extends StatefulWidget {
  final String phoneOrEmail;
  final String otp;
  const NewPassScreen({Key? key,required this.phoneOrEmail, required this.otp}) : super(key: key);

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final GlobalKey<FormState> newPassKey = GlobalKey<FormState>();


  @override
  void initState() {
    Get.find<AuthController>().newPasswordController.clear();
    Get.find<AuthController>().confirmNewPasswordController.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find<AuthController>();
    return Scaffold(
      appBar: CustomAppBar(title:'change_password'.tr, onBackPressed: (){
        Get.find<AuthController>().updateVerificationCode('');
        Get.back();
      },),
      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Center(child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
          ) : null,
          child: Form(
            key: newPassKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(children: [
                  CustomTextField(
                      title: 'new_password'.tr,
                      hintText: '**************',
                      controller: controller.newPasswordController,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      onValidate: (String? value){
                        return FormValidation().isValidPassword(value!);
                      }
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                  CustomTextField(
                    title: 'confirm_new_password'.tr,
                    hintText: '**************',
                    controller: controller.confirmNewPasswordController,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                    onValidate: (String? value){
                      return FormValidation().isValidPassword(value!);
                    },
                    onSubmit: (text) => GetPlatform.isWeb ? _resetPassword(controller.confirmNewPasswordController.text,controller.confirmNewPasswordController.text) : null,
                  ),

                ]),
              ),
              SizedBox(height: 30),

              GetBuilder<UserController>(builder: (userController) {
                return GetBuilder<AuthController>(builder: (authBuilder) {
                  if(authBuilder.isLoading! && userController.isLoading){
                    return  Center(child: CircularProgressIndicator());
                  }else{
                    return CustomButton(
                      buttonText: 'change_password'.tr,
                      onPressed: () {
                        if(isRedundentClick(DateTime.now())){
                          return;
                        }
                        else{
                          _resetPassword(
                              controller.newPasswordController.value.text,
                              controller.confirmNewPasswordController.value.text);
                        }
                      },
                    );
                  }
                });
              }),

            ]),
          ),
        )),
      )))),
    );
  }

  void _resetPassword(newPassword, confirmNewPassword) {
    if(newPassKey.currentState!.validate()){
      print("$newPassword $confirmNewPassword");
      if(newPassword != confirmNewPassword){
        customSnackBar('password_not_matched'.tr);
      }else{
        Get.find<AuthController>().resetPassword(widget.phoneOrEmail);
      }
    }
  }
}




