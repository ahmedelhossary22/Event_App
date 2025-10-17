import 'package:event_app/core/theme/color_pallate.dart';
import 'package:event_app/core/utils/firestore_services.dart';
import 'package:event_app/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class CategoryItem extends StatelessWidget {
  final EventData eventData;

  const CategoryItem({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 190,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: ColorPallate.primaryColor),
        image: DecorationImage(
          image: AssetImage(eventData.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 46,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Color(0xFFF2FEFF),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              DateFormat('dd MMM').format(eventData.selectedDate!),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: ColorPallate.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 1.2,
                letterSpacing: 0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Color(0xFFF2FEFF),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              spacing: 20,
              children: [
                Expanded(
                  child: Text(
                    eventData.title,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,

                      height: 1.2,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Bounceable(
                  onTap: () {
                    eventData.isFavourite = !eventData.isFavourite;
                    EasyLoading.show();
                    FirestoreServices.updateEvent(eventData);
                    EasyLoading.dismiss();
                  },
                  child: Icon(
                    eventData.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: ColorPallate.primaryColor,
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
