import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    super.key,
    required this.question,
    required this.onNext,
  });

  final Map<String, String> question;

  final Function(int answer) onNext;
  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int selectedQuestion = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          widget.question['question']!,
          style: context.textTheme.displayMedium,
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Gap(15),
            itemCount: 4,
            reverse: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedQuestion = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: context.screenWidth * .8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                      color: selectedQuestion == index
                          ? context.primaryColor
                          : context.colors.greyOutline,
                    ),
                    color: selectedQuestion == index
                        ? context.secondaryColor
                        : context.colors.greyOutline,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: selectedQuestion == index
                            ? context.primaryColor
                            : context.colors.greyDecorDark,
                        child: Center(
                          child: Text(
                            index.toString(),
                            style: context.textTheme.bodyLarge?.copyWith(
                                color: selectedQuestion == index
                                    ? context.colors.white
                                    : context.colors.black),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.question[index.toString()]!,
                            style: context.textTheme.titleMedium?.copyWith(
                                color: selectedQuestion == index
                                    ? context.primaryColor
                                    : context.colors.black),
                          ),
                        ],
                      ).withExpanded(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Gap(50),
        CustomButton(
          label: "Next",
          onPressed: () {
            widget.onNext(selectedQuestion);
          },
          enable: selectedQuestion != -1,
        )
      ],
    );
  }
}
