import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home/tabs/widgets/event_item.dart';
import 'package:flutter/material.dart';

import '../../../../utils/size_utils.dart';
import '../../../widgets/custom_text_field.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

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
          Expanded(child: ListView.separated
            (itemBuilder: (context, text) {
            return EventItem();
          },
              separatorBuilder: (context, text) {
                return SizedBox(height: height * 0.02);
              },
              itemCount: 20)
          ),
        ],
      ),
    )
    );
  }
}
