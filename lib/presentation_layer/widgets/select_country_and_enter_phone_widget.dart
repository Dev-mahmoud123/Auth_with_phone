
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/my_colors.dart';

class SelectCountryAndEnterPhoneWidget  extends StatelessWidget {
  final void Function(String?) onSaved ;
  const SelectCountryAndEnterPhoneWidget ({Key? key, required this.onSaved}) : super(key: key);

  /// TODO: Generate Country Flag
  String generateCountryFlag() {
    String countryCode = 'eg';
    // toUpperCase() Make all characters uppercase
    // eg → EG
    // RegExp(r'[A-Z]') Select each character with regex
    // replaceAllMapped() Get each matched character
    // e
    // g
    // codeUnitAt(0) Convert each character to a rune
    // 85
    // 83
    // + 127397 Add 127387
    // 85 + 127397 = 127482
    // 83 + 127397 = 127480
    // fromCharCode() Convert the rune to a string (flag emoji)
    // e + g = eg
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 4.0, vertical: 13.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.lightWhite,
                width: 1.0,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    generateCountryFlag() + ' +20',
                    style: const TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),

        /// TODO: Enter phone number
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 5.0, vertical: 1.0),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.myBlue, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'phone number',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone number must not be empty';
                } else if (value.length < 11) {
                  return 'Too short number';
                }
                return null;
              },
              onSaved: onSaved,
            ),
          ),
        )
      ],
    );
  }
}
