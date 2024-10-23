import 'package:event_proposal_app/presentation/widget/ui_colors.dart';
import 'package:flutter/widgets.dart';

Widget cardInfoRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      children: [
        Icon(icon, color: UIColor.typoGray, size: 10),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: UIColor.typoBlack,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
