import 'package:budget_ui/data/data.dart';
import 'package:budget_ui/helpers/color_helper.dart';
import 'package:budget_ui/models/category_model.dart';
import 'package:budget_ui/screens/category_screen.dart';
import 'package:budget_ui/widgets/bar_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoryScreen(category: category),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: const EdgeInsets.all(20.0),
        height: 100.0,
        width: double.infinity,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            LayoutBuilder(
              builder: (context, constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = percent * maxBarWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }

                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      width: barWidth,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

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
                  if (index == 0) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
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
                  } else {
                    final Category category = categories[index - 1];
                    double totalAmountSpent = 0;
                    for (var expense in category.expenses) {
                      totalAmountSpent += expense.cost;
                    }
                    return _buildCategory(category, totalAmountSpent);
                  }
                },
                childCount: 1 + categories.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
