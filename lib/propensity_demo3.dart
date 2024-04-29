import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

// 3안
void main() {
  runApp(IconStepperDemo());
}

class IconStepperDemo extends StatefulWidget {
  @override
  _IconStepperDemoState createState() => _IconStepperDemoState();
}

class _IconStepperDemoState extends State<IconStepperDemo> {
  int activeStep = 0;
  int upperBound = 8;
  Map<int, int> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              if (activeStep > 0) {
                setState(() {
                  activeStep--;
                });
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
        body: ScaffoldMessenger(
          child: activeStep == upperBound
              ? InvestmentResult(selectedOptions: selectedOptions)
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              IconStepper(
                icons: List.generate(
                  9,
                      (index) => Icon(
                    selectedOptions.containsKey(index) ? Icons.check : Icons.circle,
                    color: Colors.white,
                  ),
                ),
                activeStepColor: Colors.black,
                stepRadius: 11,
                lineColor: Colors.black,
                activeStep: activeStep,
                lineLength: 20,
                stepReachedAnimationDuration: const Duration(milliseconds: 0),
                stepReachedAnimationEffect: Easing.legacy,
                enableNextPreviousButtons: false,
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: questionForm(activeStep),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (activeStep > 0) previousButton(),
                    if (activeStep == upperBound) submitButton() else SizedBox(width: 100),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionForm(int step) {
    List<List<String>> options = [
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ];

    var questions = [
      'Question 1',
      'Question 2',
      'Question 3',
      'Question 4',
      'Question 5',
      'Question 6',
      'Question 7',
      'Question 8',
      'Question 9',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questions[step],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        ...List.generate(
          options[step].length,
              (index) => RadioListTile<int>(
            title: Text(
              options[step][index],
              style: TextStyle(color: Colors.black),
            ),
            value: index,
            groupValue: selectedOptions[step],
            onChanged: (int? value) {
              setState(() {
                selectedOptions[step] = value!;
                if (_allQuestionsAnswered()) {
                  activeStep++;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_allQuestionsAnswered()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvestmentResult(selectedOptions: selectedOptions),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Please answer all questions before submitting.',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
          );
        }
      },
      child: Text(
        'Submit',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text(
        'Prev',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
    );
  }

  bool _allQuestionsAnswered() {
    for (int i = 0; i <= activeStep; i++) {
      if (!selectedOptions.containsKey(i)) {
        return false;
      }
    }
    return true;
  }
}

class InvestmentResult extends StatelessWidget {
  final Map<int, int> selectedOptions;

  InvestmentResult({required this.selectedOptions});

  @override
  Widget build(BuildContext context) {
    String investmentPropensity = 'Conservative';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Investment Style Test Result',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Your investment propensity is $investmentPropensity.',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
