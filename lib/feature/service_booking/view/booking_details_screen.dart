import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String bookingID;
  final String fromPage;

  const BookingDetailsScreen({Key? key, required this.bookingID, required this.fromPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(fromPage == 'fromNotification') {
          Get.offAllNamed(RouteHelper.getInitialRoute());
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
          appBar: CustomAppBar(
            title: "booking_details".tr,
            centerTitle: true,
            isBackButtonExist: true,
            onBackPressed: (){
              if(fromPage == 'fromNotification'){
                Get.offAllNamed(RouteHelper.getInitialRoute());
              }else{
                Get.back();
              }
            },
          ),
          body: FooterBaseView(
            isCenter: false,
            isScrollView: ResponsiveHelper.isMobile(context) ? false : true,

            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: RefreshIndicator(
                onRefresh: () async {
                  Get.find<BookingDetailsTabsController>()
                      .getBookingDetails(bookingId: bookingID);
                },
                child: WebShadowWrap(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        BookingTabBar(),
                        if(!ResponsiveHelper.isMobile(context))
                          GetBuilder<BookingDetailsTabsController>(
                              initState: (state) {
                                Get.find<BookingDetailsTabsController>().getBookingDetails(bookingId: bookingID);},
                              builder: (bookingDetailsTabController) {
                            return bookingDetailsTabController.selectedBookingStatus == BookingDetailsTabs.BookingDetails
                                ? BookingDetailsSection(bookingID: bookingID)
                                : BookingHistory(bookingDetailsContent: bookingDetailsTabController.bookingDetailsContent);
                          }),
                        if (ResponsiveHelper.isMobile(context))
                          GetBuilder<BookingDetailsTabsController>(
                            initState: (state){
                              Get.find<BookingDetailsTabsController>().getBookingDetails(bookingId: bookingID);
                            },
                            builder: (bookingDetailsTabController){
                              return Expanded(
                                child: TabBarView(
                                    controller: Get.find<BookingDetailsTabsController>().detailsTabController,
                                    children: [
                                      BookingDetailsSection(bookingID: bookingID),
                                      BookingHistory(bookingDetailsContent: Get.find<BookingDetailsTabsController>().bookingDetailsContent),
                                    ]),
                              );
                            }
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.message_rounded,
                  color: Theme.of(context).primaryColorLight),
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                BookingDetailsContent bookingDetailsContent =
                    Get.find<BookingDetailsTabsController>()
                        .bookingDetailsContent;

                if (bookingDetailsContent.provider != null ||
                    bookingDetailsContent.provider != null) {
                  Get.bottomSheet(CreateChannelDialog(
                    customerID: bookingDetailsContent.customerId,
                    providerId: bookingDetailsContent.provider != null
                        ? bookingDetailsContent.provider!.userId!
                        : null,
                    serviceManId: bookingDetailsContent.serviceman != null
                        ? bookingDetailsContent.serviceman!.userId!
                        : null,
                    referenceId: bookingDetailsContent.readableId.toString(),
                  ));
                } else {
                  Fluttertoast.showToast(
                      msg: 'provider_or_service_man_assigned'.tr,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              })),
    );
  }
}

class BookingTabBar extends StatelessWidget {
  const BookingTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsTabsController>(
      builder: (bookingDetailsTabsController) {
        return Container(
          height: 45,
          width: Dimensions.WEB_MAX_WIDTH,
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
              border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).primaryColor, width: 0.5),
              ),
            ),
            child: Center(
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Get.isDarkMode
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                controller: bookingDetailsTabsController.detailsTabController,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: bookingDetailsTabsController.bookingDetails,
                onTap: (int? index) {
                  switch (index) {
                    case 0:
                      bookingDetailsTabsController.updateBookingStatusTabs(
                          BookingDetailsTabs.BookingDetails);
                      break;
                    case 1:
                      bookingDetailsTabsController
                          .updateBookingStatusTabs(BookingDetailsTabs.Status);
                      break;
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
