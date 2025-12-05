import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/ui/tabs/ExploreTab.dart';
import 'package:movies/ui/tabs/HomeTab.dart';
import 'package:movies/ui/tabs/ProfileTab.dart';
import 'package:movies/ui/tabs/SearchTab.dart';

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
    Profiletab(),
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
                      icon: ImageIcon(AssetImage('assets/icons/homeTab.png')),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/icons/searchTab.png')),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/icons/Vector.png')),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage('assets/icons/Profiel.png')),
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
