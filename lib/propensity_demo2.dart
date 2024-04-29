import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


// 2안
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Page Indicator Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  int currentPageIndex = 0;
  List<int> selectedOptions = List.filled(6, -1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (currentPageIndex > 0) {
              controller.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return PageContent(
                  question: _getQuestion(index),
                  options: _getOptions(index),
                  onPageChanged: (index) {
                    currentPageIndex = index;
                  },
                  onOptionSelected: (optionIndex) {
                    setState(() {
                      selectedOptions[index] = optionIndex;
                    });
                    if (index < 5) {
                      controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  selectedOptionIndex: selectedOptions[index],
                );
              },
              itemCount: 6,
            ),
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  textDirection: TextDirection.ltr,
                  axisDirection: Axis.horizontal,
                  controller: controller,
                  count: 6,
                  effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.green,
                    spacing: 20,
                    paintStyle: PaintingStyle.fill,
                    dotHeight: 16,
                    dotWidth: 16,
                    type: WormType.thinUnderground,
                  ),
                  onDotClicked: (index) {
                    controller.animateToPage(
                      index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  if (currentPageIndex < 5) {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(currentPageIndex == 5 ? "Finish" : "Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getQuestion(int index) {
    switch (index) {
      case 0:
        return "What is your investment horizon?";
      case 1:
        return "How much risk can you tolerate?";
      case 2:
        return "What do you mainly focus on when investing?";
      case 3:
        return "How do you feel about potential losses?";
      case 4:
        return "Which information do you trust the most when making investment decisions?";
      case 5:
        return "How do you react when you make a profit from an investment?";
      default:
        return "";
    }
  }

  List<String> _getOptions(int index) {
    switch (index) {
      case 0:
        return ["Within a week", "Within a month", "More than a month", "Not sure"];
      case 1:
        return ["High risk", "Moderate risk", "Low risk", "Not sure"];
      case 2:
        return ["Profitability", "Stability", "Growth potential", "Not sure"];
      case 3:
        return ["Accept small losses", "Avoid significant losses", "Cannot tolerate losses", "Not sure"];
      case 4:
        return ["Expert opinions", "Own research", "Social media", "Not sure"];
      case 5:
        return ["Immediately", "If profit exceeds", "Hold for long term", "Not sure"];
      default:
        return [];
    }
  }
}

class PageContent extends StatelessWidget {
  final String question;
  final List<String> options;
  final Function(int)? onPageChanged;
  final Function(int)? onOptionSelected;
  final int selectedOptionIndex;

  PageContent({
    required this.question,
    required this.options,
    this.onPageChanged,
    this.onOptionSelected,
    required this.selectedOptionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return GestureDetector(
                onTap: () {
                  onOptionSelected?.call(index);
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: selectedOptionIndex == index ? Colors.green : Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        option,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
