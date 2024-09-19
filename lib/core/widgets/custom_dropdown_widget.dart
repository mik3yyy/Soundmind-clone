import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemToString;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final String title;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.title,
    required this.itemToString,
    this.selectedItem,
    required this.onChanged,
    this.hintText = 'Select an item',
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const Gap(10),
        DropdownButtonHideUnderline(
          child: Container(
            height: 50,
            width: context.screenWidth,
            decoration: BoxDecoration(
              color: context.colors.greyOutline,
              borderRadius: BorderRadius.circular(6),
              // border: widget.border,
              // boxShadow:  [
              //         BoxShadow(
              //           color: Theme.of(context)
              //               .colorScheme
              //               .tertiary
              //               .withOpacity(0.2),
              //           spreadRadius: 0,
              //           blurRadius: 23,
              //           offset: Offset(0, 4), // changes position of shadow
              //         ),
              //       ]
            ),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<T>(
                menuWidth: context.screenWidth * .9,
                padding: EdgeInsets.symmetric(horizontal: 10),
                value: _selectedItem,
                hint: Text(widget.hintText),
                isExpanded: true,
                items: widget.items.map((T item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Container(
                      width: context.screenWidth *
                          .8, // Set the maximum width of the dropdown items
                      child: Text(
                        widget.itemToString(item),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (T? newValue) {
                  setState(() {
                    _selectedItem = newValue;
                  });
                  widget.onChanged(newValue);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
