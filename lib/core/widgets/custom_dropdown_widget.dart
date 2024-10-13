import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemToString;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final String title;
  final bool useSearch; // New parameter to toggle between dropdown types

  const CustomDropdown({
    super.key,
    required this.items,
    required this.title,
    required this.itemToString,
    this.selectedItem,
    required this.onChanged,
    this.hintText = 'Select an item',
    this.useSearch = false, // Defaults to not using the search dropdown
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
        if (widget.useSearch)
          // Use DropdownSearch when useSearch is true
          DropdownSearch<T>(
            items: (filter, infiniteScrollProps) =>
                widget.items, // Directly pass the static list here
            selectedItem: _selectedItem,
            compareFn: (T item1, T item2) =>
                widget.itemToString(item1) ==
                widget.itemToString(item2), // Compare items

            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              showSearchBox: true, // Enable search box
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  filled: true,
                  fillColor: context.colors.greyOutline,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  hintText: widget.hintText,
                ),
              ),
            ),
            dropdownBuilder: (context, selectedItem) {
              return Text(
                selectedItem != null
                    ? widget.itemToString(selectedItem)
                    : widget.hintText,
                style: TextStyle(
                  color: selectedItem != null ? Colors.black : Colors.grey,
                ),
              );
            },
            onChanged: (T? newValue) {
              setState(() {
                _selectedItem = newValue;
              });
              widget.onChanged(newValue);
            },
          )
        else
          // Use your original DropdownButton when useSearch is false
          DropdownButtonHideUnderline(
            child: Container(
              height: 50,
              width: context.screenWidth,
              decoration: BoxDecoration(
                color: context.colors.greyOutline,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<T>(
                  menuMaxHeight: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: _selectedItem,
                  hint: Text(widget.hintText),
                  isExpanded: true,
                  items: widget.items.map((T item) {
                    return DropdownMenuItem<T>(
                      value: item,
                      child: SizedBox(
                        width: context.screenWidth *
                            .8, // Limit dropdown item width
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
