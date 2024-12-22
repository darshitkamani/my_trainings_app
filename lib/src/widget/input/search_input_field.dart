import 'package:flutter/material.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

///SearchInputField
class SearchInputField extends StatelessWidget {
  ///SearchInputField Constructor
  const SearchInputField(
      {required this.searchController,
      this.suffixIcon,
      this.onChanged,
      super.key});

  ///Search Controller
  final TextEditingController searchController;

  ///On Changed
  final Function(String)? onChanged;

  ///Suffix icon
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onChanged,
      cursorColor: VariableUtilities.theme.greyColor,
      style: FontUtilities.h16(
          fontColor: VariableUtilities.theme.blackColor,
          fontWeight: FWT.semiBold),
      decoration: InputDecoration(
        prefixIcon:
            Icon(Icons.search, color: VariableUtilities.theme.greyColor),
        hintText: 'Search',
        hintStyle: FontUtilities.h16(
            fontColor: VariableUtilities.theme.greyColor,
            fontWeight: FWT.semiBold),
        // isDense: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: VariableUtilities.theme.greyColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: VariableUtilities.theme.greyColor)),
      ),
    );
  }
}
