import 'package:budget_ui/data/data.dart';
import 'package:budget_ui/widgets/bar_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) {
          return [
            SliverAppBar(
              forceElevated: true,
              floating: true,
              // pinned: true,
              // pin title with app bar
              expandedHeight: 100.0,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('Simple Budget'),
                centerTitle: true,
              ),
              leading: IconButton(
                icon: const Icon(Icons.settings),
                iconSize: 30.0,
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  iconSize: 30.0,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ];
        },
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: BarChart(expenses: weeklySpending),
                  );
                },
                childCount: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
