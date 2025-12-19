import 'package:flutter/material.dart';
import '../../../../../network/api_service.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService.getWatchList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final list = snapshot.data as List<String>;

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index], style: const TextStyle(color: Colors.white)),
            );
          },
        );
      },
    );
  }
}
