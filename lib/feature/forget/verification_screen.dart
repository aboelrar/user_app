import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class VerificationScreen extends StatefulWidget {
  final String? number;
  VerificationScreen({@required this.number});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? _number;
  Timer? _timer;
  int? _seconds = 0;

  @override
  void initState() {
    super.initState();
    _number = widget.number;
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = _seconds! - 1;
      if(_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'otp_verification'.tr),
      body: SafeArea(child: Scrollbar(child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) ,
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
          ) : null,
          child: GetBuilder<AuthController>(builder: (authController) {
            return Column(children: [
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),

              Image.asset(
                Images.logo,
                width: Dimensions.LOGO_SIZE,
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "${'enter_the_verification_code'.tr }",
                  style: ubuntuMedium.copyWith(
                      height: 1.5,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                      fontSize: Dimensions.fontSizeDefault),
                  children: [
                    TextSpan(
                      text: "${_number!.substring(1,_number!.length-1)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: PinCodeTextField(
                  length: 4,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 60,
                    fieldWidth: 60,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Theme.of(context).disabledColor.withOpacity(0.2),
                    inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    activeColor: Theme.of(context).primaryColor.withOpacity(0.4),
                    activeFillColor: Theme.of(context).disabledColor.withOpacity(0.2),
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: authController.updateVerificationCode,
                  beforeTextPaste: (text) => true,
                ),
              ),
              authController.verificationCode.length == 4 ? !authController.isLoading! ? CustomButton(
                buttonText: 'verify'.tr,
                onPressed: () {
                  if(isRedundentClick(DateTime.now())){
                    return;
                  }
                  authController.verifyToken(_number!);
                },
              ) : Center(child: CircularProgressIndicator()) : SizedBox.shrink(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('did_not_receive_the_code'.tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),),
                    TextButton(
                      onPressed: (){
                        Get.find<AuthController>().forgetPassword();
                      },
                      child: Text('resend_it'.tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),),),
                  ]) ,
            ]);
          }),
        ),
      ))),
    );
  }
}
