import 'package:flutter/material.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class OneStep extends StatelessWidget with WizardStep {
  OneStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: ValueListenableBuilder<bool>(
        valueListenable: isCompleteNotifier,
        builder: (context, isComplete, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'I am step ${stepNumber + 1} and I am ${isComplete ? 'complete' : 'incomplete'}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(
                onPressed: () {
                  completeStep(true);
                },
                child: Text('Press me'),
              ),
            ],
          );
        },
      ),
    );
  }
}
