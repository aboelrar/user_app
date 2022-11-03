import 'package:get/get.dart';
import 'package:demandium/feature/checkout/controller/checkout_controller.dart';
import 'package:demandium/feature/checkout/controller/schedule_controller.dart';

class CheckoutBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => CheckOutController());
    Get.lazyPut(() => ScheduleController());
  }

}