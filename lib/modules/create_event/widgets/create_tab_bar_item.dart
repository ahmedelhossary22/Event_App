import 'package:event_app/core/theme/color_pallate.dart';
import 'package:event_app/models/category_data.dart';
import 'package:flutter/material.dart';

class CreateTabBarItem extends StatelessWidget {
  final bool isSelected;
  final CategoryData categoryData;

  const CreateTabBarItem({
    super.key,
    required this.categoryData,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: isSelected ? ColorPallate.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(45.0),
        border: Border.all(color: ColorPallate.primaryColor),
      ),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(categoryData.icn),
            color: isSelected ? Colors.white : ColorPallate.primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            categoryData.name,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isSelected ? Colors.white : ColorPallate.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
