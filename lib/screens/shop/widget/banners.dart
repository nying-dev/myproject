import 'package:flutter/material.dart';
import 'package:myproject/mq.dart';

class Banners extends StatefulWidget {
  const Banners({
    Key key,
  }) : super(key: key);

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Widget> _banners = List.generate(
    3,
    (index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              'assets/images/banner_home.jpg',
              fit: BoxFit.fill,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            color: Color(0xaa25FD25),

            borderRadius: BorderRadius.circular(9),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.green.withOpacity(0.9),
                Colors.lightGreen.withOpacity(0.3)
              ],
            ),
            // Image.asset('assets/images/banner_home.jpg', fit: BoxFit.fill),
          )),
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _banners.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MQuery.height * 0.2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          TabBarView(
            children: _banners,
            controller: _tabController,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_banners.length, (index) {
                  return PageIndicator(
                    index: index,
                    controller: _tabController,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageIndicator extends StatefulWidget {
  final int index;
  final TabController controller;
  const PageIndicator({
    this.index,
    this.controller,
  });

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.index == widget.controller.index;

    // add listener to tabcontroller to update page indicator size
    widget.controller.addListener(() {
      setState(() {
        _expanded = widget.index == widget.controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: _expanded ? 15 : 5,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: _expanded ? Color(0xff53B175) : Colors.grey,
      ),
    );
  }
}
