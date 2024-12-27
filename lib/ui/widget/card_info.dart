import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter/widgets.dart';

Widget cardInfoRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      children: [
        Icon(icon, color: UIColor.primary, size: 10),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: UIColor.typoBlack,
            ),
            // maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget cardInfoCarouselRow(IconData icon, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(
        color: UIColor.solidWhite,
        icon,
        size: 12,
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: UIColor.solidWhite,
        ),
        textAlign: TextAlign.left,
      )
    ],
  );
}
