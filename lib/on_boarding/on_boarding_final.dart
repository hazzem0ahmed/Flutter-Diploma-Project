import 'package:flutter/material.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/features/login/presentation/pages/login_screen.dart';
import 'package:movies/on_boarding/widget/on_boarding_temp.dart';

import '../l10n/generated/app_localizations.dart';

class OnBoardingFinal extends StatefulWidget {
  static const String routeName = "/onboardingFinal";

  const OnBoardingFinal({super.key});


  @override
  State<OnBoardingFinal> createState() => _OnBoardingFinalState();

}

class _OnBoardingFinalState extends State<OnBoardingFinal> {
  late PageController _controller;
  int currentIndex = 0 ;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener((){
      setState(() {
        currentIndex =_controller.page!.toInt();

      });
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
  List<OnBoardingTemp> onBoardingList = [

    OnBoardingTemp(
      image: AppAsset.onBoarding1Image,
      title: locale.discoverMovies,
      subtitle: locale.title1,
    ),
    OnBoardingTemp(
      image: AppAsset.onBoarding2Image,
      title: locale.exploreAllGenres,
      subtitle: locale.title2,
    ),
    OnBoardingTemp(
      image: AppAsset.onBoarding3Image,
      title: locale.createWatchlists,
      subtitle: locale.title3,
      ),
    OnBoardingTemp(
      image: AppAsset.onBoarding4Image,
      title: locale.rateReviewandLearn,
      subtitle: locale.title4,
    ),
    OnBoardingTemp(
      image: AppAsset.onBoarding5Image,
      title: locale.startWatchingNow,
      subtitle: null,
    ),
  ];

  return Scaffold(
      backgroundColor: AppColors.black,
      body: PageView.builder(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        itemCount: onBoardingList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned(
              top: 0,
              left: 0,
              right: 0,
              height:  MediaQuery.of(context).size.height * 0.85,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      onBoardingList[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                          Colors.black.withValues(alpha: 0.05),
                          Colors.white.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        onBoardingList[index].title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),

                      if (onBoardingList[index].subtitle != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          onBoardingList[index].subtitle!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                      const SizedBox(height: 25),
                      currentIndex == 4 ? SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: ElevatedButton(
                          onPressed: () {
                            if (index < onBoardingList.length - 1) {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOut,
                              );
                            } else {
                              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: AppColors.yellow,
                            foregroundColor: AppColors.black,
                          ),
                          child: Text(
                            locale.finish,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ) :
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: ElevatedButton(
                          onPressed: () { _controller.animateToPage(currentIndex+1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: AppColors.yellow,
                            foregroundColor: AppColors.black,
                          ),
                          child: Text(
                           locale.next,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      currentIndex == 0 ? Container() : SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: OutlinedButton(
                          onPressed: () {
                            _controller.animateToPage(currentIndex-1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOut,);

                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                              side: const BorderSide(color: AppColors.yellow, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: AppColors.black,
                            foregroundColor: AppColors.yellow,
                          ),
                          child: Text(
                           locale.back,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),]
          );
        },
      ),
    );
  }

}
