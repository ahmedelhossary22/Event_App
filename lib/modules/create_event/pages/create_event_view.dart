import 'package:event_app/core/services/snackbar_services.dart';
import 'package:event_app/core/theme/color_pallate.dart%20';
import 'package:event_app/core/utils/firestore_services.dart';
import 'package:event_app/core/widgets/custom_button_widget.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/models/category_data.dart';
import 'package:event_app/models/event_data.dart';
import 'package:event_app/modules/create_event/pages/select_location_screen.dart';
import 'package:event_app/modules/create_event/widgets/create_tab_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CreateEventView extends StatefulWidget {
  final EventData? eventData;

  const CreateEventView({super.key, this.eventData});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedIndex = 0;
  LatLng? selectedPosition;
  String? locationLabel;

  @override
  void initState() {
    super.initState();
    if (widget.eventData != null) {
      _titleController.text = widget.eventData!.title;
      _descriptionController.text = widget.eventData!.description;
      _selectedIndex = categories.indexWhere(
        (element) => element.id == widget.eventData!.categoryID,
      );
      _selectedDate = widget.eventData!.selectedDate;
      if (widget.eventData!.latitude != null &&
          widget.eventData!.longitude != null) {
        selectedPosition = LatLng(
          widget.eventData!.latitude!,
          widget.eventData!.longitude!,
        );
        locationLabel =
            'Lat: ${widget.eventData!.latitude!.toStringAsFixed(4)}, Lng: ${widget.eventData!.longitude!.toStringAsFixed(4)}';
      }
    }
  }

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
    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      image: AssetImage(categories[_selectedIndex].image),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                      _selectedIndex = index;
                    });
                  },
                  tabs: categories.map((element) {
                    return CreateTabBarItem(
                      categoryData: element,
                      isSelected: _selectedIndex == categories.indexOf(element),
                    );
                  }).toList(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Title',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomTextFormField(
                  controller: _titleController,
                  hintText: 'Event Title',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.edit_note_rounded,
                    size: 30,
                    color: ColorPallate.textFormFieldBorderColor,
                  ),
                ),
              ),

              // 📝 Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Description',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomTextFormField(
                  controller: _descriptionController,
                  hintText: ' Event Description',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  maxLines: 4,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.calendar_month_outlined, size: 30),
                    Text(
                      'Event date',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Bounceable(
                      onTap: selectEventDate,
                      child: Text(
                        _selectedDate != null
                            ? DateFormat('EEE, MMM d').format(_selectedDate!)
                            : "Choose Date",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: ColorPallate.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.access_time_outlined, size: 30),
                    Text(
                      'Time',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Bounceable(
                      onTap: selectTimeDate,
                      child: Text(
                        _selectedTime != null
                            ? _selectedTime!.format(context)
                            : "Choose Time",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: ColorPallate.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Location',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButtonWidget(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectLocationScreen(),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        selectedPosition = result;
                        locationLabel =
                            'Lat: ${result.latitude.toStringAsFixed(4)}, Lng: ${result.longitude.toStringAsFixed(4)}';
                      });
                    }
                  },
                  bacgroundColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: ColorPallate.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.my_location_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Choose Event Location',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorPallate.primaryColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: ColorPallate.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (locationLabel != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    locationLabel!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: ColorPallate.primaryColor,
                    ),
                  ),
                ),
              SizedBox(height: 180),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButtonWidget(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _selectedDate != null) {
                      final event = EventData(
                        eventID: widget.eventData?.eventID ?? '',
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        selectedDate: _selectedDate!,
                        categoryID: categories[_selectedIndex].id,
                        imageUrl: categories[_selectedIndex].image,
                        isFavourite: widget.eventData?.isFavourite ?? false,
                        latitude: selectedPosition?.latitude,
                        longitude: selectedPosition?.longitude,
                      );
                      EasyLoading.show(status: 'Saving');
                      try {
                        if (widget.eventData == null) {
                          await FirestoreServices.addNewEvent(event);
                        } else {
                          await FirestoreServices.updateEvent(event);
                        }
                        EasyLoading.dismiss();
                        Navigator.pop(context);
                        SnackBarServices.showSuccessMessage(
                          'Event saved successfully',
                        );
                      } catch (e) {
                        EasyLoading.dismiss();
                        SnackBarServices.showErrorMessage(e.toString());
                      }
                    }
                  },
                  bacgroundColor: ColorPallate.primaryColor,
                  child: Center(
                    child: Text(
                      widget.eventData != null
                          ? 'Update Event'
                          : 'Create Event',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectEventDate() async {
    var currentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {
      if (currentDate != null) {
        _selectedDate = currentDate;
      }
    });
  }

  Future<void> selectTimeDate() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      if (_selectedDate == null) {
        SnackBarServices.showWarningMessage('Please select date first');
        return;
      }

      setState(() {
        _selectedTime = pickedTime;
        _selectedDate = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
}
