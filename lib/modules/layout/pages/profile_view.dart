import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modules/app_manager/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ ADD THIS IMPORT
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/color_pallate.dart';
import '../../../gen/assets.gen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final List<String> languageList = ['English', 'عربي'];
  final List<String> themeList = ['Light', 'Dark'];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Header Section with User Info
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
          decoration: const BoxDecoration(
            color: ColorPallate.primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65.0)),
          ),
          child: Row(
            spacing: 10,
            children: [
              Assets.images.routeImg.image(height: 124),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? 'User',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    user?.email ?? 'No Email',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            local.language,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomDropdown<String>(
            hintText: 'Select language',
            items: languageList,
            initialItem: languageList[0],
            onChanged: (value) {
              log('Changing language to: $value');
              provider.changeLanguage(value == 'English' ? 'en' : 'ar');
            },
            decoration: CustomDropdownDecoration(
              closedFillColor: Colors.transparent,
              closedSuffixIcon: const Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 30,
                color: ColorPallate.primaryColor,
              ),
              listItemStyle: theme.textTheme.titleLarge?.copyWith(
                color: ColorPallate.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              headerStyle: theme.textTheme.titleLarge?.copyWith(
                color: ColorPallate.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              closedBorder: Border.all(color: ColorPallate.primaryColor),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            local.theme,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomDropdown<String>(
            hintText: 'Select theme',
            items: themeList,
            initialItem: themeList[0],
            onChanged: (value) {
              log('Changing theme to: $value');
              provider.changeTheme(value == 'Light' ? 'light' : 'dark');
            },
            decoration: CustomDropdownDecoration(
              closedFillColor: Colors.transparent,
              closedSuffixIcon: const Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 30,
                color: ColorPallate.primaryColor,
              ),
              listItemStyle: theme.textTheme.titleLarge?.copyWith(
                color: ColorPallate.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              headerStyle: theme.textTheme.titleLarge?.copyWith(
                color: ColorPallate.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              closedBorder: Border.all(color: ColorPallate.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
