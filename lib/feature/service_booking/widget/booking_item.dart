import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({Key? key, required this.img, required this.title, this.subTitle}) : super(key: key);
  final String img;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(img),
          width: Dimensions.PADDING_SIZE_DEFAULT,
          height: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        Gaps.horizontalGapOf(Dimensions.PADDING_SIZE_SMALL),
        Expanded(child: Text("$title",style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),maxLines: 2,overflow: TextOverflow.ellipsis,)),
        if(subTitle != null)
          Expanded(
            child: Text("$subTitle",
              textDirection:Get.find<LocalizationController>().isLtr  ?  TextDirection.ltr:TextDirection.rtl,
              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),maxLines: 2,overflow: TextOverflow.ellipsis,),
          ),
      ],
    );
  }
}