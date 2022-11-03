import 'package:get/get.dart';
import 'package:demandium/feature/profile/controller/user_controller.dart';

enum PageState {orderDetails, payment, complete}

enum PaymentMethodName  {digitalPayment, COS}
class CheckOutController extends GetxController{
  PageState currentPage = PageState.orderDetails;

  var selectedPaymentMethod = PaymentMethodName.COS;
  bool showCoupon = false;
  bool cancelPayment = false;

  @override
  void onInit() {
    Get.find<UserController>().getUserInfo();
    super.onInit();
  }


  void cancelPaymentOption(){
    cancelPayment = true;
    update();
  }

  void updateState(PageState _currentPage){
    currentPage=_currentPage;
    update();
  }

  void updateDigitalPaymentOption(PaymentMethodName paymentMethodName){
    selectedPaymentMethod = paymentMethodName;
    update();
  }





}