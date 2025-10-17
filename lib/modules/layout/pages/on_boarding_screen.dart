import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme/color_pallate.dart%20';
import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/modules/layout/widgets/on_boarding_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              OnBoardingWidgets(
                imagePath: Assets.images.onBoardingscreen1.path,
                title: 'Personalize Your Experience',
                description:
                    'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
              ),
              OnBoardingWidgets(
                imagePath: Assets.images.onBoardingscreen2.path,
                title: 'Find Events That Inspire You',
                description:
                    "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
              ),
              OnBoardingWidgets(
                imagePath: Assets.images.onBoardingscreen3.path,
                title: 'Effortless Event Planning',
                description:
                    'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
              ),
              OnBoardingWidgets(
                imagePath: Assets.images.onBoardingscreen4.path,
                title: 'Connect with Friends & Share Moments',
                description:
                    "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage != 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: ColorPallate.textFormFieldBorderColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60),

                  Row(
                    children: List.generate(_totalPages, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: _currentPage == index ? 12 : 8,
                        height: _currentPage == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? ColorPallate.textFormFieldBorderColor
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_currentPage == _totalPages - 1) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool("onBoardingSeen", true);

                        Navigator.pushReplacementNamed(
                          context,
                          PageRoutesName.signIn,
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == _totalPages - 1 ? 'Finish' : 'Next',
                      style: TextStyle(
                        color: ColorPallate.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
