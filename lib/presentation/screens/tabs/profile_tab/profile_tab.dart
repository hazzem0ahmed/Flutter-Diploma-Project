import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/auth/data/datasource/contract/auth_local_datasource.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_extensions.dart';
import 'package:movies/di/modules/service_locator.dart';
import 'package:movies/features/login/presentation/pages/login_screen.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tab_contract.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tab_view_model.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tabs_content/history_tab/history_tab.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tabs_content/watch_list_tab.dart';
import '../../../../firebase/google_auth.dart';
import '../../../../network/api_service.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  String? userName;
  String? avatar;
  bool loading = true;

  late ProfileTabViewModel viewModel;
  late TabController tabController;

  final List<Widget> profileTabs = const [
    WatchListTab(),
    HistoryTab(historyMovies: []),
  ];

  @override
  void initState() {
    super.initState();
    viewModel = ProfileTabViewModel();
    tabController = TabController(vsync: this, length: profileTabs.length);
    tabController.addListener(() {
      if (viewModel.state.selectedIndex != tabController.index) {
        viewModel.add(ChangeTabBarAction(tabController.index));
      }
    });

    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final local = getIt<AuthLocalDatasource>();
      userName = await local.getUserName();

      if (userName == null || userName!.isEmpty) {
        userName = FirebaseAuthServices.user?.displayName;
      }

      if (userName == null || userName!.isEmpty) {
        final profile = await ApiService.getProfile();
        userName = "${profile['first_name']} ${profile['last_name']}";
        avatar = profile['avatar'];
      }
    } catch (e) {
      debugPrint("Error loading user data: $e");
    }

    if (mounted) setState(() => loading = false);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: AppColors.yellow)),
      );
    }

    return SafeArea(
      child: BlocProvider.value(
        value: viewModel,
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: Padding(
            padding: context.withPadding(8),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 350;
                    return isWide ? _buildWideHeader() : _buildNarrowHeader();
                  },
                ),

                SizedBox(height: context.spaceHeight * 0.03),

                _buildActionButtons(context),

                SizedBox(height: context.spaceHeight * 0.03),

                TabBar(
                  controller: tabController,
                  indicatorColor: AppColors.yellow,
                  labelColor: AppColors.yellow,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Watch List'),
                    Tab(text: 'History'),
                  ],
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


  Widget _buildWideHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildAvatar(60),
        SizedBox(width: context.spaceWidth * 0.04),
        Flexible(
          child: _buildUserNameText(20),
        ),
      ],
    );
  }

  Widget _buildNarrowHeader() {
    return Column(
      children: [
        _buildAvatar(100),
        SizedBox(height: context.spaceHeight * 0.01),
        _buildUserNameText(18, isCentered: true),
      ],
    );
  }

  Widget _buildAvatar(double size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: avatar != null
          ? Image.asset(
        avatar!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _defaultAvatar(size),
      )
          : _defaultAvatar(size),
    );
  }

  Widget _defaultAvatar(double size) {
    return Image.asset(
      AppAsset.avatar1,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }

  Widget _buildUserNameText(double fontSize, {bool isCentered = false}) {
    return Text(
      userName ?? "App User",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      style: context.text.headlineSmall!.copyWith(
        color: AppColors.white,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellow,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              "Edit Profile",
              style: context.text.titleMedium!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () => _handleLogout(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Exit", style: TextStyle(color: Colors.white)),
                SizedBox(width: 4),
                Icon(Icons.exit_to_app, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogout(BuildContext context) {
    try {
      final googleAuth = FirebaseAuthServices();
      googleAuth.signOutGoogle();
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (e) {
      CherryToast.error(title: Text(e.toString())).show(context);
    }
  }
}