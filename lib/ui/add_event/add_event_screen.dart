import 'package:evently/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/add_event/widgets/custom_date_time_widget.dart';
import 'package:evently/ui/home/tabs/widgets/tab_item.dart';
import 'package:evently/ui/widgets/custom_elevated_button.dart';
import 'package:evently/ui/widgets/custom_text_field.dart';
import 'package:evently/utils/TOAST_UTILS.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<String> eventImagesDarkList = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  List<String> eventImagesLightList = [
    AppAssets.sportLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.bookClubLight,
    AppAssets.exhibitionLight,
  ];

  List<String> eventNamesList = [];

  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime? selectedDate;
  String formatDate = '';
  TimeOfDay? selectedTime;
  String formatTime = '';
  String selectedEventName = '';
  String selectedEventImage = '';

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = context.height;
    var width = context.width;
    eventNamesList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
    ];
    selectedEventName = eventNamesList[selectedIndex];
    selectedEventImage = themeProvider.isDarkMode(context)
        ? eventImagesDarkList[selectedIndex]
        : eventImagesLightList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addEvent,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.01,
          ),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).highlightColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: themeProvider.isDarkMode(context)
                  ? AppColors.white
                  : AppColors.mainColorLight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: Form(
            key: formKey,
            child: Column(
              spacing: height * 0.01,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                    image: DecorationImage(
                      image: AssetImage(selectedEventImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: TabItem(
                          isSelected: selectedIndex == index,
                          eventName: eventNamesList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * 0.02);
                    },
                    itemCount: eventNamesList.length,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.eventTitle,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (text) {
                    title = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emptyField;
                    }
                    return null;
                  },
                ),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.eventDescription,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  maxLines: 3,
                  onChanged: (text) {
                    description = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emptyField;
                    }
                    return null;
                  },
                ),
                CustomDateTimeWidget(
                  icon: Icon(
                    Icons.date_range_outlined,
                    size: 25,
                    color: Theme.of(context).cardColor,
                  ),
                  eventDateOrTime: AppLocalizations.of(context)!.eventDate,
                  onPressed: chooseDate,
                  chooseDateOrTime: selectedDate == null
                      ? AppLocalizations.of(context)!.chooseDate
                      : formatDate,
                ),
                CustomDateTimeWidget(
                  icon: Icon(
                    Icons.timer_outlined,
                    size: 25,
                    color: Theme.of(context).cardColor,
                  ),
                  eventDateOrTime: AppLocalizations.of(context)!.eventTime,
                  onPressed: chooseTime,
                  chooseDateOrTime: selectedTime == null
                      ? AppLocalizations.of(context)!.chooseTime
                      : formatTime,
                ),
                CustomElevatedButton(
                  onPressed: addEvent,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.addEvent,
                      style: AppStyles.medium20White,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    if (selectedDate != null) {
      formatDate = DateFormat('dd/mm/yyyy').format(selectedDate!);
    }
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    if (selectedTime != null) {
      formatTime = selectedTime!.format(context);
    }
    setState(() {});
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      Event event = Event(
          eventTypeIndex: selectedIndex,
          eventName: selectedEventName,
          eventCategoryIndex: selectedIndex + 1,
          eventTitle: title,
          eventDescription: description,
          eventDate: DateTime(
              selectedDate!.year, selectedDate!.month, selectedDate!.day,
              selectedTime!.hour, selectedTime!.minute)
      );
      FirebaseUtils.addEventToFireStore(event).then((value) {
        ToastUtils.toastMsg(
              msg: AppLocalizations.of(context)!.added,
              backgroundColor: Theme.of(context).cardColor,
              textColor: AppColors.white,
            gravity: ToastGravity.BOTTOM);
        Navigator.pop(context);
      },)
          .catchError((error) {
        ToastUtils.toastMsg(
          msg: error.toString(),
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          gravity: ToastGravity.BOTTOM,
        );
      },
      )
      ;
    }
  }
}
