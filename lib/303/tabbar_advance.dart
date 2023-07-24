import 'package:flutter/material.dart';
import 'package:lessonone/303/feed_view.dart';

import '../101/icon_learn.dart';
import '../101/image_learn.dart';

class TabBarAdvance extends StatefulWidget {
  const TabBarAdvance({Key? key}) : super(key: key);

  @override
  State<TabBarAdvance> createState() => _TabBarAdvanceState();
}

class _TabBarAdvanceState extends State<TabBarAdvance>
    with TickerProviderStateMixin, _TabLearnSizeUtility {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _MyTabViews.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _MyTabViews.values.length,
        child: Scaffold(
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(onPressed: () {
            _tabController.animateTo(_MyTabViews.home.index);
          }),
          bottomNavigationBar: BottomAppBar(
            height: heigth,
            notchMargin: notchSize,
            shape: const CircularNotchedRectangle(),
            child: _myTab(),
          ),
          body: _tabView(),
        ));
  }

  TabBar _myTab() {
    return TabBar(
        indicatorColor: Colors.orangeAccent,
        labelColor: Colors.red,
        unselectedLabelColor: Colors.green,
        padding: EdgeInsets.zero,
        controller: _tabController,
        onTap: (int value) {
          print(value);
        },
        tabs: _MyTabViews.values
            .map((values) => Tab(
                  child: Center(child: Text("Page${values.name}")),
                ))
            .toList());
  }
  TabBarView _tabView() {
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          const FeedView(),
          IconLearnView(),
          const ImageLearn(),
          IconLearnView(),
        ]);
  }
}
class _TabLearnSizeUtility {
  final double heigth = 50;
  final double notchSize = 10;
}
enum _MyTabViews {
  home,
  settings,
  favorite,
  profile,
}
extension _MyTabViewExtension on _MyTabViews {}


