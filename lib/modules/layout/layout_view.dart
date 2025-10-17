import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme/color_pallate.dart ';
import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modules/layout/pages/favourite_view.dart';
import 'package:event_app/modules/layout/pages/home_view.dart';
import 'package:event_app/modules/layout/pages/maps_view.dart';
import 'package:event_app/modules/layout/pages/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _currentIndex = 0;
  List<Widget> pages = [HomeView(), MapsView(), FavouriteView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: Bounceable(
        onTap: () {
          Navigator.pushNamed(context, PageRoutesName.createEvent);
        },
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: ColorPallate.primaryColor,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,

        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.homeIcn.image(height: 26),
            activeIcon: Assets.icons.selectedHomeIcn.image(height: 26),
            label: local.home,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.mapIcn.image(height: 26),
            activeIcon: Assets.icons.selectedMapIcn.image(height: 26),
            label: local.map,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.favouriteIcn.image(height: 26),
            activeIcon: Assets.icons.selectedFavouriteIcn.image(height: 26),
            label: local.favorites,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.profileIcn.image(height: 26),
            activeIcon: Assets.icons.selectedProfileIcn.image(height: 26),
            label: local.profile,
          ),
        ],
      ),
    );
  }
}
