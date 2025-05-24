import 'package:flutter/material.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';
import 'package:pronounceit/pages/steps/context.dart';
import 'package:provider/provider.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class Result extends StatelessWidget with WizardStep {
  Result({super.key});

  @override
  Widget build(BuildContext context) {
    final appContext = context.watch<ContextProvider>();

    return Padding(
      padding: const EdgeInsets.all(32),
      child: ValueListenableBuilder<bool>(
        valueListenable: isCompleteNotifier,
        builder: (context, isComplete, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: Text("🗣️", style: TextStyle(fontSize: 60)),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent, // Vibrant blue
                      Colors.lightBlueAccent, // Cyan
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Good! Let's see how you pronounce it:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: PrettyDiffText(
                          defaultTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          addedTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          oldText: appContext.phrase,
                          newText: appContext.speakedPhrase,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
