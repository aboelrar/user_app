import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SearchWidgetWeb extends GetView<SearchController> {
  const SearchWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
        padding: const EdgeInsets.only(top:Dimensions.PADDING_SIZE_EXTRA_SMALL,left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT),
        child: Container(
            height: Dimensions.SEARCH_BER_SIZE,
            width: 350,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.horizontal(right: Radius.circular(25,),left: Radius.circular(25)),
              boxShadow:Get.isDarkMode? null: searchBoxShadow,
            ),
            child:
            TypeAheadField(
              getImmediateSuggestions: true,
              textFieldConfiguration: TextFieldConfiguration(
                controller: controller.searchController,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color, fontSize: Dimensions.fontSizeLarge,
                ),

                cursorColor: Theme.of(context).hintColor,
                autofocus: false,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(25,),left: Radius.circular(25)),
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                  ),
                  fillColor: Get.isDarkMode? Theme.of(context).primaryColorDark:Color(0xffFEFEFE),
                  isDense: true,
                  hintText: 'search_services'.tr,
                  hintStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                  filled: true,
                  prefixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
                  suffixIcon:  IconButton(
                    onPressed: () {
                      if(controller.searchController.text.trim().isNotEmpty) {
                        controller.navigateToSearchResultScreen();
                      }
                      FocusScope.of(context).unfocus();
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              hideSuggestionsOnKeyboardHide: true,
              suggestionsCallback: (pattern) async {
                Completer<List<String>> completer = new Completer();
                completer.complete(controller.filterHistory(pattern, controller.historyList));
                return completer.future;
              },

              itemBuilder: (context,String suggestion){
                return ListTile(
                  leading: Icon(Icons.history),
                  title: Text(suggestion),
                );
              },

              onSuggestionSelected: (String suggestion){
                controller.navigateToSearchResultScreen();
                controller.searchData(suggestion);
              },
              noItemsFoundBuilder: (value) {
                return SizedBox();
              },
            )
        )));
  }
}
