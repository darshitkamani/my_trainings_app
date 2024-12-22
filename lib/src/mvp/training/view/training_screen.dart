import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_trainings_app/src/mvp/filter/provider/filter_provider.dart';
import 'package:my_trainings_app/src/mvp/filter/view/filter_bottom_sheet.dart';
import 'package:my_trainings_app/src/mvp/training/provider/training_provider.dart';
import 'package:my_trainings_app/src/mvp/training/view/highlight_view.dart';
import 'package:my_trainings_app/src/mvp/training/view/training_item_view.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';
import 'package:provider/provider.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  // ScrollController to handle scroll events and load more data
  ScrollController scrollController = ScrollController();
  DateTime? currentBackPressTime;

  @override
  void initState() {
    // Initialize the training provider and filter provider
    TrainingProvider trainingProvider = Provider.of(context, listen: false);
    FilterProvider filterProvider = Provider.of(context, listen: false);

    // Load initial data once the UI is rendered
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await trainingProvider.init(context);
    });

    // Add a scroll listener to load more data when scrolled to the end
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await trainingProvider.initializeSessionPaginatedList(
            sessions: filterProvider.filteredList);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heightOfMainContainer = 160;
    double heightOfPositionedContainer = 180;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (val, A) async {
        DateTime now = DateTime.now();

        // Check if back button pressed twice within 2 seconds
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;

          // Show a snackbar asking the user to press back again to exit
          var snackBar = SnackBar(
              backgroundColor: VariableUtilities.theme.blackColor,
              content: Text('Swipe/Press again to exit!',
                  style: FontUtilities.h16(
                      fontColor: VariableUtilities.theme.whiteColor,
                      fontWeight: FWT.semiBold)));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          await SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: VariableUtilities.theme.offWhiteColor,
        appBar: AppBar(
          title: Text(
            'Trainings', //
            style: FontUtilities.h26(
              letterSpacing: 1.5,
              fontFamily: 'Playfair Display',
              fontColor: VariableUtilities.theme.whiteColor,
              fontWeight: FWT.extraBold,
            ),
          ),
          backgroundColor: VariableUtilities.theme.primaryColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon:
                    Icon(Icons.menu, color: VariableUtilities.theme.whiteColor))
          ],
        ),
        body: Consumer(builder: (_, TrainingProvider trainingProvider, __) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                DeferredPointerHandler(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: heightOfMainContainer,
                            width: VariableUtilities.screenSize.width,
                            color: VariableUtilities.theme.primaryColor,
                          ),
                          Container(
                            height: heightOfMainContainer + 20,
                            width: VariableUtilities.screenSize.width,
                            color: VariableUtilities.theme.whiteColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20.0),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: FilterButton(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          shape: Border.all(),
                                          builder: (_) {
                                            return SingleChildScrollView(
                                                child: FilterBottomSheet(
                                                    isFromFilterView: false));
                                          });
                                    },
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: heightOfPositionedContainer,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: heightOfMainContainer,
                                width: VariableUtilities.screenSize.width,
                                color: VariableUtilities.theme.primaryColor,
                              ),
                              Positioned(
                                top: heightOfMainContainer -
                                    (heightOfPositionedContainer / 2) -
                                    50,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "Highlights",
                                    style: FontUtilities.h20(
                                      fontColor:
                                          VariableUtilities.theme.whiteColor,
                                      fontWeight: FWT.semiBold,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                left: 0,
                                top: heightOfMainContainer -
                                    (heightOfPositionedContainer / 2),
                                child: DeferPointer(
                                    child: HighlightView(
                                        highlightCourseList: trainingProvider
                                            .courseHighlightsList,
                                        height: heightOfPositionedContainer)),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                trainingProvider.paginatedSessionsList.isEmpty
                    ? Column(
                        children: [NoDataFoundView(), SizedBox(height: 30)],
                      )
                    : Padding(
                        padding: EdgeInsets.all(15),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                trainingProvider.paginatedSessionsList.length +
                                    1,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return (index ==
                                      trainingProvider
                                          .paginatedSessionsList.length)
                                  ? trainingProvider.isNextSessionLoading
                                      ? trainingProvider
                                              .paginatedSessionsList.isEmpty
                                          ? const SizedBox()
                                          : Center(
                                              child: CircularProgressIndicator(
                                              color: VariableUtilities
                                                  .theme.primaryColor,
                                            ))
                                      : const SizedBox(height: 15)
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: TrainingItemView(
                                          session: trainingProvider
                                              .paginatedSessionsList[index]),
                                    );
                            }),
                      )
              ],
            ),
          );
        }),
      ),
    );
  }
}
