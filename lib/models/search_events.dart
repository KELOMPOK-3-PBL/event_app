import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:uicons/uicons.dart';
import 'package:flutter/material.dart';

class SearchEvents {
  static SizedBox searchEvents() {
    return SizedBox(
      // height: 45,
      child: TextField(
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          isDense: true,
          alignLabelWithHint: true,
          hintText: 'Search event..',
          contentPadding: const EdgeInsets.all(16),
          hintStyle: const TextStyle(
              color: UIColor.typoGray, height: 1.5, fontSize: 14),
          //! -- icon search
          prefixIcon: Icon(
            UIcons.regularRounded.search,
            color: UIColor.typoBlack,
            size: 18,
          ),
          //! -- icon filter
          suffixIcon: Icon(
            UIcons.regularRounded.settings_sliders,
            color: UIColor.typoBlack,
            size: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: UIColor.bgSolidWhite,
        ),
        // overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
