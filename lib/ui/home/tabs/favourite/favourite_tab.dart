import 'package:evently/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:flutter/material.dart';

import '../../../../utils/size_utils.dart';
import '../../../widgets/custom_text_field.dart';
import '../widgets/event_item.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  Stream<List<Event>>? favouriteStream;
  List<Event> favouriteEventsList = [];
  int selectedIndex = 0;

  @override
  void initState() {
    favouriteStream = FirebaseUtils.getAllFavEvents();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return SafeArea(child:
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Column(
        spacing: height * 0.02,
        children: [
          CustomTextField(
            borderColor: Theme
                .of(context)
                .dividerColor,
            hintText: AppLocalizations.of(context)!.searchForEvent,
            hintStyle: Theme
                .of(context)
                .textTheme
                .titleSmall,
            style: Theme
                .of(context)
                .textTheme
                .titleSmall,
            suffixIcon: Icon(Icons.search, size: 25, color: Theme
                .of(context)
                .cardColor,),
          ),
          Expanded(
            child: StreamBuilder<List<Event>>(
              stream: favouriteStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(
                    backgroundColor: Theme
                        .of(context)
                        .cardColor,
                  ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,),);
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(AppLocalizations.of(context)!
                      .noEvents,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,),);
                } else {
                  favouriteEventsList = snapshot.data!;
                  if (selectedIndex != 0) {
                    favouriteEventsList =
                        favouriteEventsList.where((Event event) {
                          return event.eventCategoryIndex == selectedIndex;
                        }).toList();
                  }
                  favouriteEventsList.sort((event1, event2) {
                    return event1.eventDate.compareTo(event2.eventDate);
                  });

                  return favouriteEventsList.isEmpty ?
                  Center(child: Text(AppLocalizations.of(context)!.noEvents,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,))
                      :
                  ListView.separated
                    (itemBuilder: (context, index) {
                    return EventItem(event: favouriteEventsList[index],);
                  },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: height * 0.02);
                      },
                      itemCount: favouriteEventsList.length
                  );
                }
              },
            ),
          ),
        ],
      ),
    )
    );
  }
}