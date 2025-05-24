import 'package:flutter/material.dart';
import 'package:pronounceit/pages/steps/context.dart';
import 'package:provider/provider.dart';
import 'package:wheel_picker/wheel_picker.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class PhrasePicker extends StatelessWidget with WizardStep {
  PhrasePicker({super.key});

  @override
  Widget build(BuildContext context) {
    const phrases = [
      "Saturday I played soccer",
      "Sunday I went to the park",
      "Yesterday I read a book",
      "Last night I listened to music",
      "This morning I drank coffee",
      "Last week I traveled to the beach",
      "I walked the dog today",
      "I talked to my friend",
      "I ate pizza for dinner",
      "I slept early yesterday",
    ];

    final wheel = WheelPickerController(itemCount: phrases.length);

    const textStyle = TextStyle(
      fontSize: 15.0,
      height: 1.3,
      color: Colors.white,
    );

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
                      "Nice! Let's pick a phrase for you to practice your pronunciation:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: WheelPicker(
                        builder:
                            (context, index) =>
                                Text(phrases[index], style: textStyle),
                        controller: wheel,
                        selectedIndexColor: Colors.white,
                        onIndexChanged: (index, _) {
                          appContext.setPhrase(phrases[index]);
                          completeStep(true);
                        },
                        style: WheelPickerStyle(
                          itemExtent:
                              textStyle.fontSize! *
                              textStyle.height!, // Text height
                          squeeze: 1.25,
                          diameterRatio: .8,
                          surroundingOpacity: .25,
                          magnification: 1.2,
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
