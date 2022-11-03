import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class AddressLabelWidget extends StatelessWidget {
  const AddressLabelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController){
        return Column(
          children: [
            Text(
              'label_as'.tr,
              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AddressLabel.values.map((label) => InkWell(
                onTap: () {
                  locationController.updateAddressLabel(addressLabel: label);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                  margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    border: Border.all(color: label == locationController.selectedAddressLabel ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Theme.of(context).cardColor,
                    boxShadow: cardShadow,
                  ),
                  child: Row(children: [
                    Icon(
                      label.index  == 0 ? Icons.home_filled : label.index == 1 ? Icons.work : Icons.location_on,
                      color: label == locationController.selectedAddressLabel ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text(
                      label.name.tr,
                      style: ubuntuRegular.copyWith(color: label == locationController.selectedAddressLabel ? Theme.of(context).textTheme.bodyText1!.color : Theme.of(context).disabledColor),
                    ),
                  ]),
                ),
              )).toList(),
            ),
          ],
        );
      },
    );
  }
}
