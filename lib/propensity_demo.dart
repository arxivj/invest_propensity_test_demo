import 'package:flutter/material.dart';

// 1안

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final PageController _pageController = PageController();
  Map<int, int> selections = {};
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<String> questions = [
      "위험을 얼마나 감수할 의향이 있습니까?",
      "투자 시 고려하는 가장 중요한 요소는 무엇입니까?",
      "당신의 투자 목표 기간은 어떻게 됩니까?",
      "경제 상황 변화에 어떻게 대응합니까?",
      "투자 결정을 내릴 때 어떤 정보를 주로 참고합니까?",
      "금융 상품에 대한 이해도는 어느 정도입니까?",
      "투자 손실 발생 시 어떤 행동을 취합니까?",
      "투자 수익을 어떻게 재투자합니까?",
      "투자에 있어 가장 우선시하는 것은 무엇입니까?",
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (currentPage > 0) {
              _pageController.previousPage(
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
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentPage + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemCount: questions.length,
                itemBuilder: (_, index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 200),
                        Text(questions[index],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        if (index == 1 || index == 4) // 인덱스 조건
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.2,
                            children: List.generate(
                                4,
                                (optionIndex) => ChoiceTile(
                                      iconData: Icons.check_circle_outline,
                                      text: '선택지 ${optionIndex + 1}',
                                      isSelected:
                                          selections[index] == optionIndex,
                                      onTap: () => setState(() =>
                                          selections[index] = optionIndex),
                                      pageController: _pageController,
                                      totalQuestions: questions.length,
                                    )),
                          )
                        else
                          Column(
                            children: List.generate(
                                4,
                                (optionIndex) => RadioListTile<int>(
                                      title: Text('선택지 ${optionIndex + 1}'),
                                      value: optionIndex,
                                      groupValue: selections[index],
                                      onChanged: (int? value) {
                                        setState(() {
                                          selections[index] = value!;
                                        });
                                        if (index < questions.length - 1) {
                                          _pageController.nextPage(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeIn);
                                        }
                                      },
                                    )),
                          ),
                        Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final PageController pageController;
  final int totalQuestions;

  const ChoiceTile({
    Key? key,
    required this.iconData,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.pageController,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        if (pageController.page!.toInt() < totalQuestions - 1) {
          pageController.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData,
                size: 40,
                color: isSelected ? Colors.white : Colors.grey.shade600),
            SizedBox(height: 10),
            Text(text,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
