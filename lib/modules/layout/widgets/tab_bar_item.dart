import 'package:event_app/core/theme/color_pallate.dart';
import 'package:event_app/models/category_data.dart';
import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  final bool isSelected;
  final CategoryData categoryData;

  const TabBarItem({
    super.key,
    required this.categoryData,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : ColorPallate.primaryColor,
        borderRadius: BorderRadius.circular(45.0),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(categoryData.icn),
            color: isSelected ? ColorPallate.primaryColor : Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            categoryData.name,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isSelected ? ColorPallate.primaryColor : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
