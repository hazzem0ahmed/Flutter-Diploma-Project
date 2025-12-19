import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/screens/tabs/explore_screen/explore_tab.dart';
import 'package:movies/presentation/screens/tabs/homeTab/home_tab.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tab.dart';
import 'package:movies/presentation/screens/tabs/search_tab.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void changeTab(int index) => emit(index);
}

class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  final List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    ExploreTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return tabs[currentIndex];
          },
        ),

        bottomNavigationBar: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 10,
              child: Image.asset('assets/images/Rectangle 16.png'),
            ),
            BlocBuilder<NavigationCubit, int>(
              builder: (context, currentIndex) {
                return BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (index) {
                    context.read<NavigationCubit>().changeTab(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.black,
                  selectedItemColor: Color(0xFFF6BD00),
                  unselectedItemColor: Colors.white,
                  items: const [
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/images/homeTab.png')),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/searchTab.png'),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/images/Vector.png')),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/images/Profiel.png')),
                      label: '',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
