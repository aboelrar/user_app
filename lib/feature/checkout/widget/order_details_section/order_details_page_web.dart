import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class OrderDetailsPageWeb extends StatelessWidget {
  const OrderDetailsPageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: Column(
          children: [
            SizedBox(height: Dimensions.PADDING_FOR_CHATTING_BUTTON,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
              flex: 2,
              child: Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ServiceSchedule(),
                      ServiceInformation(),
                      GetBuilder<CheckOutController>(
                        builder: (controller) {
                          return controller.showCoupon == false
                              ? const ApplyVoucher()
                              : const ShowVoucher();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 150,),
            Expanded(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(
                    boxShadow: cardShadow,
                    color: Theme.of(context).cardColor,
                  ),
                  child: CartSummery()),
            ),
            ],
            ),
            SizedBox(height: Dimensions.PADDING_FOR_CHATTING_BUTTON,),
          ],
        ),
      ),
    );
  }
}
