import 'dart:convert';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:universal_html/html.dart' as html;

class DigitalPayment extends StatelessWidget {
  final String paymentGateway;

  DigitalPayment({Key? key, required this.paymentGateway})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String _url = '';
        String _schedule = DateConverter.dateToDateAndTime(Get.find<ScheduleController>().selectedData);
        String _userId = base64Url.encode(utf8.encode(Get.find<UserController>().userInfoModel.id!));

        AddressModel? _addressModel = Get.find<LocationController>().selectedAddress;
        if (_addressModel != null) {
          _url = '${AppConstants.BASE_URL}/payment/${paymentGateway.replaceAll('_', '-')}/pay?access_token=$_userId&zone_id=${
              Get.find<LocationController>().getUserAddress()!.zoneId}&service_schedule=$_schedule&service_address_id=${_addressModel.id}';

          _url = '$_url&&callback=${RouteHelper.orderSuccess}?status=';
        }

        if (GetPlatform.isWeb) {
          String hostname = html.window.location.hostname!;
          String protocol = html.window.location.protocol;
          String port = html.window.location.port;

          _url = '$_url&&callback=$protocol//$hostname:$port${RouteHelper.orderSuccess}?status=';
          html.window.open(_url, "_self");

        } else {
          Get.to(()=> PaymentScreen(url: _url));
        }
      },
      child: Card(
        color: Theme.of(context).primaryColorLight,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Image.asset(paymentImage[paymentGateway]),
        ),
      ),
    );
  }
}
