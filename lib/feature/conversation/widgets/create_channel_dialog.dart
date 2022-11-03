import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class CreateChannelDialog extends StatefulWidget {
  final String? referenceId;
  final String? customerID;
  final String? serviceManId;
  final String? providerId;

  CreateChannelDialog(
      {
        this.referenceId,
        this.customerID,
        this.serviceManId,
        this.providerId,
      });

  @override
  State<CreateChannelDialog> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<CreateChannelDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookingDetailsContent bookingDetailsContent = Get.find<BookingDetailsTabsController>().bookingDetailsContent;
    String imageBaseUrl = Get.find<SplashController>().configModel.content!.imageBaseUrl!;

    return PointerInterceptor(
      child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        padding: EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            bottom: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: GetBuilder<ConversationController>(
            initState: (state){
              Get.find<ConversationController>().getChannelListBasedOnReferenceId(1,widget.referenceId!);
            },
            builder: (conversationController) {
          return SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () => Get.back(),
                      child: Padding(
                        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT,
                            right: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Icon(Icons.close),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                      top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('create_channel_with_provider'.tr,style: ubuntuMedium,),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if(widget.providerId != null)
                                  TextButton(
                                  onPressed:(){
                                    String name = "${bookingDetailsContent.provider!.companyName!}";
                                    String image = "$imageBaseUrl/provider/logo/${bookingDetailsContent.provider!.logo!}";
                                    Get.find<ConversationController>().createChannel(widget.providerId!, widget.referenceId!,name: name,image: image);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  Size(Dimensions.PADDING_SIZE_LARGE, 40),
                                    padding:  EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_LARGE ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
                                  ),
                                  child: Text('provider'.tr, textAlign: TextAlign.center, style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),),
                                ),
                                const SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                                if(widget.serviceManId != null)
                                TextButton(
                                  onPressed:(){
                                    String name = "${bookingDetailsContent.serviceman!.user!.firstName!}"
                                        " ${bookingDetailsContent.serviceman!.user!.lastName!}";
                                    String image = "$imageBaseUrl/serviceman/profile/${bookingDetailsContent.serviceman!.user!.profileImage!}";
                                    Get.find<ConversationController>().createChannel(widget.serviceManId!, widget.referenceId!,name: name,image: image);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  Size(Dimensions.PADDING_SIZE_LARGE, 40),
                                    padding:  EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_LARGE ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
                                  ),
                                  child: Text(
                                    'service_man'.tr, textAlign: TextAlign.center,
                                    style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
                                  ),
                                ),
                              ]),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        ]),
                  ),
                ]),
          );
        }),
      ),
    );
  }
}
