import 'package:get/get.dart';
import 'package:demandium/feature/profile/controller/edit_profile_tab_controller.dart';
import 'package:demandium/core/core_export.dart';

class EditProfileAccountInfo extends StatefulWidget {
  EditProfileAccountInfo({Key? key}) : super(key: key);

  @override
  State<EditProfileAccountInfo> createState() => _EditProfileAccountInfoState();
}

class _EditProfileAccountInfoState extends State<EditProfileAccountInfo> {
  final FocusNode _passwordFocus = FocusNode();

  final FocusNode _confirmPasswordFocus = FocusNode();

  final GlobalKey<FormState> accountInfoKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: accountInfoKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                    title: 'password'.tr,
                    hintText: '**************',
                    controller: Get.find<EditProfileTabController>().passwordController,
                    focusNode: _passwordFocus,
                    nextFocus: _confirmPasswordFocus,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                    onValidate: (String? value){
                      return  Get.find<EditProfileTabController>().validatePassword(value!);
                    }
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                    title: 'confirm_password'.tr,
                    hintText: '**************',
                    controller: Get.find<EditProfileTabController>().confirmPasswordController,
                    focusNode: _confirmPasswordFocus,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                    onValidate: (String? value){
                      return Get.find<EditProfileTabController>().validatePassword(value!);
                    }
                ),
                SizedBox(height: context.height*0.16,),
                CustomButton(buttonText: 'change_password'.tr,onPressed: (){
                  if(accountInfoKey.currentState!.validate()){
                    Get.find<EditProfileTabController>().updateAccountInfo();
                  }},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customRichText(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(text: title, style: ubuntuRegular.copyWith(color: const Color(0xff2C3439))),
        TextSpan(text: ' *', style: ubuntuRegular.copyWith(color: Colors.red)),
      ])),
    );
  }
}