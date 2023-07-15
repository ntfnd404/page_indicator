import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: true,
      ),
      home: const PageIndicatorView(),
    );
  }
}

class PageIndicatorView extends StatefulWidget {
  const PageIndicatorView({super.key});

  @override
  State<PageIndicatorView> createState() => _PageIndicatorViewState();
}

class _PageIndicatorViewState extends State<PageIndicatorView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              Container(color: Colors.red),
              Container(color: Colors.black),
              Container(color: Colors.blue),
              Container(color: Colors.green),
            ],
          ),
          Center(
            child: PageIndicator(
              controller: _pageController,
              count: 4,
              dotRadius: 20,
              spacing: 25,
              dotOutlineThickness: 5,
              dotFillColor: Colors.red,
              dotOutlineColor: Colors.blue,
              indicatorColor: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }
}
