import 'package:flutter/material.dart';
import 'package:health_app_1/presentation/component/circular_graph.dart';
import 'package:health_app_1/presentation/component/colors.dart';
import 'package:health_app_1/presentation/component/logo.dart';
import 'package:health_app_1/presentation/component/pedometer_graph.dart';
import 'package:health_app_1/presentation/provider/home_provider.dart';
import 'package:health_app_1/util/di.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeProvider provider = di.get<HomeProvider>();

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    provider.startListening();
    provider.addListener(updateScreen);
  }

  @override
  void dispose() {
    provider.stopListening();
    provider.removeListener(updateScreen);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            backgroundColor: primary,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: logo(),
              titlePadding: EdgeInsets.zero,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
              child: Column(
                children: [
                  pedometerGraph(),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 180,
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                    ),
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: CustomPaint(
                                size: Size(90, 90),
                                painter: CircularGraph(
                                    currentValue: 50,
                                    targetValue: 100,
                                    strokeWidth: 10,
                                    backgroundColor: Colors.indigo.shade200,
                                    primaryColor: Colors.cyan.shade200,
                                ),
                              ),
                            ),
                            Align(
                              child: Icon(Icons.water_drop, color: Colors.cyan.shade200, size: 25),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining()
        ]
      ),
    );
  }

  Widget pedometerGraph() => Stack(
    alignment: Alignment.center,
    children: [
      CustomPaint(
        size: const Size(270, 270),
        painter: PedometerGraph(goalSteps: provider.goalSteps, currentSteps: provider.currentSteps),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.directions_run_rounded, size: 50, color: primary),
          Text(
            '${(provider.currentSteps / provider.goalSteps * 100).floor()}%',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
          Text(
            '${provider.currentSteps} / ${provider.goalSteps}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          )
        ],
      )
    ],
  );
}
