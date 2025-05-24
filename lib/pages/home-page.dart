import 'package:flutter/material.dart';
import 'package:pronounceit/pages/steps/language.dart';
import 'package:pronounceit/pages/steps/phrase.dart';
import 'package:pronounceit/pages/steps/result.dart';
import 'package:pronounceit/pages/steps/speak.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late WizardStepperController controller;
  Stream<String>? responseStream;

  StringBuffer buffer = StringBuffer();
  TextEditingController text2Controller = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();

    controller = WizardStepperController(
      orientation: WizardStepperOrientation.vertical,
      position: WizardStepperPosition.left,
      showNavigationButtons: true,
      nextButtonLabel: "Let's go!",
      nextButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.lightGreenAccent),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      previousButtonStyle: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      stepColor: Colors.deepPurple,
      dividerColor: Colors.black,
      completedStepColor: Colors.lightGreen,
      stepNumberColor: Colors.white,
      currentStepColor: Colors.purpleAccent,
      onMovedToLastStep: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => Text("HERE")));
      },
    );
  }

  void onResetWizard() {
    controller.resetWizard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 4, 13, 33),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: WizardStepper(
                controller: controller,
                steps: [
                  LanguagePicker(),
                  PhrasePicker(),
                  Speak(),
                  Result(onReset: onResetWizard),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
