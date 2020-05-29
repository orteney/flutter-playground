import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverPullToRefresh extends StatefulWidget {
  const SliverPullToRefresh({Key key}) : super(key: key);

  @override
  _SliverPullToRefreshState createState() => _SliverPullToRefreshState();
}

class _SliverPullToRefreshState extends State<SliverPullToRefresh> with SingleTickerProviderStateMixin {
  final tabs = [
    Tab(text: 'First'),
    Tab(text: 'Second'),
    Tab(text: 'Third'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliver Pull to Refresh'),
      ),
      body: _buildCustomScrollViewWithCupertinoSliver(context),
    );
  }

  Widget _buildNestedScrollView(BuildContext context) {
    //! Not working Refresh Indicator
    return RefreshIndicator(
      onRefresh: () => Future.delayed(Duration(seconds: 1)),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                child: Center(
                  child: Text('Hey'),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: SliverTabBarViewDelegate(
                child: TabBar(
                  tabs: tabs,
                  controller: _tabController,
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) => _Tab(title: e.text)).toList(),
        ),
      ),
    );
  }

  Widget _buildCustomScrolViewWithRefreshIndicator(BuildContext context) {
    //! Need to use NeverScroll Physics in tabs. And works weird...
    return RefreshIndicator(
      onRefresh: () => Future.delayed(Duration(seconds: 1)),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Center(
                child: Text('Hey'),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverTabBarViewDelegate(
              child: TabBar(
                tabs: tabs,
                controller: _tabController,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((e) => _Tab(title: e.text)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomScrollViewWithCupertinoSliver(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          onRefresh: () => Future.delayed(Duration(seconds: 1)),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            child: Center(
              child: Text('Hey'),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: SliverTabBarViewDelegate(
            child: TabBar(
              tabs: tabs,
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
            ),
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            children: tabs.map((e) => _Tab(title: e.text)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildNestedScrollViewWithCupertino(BuildContext context) {
    //! Still not working
    return NestedScrollView(
      physics: BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          CupertinoSliverRefreshControl(
            onRefresh: () => Future.delayed(Duration(seconds: 1)),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Center(
                child: Text('Hey'),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverTabBarViewDelegate(
              child: TabBar(
                tabs: tabs,
                controller: _tabController,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        physics: BouncingScrollPhysics(),
        children: tabs.map((e) => _Tab(title: e.text)).toList(),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String title;

  const _Tab({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 100,
      itemExtent: 50,
      itemBuilder: (BuildContext context, int index) {
        return Center(child: Text("$title's $index widget"));
      },
    );
  }
}

class SliverTabBarViewDelegate extends SliverPersistentHeaderDelegate {
  SliverTabBarViewDelegate({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: child,
      elevation: (shrinkOffset > 0) ? 4.0 : 0.0,
    );
  }

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
