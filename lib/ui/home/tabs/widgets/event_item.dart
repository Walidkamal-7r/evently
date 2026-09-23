import 'package:evently/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/TOAST_UTILS.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  final Event event;

  const EventItem({super.key, required this.event});

  static const List<String> darkImages = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  static const List<String> lightImages = [
    AppAssets.sportLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.bookClubLight,
    AppAssets.exhibitionLight,
  ];

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    String eventImage = themeProvider.isDarkMode(context)
        ? EventItem.darkImages[widget.event.eventTypeIndex]
        : EventItem.lightImages[widget.event.eventTypeIndex];

    return Container(
      height: height * 0.25,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: Theme.of(context).dividerColor),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(eventImage),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.005,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Text(
              DateFormat('dd MMM').format(widget.event.eventDate).toString(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.event.eventTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseUtils.updateIsFavourite(widget.event)
                        .then((value) {
                      if (!context.mounted) return;
                      ToastUtils.toastMsg(
                        msg: AppLocalizations.of(context)!.addedFav,
                        backgroundColor: Theme
                            .of(context)
                            .cardColor,
                        textColor: AppColors.white,
                        gravity: ToastGravity.BOTTOM,
                      );
                    })
                        .catchError((error) {
                      if (!context.mounted) return;
                      ToastUtils.toastMsg(
                        msg: error.toString(),
                        backgroundColor: AppColors.red,
                        textColor: AppColors.white,
                        gravity: ToastGravity.BOTTOM,
                      );
                    });
                  },
                  icon: Icon(widget.event.isFavourite ?
                  Icons.favorite
                      :
                  Icons.favorite_outline_outlined,
                    size: 25,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
