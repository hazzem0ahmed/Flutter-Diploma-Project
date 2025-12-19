import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/auth/data/datasource/contract/auth_local_datasource.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_extensions.dart';
import 'package:movies/di/modules/service_locator.dart';
import 'package:movies/features/login/presentation/pages/login_screen.dart';
import 'package:movies/presentation/screens/tabs/edit_profile/edit_profile.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tab_contract.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tab_view_model.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tabs_content/histiry_tab/history_tab.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tabs_content/watch_list_tab.dart';

import '../../../../firebase/google_auth.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  //username
  String? userName;

  //TabBar
  int selectedIndex = 0;
  List<Widget> profileTabs = [WatchListTab(), HistoryTab(historyMovies: [],)];
  late TabController tabController;

  //Profile Tab View Model
  ProfileTabViewModel viewModel  = ProfileTabViewModel();


  @override
  void initState() {
    super.initState();
    _loadUserName();
    tabController = TabController(vsync: this, length: profileTabs.length);
    tabController.addListener(() {
      if (viewModel.state.selectedIndex != tabController.index) {
        viewModel.add(ChangeTabBarAction(tabController.index));
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final localDataSource = getIt<AuthLocalDatasource>();
    final name = await localDataSource.getUserName();
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: viewModel,
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: Container(
            padding: context.withPadding(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            AppAsset.avatar1,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: context.spaceHeight * 0.01),
                        Text(
                          userName ??
                              FirebaseAuthServices.user?.displayName ??
                              "App User",
                          style: context.text.headlineSmall!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: context.spaceWidth * 0.08),
                    Column(
                      children: [
                        Text(
                          "12",
                          style: context.text.headlineSmall!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          context.locale.watchList,
                          style: context.text.headlineSmall!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: context.spaceWidth * 0.08),
                    Column(
                      children: [
                        Text(
                          "10",
                          style: context.text.headlineSmall!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          context.locale.histroy,
                          style: context.text.headlineSmall!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: context.spaceHeight * 0.03),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, EditProfile.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            double.infinity,
                            context.spaceHeight * 0.055,
                          ),
                          backgroundColor: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          context.locale.editProfile,
                          style: context.text.titleMedium!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.spaceWidth * 0.02),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          try {
                            final googleAuth = FirebaseAuthServices();
                            googleAuth.signOutGoogle();
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          } catch (e) {
                            CherryToast.error(action: Text(e.toString()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            double.infinity,
                            context.spaceHeight * 0.055,
                          ),
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.locale.exit,
                              style: context.text.titleMedium!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(width: context.spaceWidth * 0.02),
                            Icon(
                              Icons.exit_to_app,
                              color: AppColors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.spaceHeight * 0.03),
                BlocBuilder<ProfileTabViewModel,ProfileTabState>(
                  builder:(context,state) {
                    return TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerHeight: 0,
                    controller: tabController,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: AppColors.yellow, width: 3),
                      insets: EdgeInsets.zero,
                    ),
                    indicatorColor: AppColors.yellow,
                    tabs: [
                      Tab(
                        height: context.spaceHeight * 0.1,
                        child: Column(
                          children: [
                            Image.asset(
                              AppAsset.watchListImage,
                              height: context.spaceHeight * 0.05,
                            ),
                            Text(
                              context.locale.watchList,
                              style: context.text.titleMedium!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        height: context.spaceHeight * 0.1,
                        child: Column(
                          children: [
                            Image.asset(
                              AppAsset.historyImage,
                              height: context.spaceHeight * 0.05,
                            ),
                            Text(
                              context.locale.histroy,
                              style: context.text.titleMedium!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  },
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: profileTabs,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
