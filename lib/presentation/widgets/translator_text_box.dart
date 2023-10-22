import 'package:flutter/material.dart';

import '/core/constant/styles.dart';
import '/presentation/widgets/custom_card.dart';

class TranslatorTextBox extends StatefulWidget {
  const TranslatorTextBox({
    super.key,
    required this.title,
    required this.controller,
    this.readOnly = false,
    this.maxLength,
    this.maxLines,
    this.title2,
    this.hintText,
    this.onClearTap,
    this.onChanged,
  });
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;

  final String title;
  final String? title2;
  final String? hintText;
  final TextEditingController controller;
  final void Function()? onClearTap;
  final void Function(String)? onChanged;

  @override
  State<TranslatorTextBox> createState() => _TranslatorTextBoxState();
}

class _TranslatorTextBoxState extends State<TranslatorTextBox> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(widget.title),
              Text(
                widget.title2 ?? "",
                style: TextStyle(
                  color: colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
        CustomCard(
          padding: const EdgeInsets.symmetric(
              horizontal: paddingDefault, vertical: paddingDefault / 2),
          child: Column(
            children: [
              TextField(
                controller: widget.controller,
                maxLength: widget.maxLength ?? 2300,
                maxLines: widget.maxLines ?? 5,
                onChanged: (val) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(val);
                  }
                  setState(() => widget.controller.text);
                },
                readOnly: widget.readOnly,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Enter your text here',
                  hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.outline),
                  ),
                  counter: const SizedBox.shrink(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${widget.controller.text.length}/${widget.maxLength ?? 2300}"),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 2,
                      ),
                    ),
                    onPressed: widget.onClearTap,
                    child: const Text(
                      "Clear",
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
