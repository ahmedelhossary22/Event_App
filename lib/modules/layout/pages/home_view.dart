import 'package:event_app/core/theme/color_pallate.dart';
import 'package:event_app/core/utils/firestore_services.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/models/category_data.dart';
import 'package:event_app/models/event_data.dart';
import 'package:event_app/modules/create_event/pages/create_event_view.dart';
import 'package:event_app/modules/layout/widgets/category_item.dart';
import 'package:event_app/modules/layout/widgets/tab_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

int _currentIndex = 0;

class _HomeViewState extends State<HomeView> {
  final List<CategoryData> categories = [
    CategoryData(
      id: 'Sport',
      name: 'Sport',
      icn: Assets.icons.bikeIcn.path,
      image: Assets.images.sportImg.path,
    ),
    CategoryData(
      id: 'book_club',
      name: 'Book Club ',
      icn: Assets.icons.bookIcn.path,
      image: Assets.images.bookclubImg.path,
    ),
    CategoryData(
      id: 'birthday',
      name: 'BirthDay ',
      icn: Assets.icons.cakeIcn.path,
      image: Assets.images.birthdayImg.path,
    ),
    CategoryData(
      id: 'eating',
      name: 'Eating',
      icn: Assets.icons.bikeIcn.path,
      image: Assets.images.eatingImg.path,
    ),
    CategoryData(
      id: 'exhibition',
      name: 'Exhibition ',
      icn: Assets.icons.bookIcn.path,
      image: Assets.images.exhibitionImg.path,
    ),
    CategoryData(
      id: 'gaming',
      name: 'Gaming ',
      icn: Assets.icons.cakeIcn.path,
      image: Assets.images.gamingImg.path,
    ),
    CategoryData(
      id: 'meeting',
      name: 'Meeting',
      icn: Assets.icons.bikeIcn.path,
      image: Assets.images.meetingImg.path,
    ),
    CategoryData(
      id: 'holiday',
      name: 'Holiday ',
      icn: Assets.icons.bookIcn.path,
      image: Assets.images.holidayImg.path,
    ),
    CategoryData(
      id: 'workshop',
      name: 'Workshop ',
      icn: Assets.icons.cakeIcn.path,
      image: Assets.images.workshopImg.path,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorPallate.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Back ✨',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  FirebaseAuth
                                          .instance
                                          .currentUser
                                          ?.displayName ??
                                      'User',
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Assets.icons.mapIcn.image(height: 24),
                                    const SizedBox(width: 6),
                                    Text('Cairo , Egypt'),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.light_mode_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    "En",
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: ColorPallate.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DefaultTabController(
                    length: categories.length,
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      indicator: BoxDecoration(),
                      dividerColor: Colors.transparent,
                      dividerHeight: 0,
                      onTap: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      tabs: categories.map((element) {
                        return TabBarItem(
                          categoryData: element,
                          isSelected:
                              _currentIndex == categories.indexOf(element),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: FirestoreServices.getStreamOfEvents(
              categories[_currentIndex].id,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorPallate.primaryColor,
                  ),
                );
              }
              List<EventData> eventsList = snapshot.data!.docs.map((element) {
                return element.data();
              }).toList();
              return eventsList.isEmpty
                  ? Center(
                      child: Text(
                        'No Events',
                        style: theme.textTheme.headlineLarge,
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      itemBuilder: (context, index) {
                        final event = eventsList[index];
                        return Bounceable(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CreateEventView(eventData: event),
                              ),
                            );
                          },
                          child: CategoryItem(eventData: event),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: eventsList.length,
                    );
            },
          ),
          /*
          FutureBuilder<List<EventData>>(
            future: FirestoreServices.getAllEvents(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text(
                  snapshot.error.toString(),
                );
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(
                  color: ColorPallate.primaryColor,
                ));
              }
              List<EventData> events= snapshot.data??[];
              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                itemBuilder: (context, index) {
                  return CategoryItem(eventData:events[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: events.length,
              );
            },
          ),
          */
        ],
      ),
    );
  }
}
