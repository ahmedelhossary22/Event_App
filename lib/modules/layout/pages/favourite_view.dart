import 'package:event_app/core/utils/firestore_services.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/models/event_data.dart';
import 'package:event_app/modules/layout/widgets/category_item.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/color_pallate.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<EventData> _allEvents = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextFormField(
              controller: _searchController,
              hintText: 'Search for Events',
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim().toLowerCase();
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: FirestoreServices.getStreamOfFavEvents(),
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

              _allEvents = snapshot.data!.docs.map((e) => e.data()).toList();

              List<EventData> filteredList = _searchQuery.isEmpty
                  ? _allEvents
                  : _allEvents
                        .where(
                          (event) =>
                              event.title.toLowerCase().contains(_searchQuery),
                        )
                        .toList();

              if (filteredList.isEmpty) {
                return Center(
                  child: Text(
                    'No event with this title',
                    style: theme.textTheme.headlineLarge,
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                itemBuilder: (context, index) {
                  return CategoryItem(eventData: filteredList[index]);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: filteredList.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
