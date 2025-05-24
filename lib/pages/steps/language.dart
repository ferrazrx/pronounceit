import 'package:flutter/material.dart';
import 'package:pronounceit/pages/steps/context.dart';
import 'package:provider/provider.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class LanguagePicker extends StatelessWidget with WizardStep {
  LanguagePicker({super.key});

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
                  child: Text("🌍", style: TextStyle(fontSize: 60)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purpleAccent, // Vibrant blue
                      Colors.pink, // Cyan
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
                      "Let's start selecting a language to practice our pronunciation:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            appContext.setLanguage("en_US");
                            completeStep(true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border:
                                  appContext.language == "en_US"
                                      ? Border.all(
                                        color: Colors.white,
                                        width: 5,
                                      )
                                      : Border.all(
                                        color: Colors.transparent,
                                        width: 5,
                                      ), // No border if condition is false
                            ),
                            child: Image.asset("assets/us.png", width: 60),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            appContext.setLanguage("pt_BR");
                            completeStep(true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border:
                                  appContext.language == "pt_BR"
                                      ? Border.all(
                                        color: Colors.white,
                                        width: 5,
                                      )
                                      : Border.all(
                                        color: Colors.transparent,
                                        width: 5,
                                      ), // No border if condition is false
                            ),
                            child: Image.asset("assets/brazil.png", width: 60),
                          ),
                        ),
                      ],
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
