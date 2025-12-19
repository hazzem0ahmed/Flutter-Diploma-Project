import 'package:flutter/material.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tabs_content/history_tab/history_tab.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tabs_content/watch_list_tab.dart';
import '../../../../network/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  Map<String, dynamic>? profile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      profile = await ApiService.getProfile();
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load profile'))
        );
      }
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(profile!['avatar']),
                  ),

                  const SizedBox(width: 12),
                  Text(
                    '${profile!['first_name']} ${profile!['last_name']}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.exit_to_app, color: Colors.white),
                          SizedBox(width: 4),
                          Text('Exit'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tabs
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.amber,
              labelColor: Colors.amber,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Watch List'),
                Tab(text: 'History'),
              ],
            ),


            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  WatchListTab(),
                  HistoryTab(historyMovies: [],),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
