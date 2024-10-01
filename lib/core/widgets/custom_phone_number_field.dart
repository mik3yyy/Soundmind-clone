import 'package:flutter/material.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';

import 'package:sound_mind/core/extensions/context_extensions.dart';

class CustomPhoneNumber extends StatefulWidget {
  const CustomPhoneNumber({
    super.key,
    required this.phoneNumberController,
    required this.phoneNumberValue,
  });

  final TextEditingController phoneNumberController;
  final Function(String fullNumber) phoneNumberValue;

  @override
  State<CustomPhoneNumber> createState() => _CustomPhoneNumberState();
}

class _CustomPhoneNumberState extends State<CustomPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      height: 56,
      controller: widget.phoneNumberController,
      inputFormatters: const [],
      formatter: MaskedInputFormatter('### ### ####'),
      initCountry: CountryCodeModel(
        name: "Nigeria",
        dial_code: "+234",
        code: "NG",
      ),
      betweenPadding: 23,
      onInputChanged: (phone) {
        widget.phoneNumberValue(phone.fullNumber.trim().replaceAll(" ", ''));
      },

      // loadFromJson: loadFromJson,
      dialogConfig: DialogConfig(
        backgroundColor: context.colors.greyDecor,
        searchBoxBackgroundColor: const Color(0xFF56565a),
        searchBoxIconColor: const Color(0xFFFAFAFA),
        countryItemHeight: 55,
        topBarColor: const Color(0xFF1B1C24),
        selectedItemColor: const Color(0xFF56565a),
        selectedIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            "assets/check.png",
            width: 20,
            fit: BoxFit.fitWidth,
          ),
        ),
        textStyle: TextStyle(
            color: context.colors.borderGrey,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        searchBoxTextStyle: TextStyle(
            color: const Color(0xFFFAFAFA).withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w600),
        titleStyle: const TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 18,
            fontWeight: FontWeight.w700),
        searchBoxHintStyle: TextStyle(
            color: const Color(0xFFFAFAFA).withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
      countryConfig: CountryConfig(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: context.colors.greyOutline,
          ),
          color: context.colors.greyOutline,
          borderRadius: BorderRadius.circular(8),
        ),
        noFlag: false,
        textStyle: TextStyle(
          color: context.colors.black.withOpacity(.4),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      validator: (number) {
        // if (number.number.isEmpty) {
        //   return "The phone number cannot be left empty";
        // }
        // return null;
      },
      phoneConfig: PhoneConfig(
        focusedColor: context.colors.greyDecor,
        enabledColor: context.colors.greyDecor,
        errorColor: context.colors.greyDecor,
        labelStyle: null,
        labelText: null,
        floatingLabelStyle: null,
        focusNode: null,
        decoration: BoxDecoration(
          color: context.colors.greyDecor,
        ),
        radius: 8,
        hintText: "Phone Number",
        borderWidth: 2,
        backgroundColor: context.colors.greyDecor,
        popUpErrorText: true,
        autoFocus: false,
        showCursor: false,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        errorTextMaxLength: 2,
        errorPadding: const EdgeInsets.only(top: 14),
        errorStyle: const TextStyle(
          color: Color(0xFFFF5494),
          fontSize: 12,
          height: 1,
        ),
        textStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
