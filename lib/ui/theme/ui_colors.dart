import 'package:flutter/material.dart';

class UIColor {
  UIColor._();

  static const Color typoBlack = Color(0xff000000);
  static const Color typoGray = Color(0xff747688);
  static const Color typoGray2 = Color(0xcccccccc);
  static const Color shadowColor = Colors.black26;

  static const Color solidWhite = Color(0xffffffff);
  static const Color white = Color(0xfff6f6f6);

  static const Color primary = Color(0xff1886ea);
  static const Color admin = Color(0xff5856d6);
  static const Color propose = Color(0xff32ade6);
  static const Color member = Color(0xff00c7be);
  static const Color superadmin = Color(0xffaf52de);
  static const Color approved = Color(0xff34c759);
  static const Color rejected = Color(0xfff0635a);
  static const Color pending = Color(0xffff7D2D);
  static const Color reviewing = Color(0xfffaad14);

  // static const Color bgCarousel = Color.fromARGB(233, 250, 250, 250);
  static const Color bgCarousel = Color.fromARGB(255, 0, 0, 0);

  static Color getStatusColor(String status) {
    if (status == "Proposed") {
      return UIColor.propose;
    } else if (status == "Pending") {
      return UIColor.pending;
    } else if (status == "Reviewing") {
      return UIColor.reviewing;
    } else if (status == "Approved") {
      return UIColor.approved;
    } else if (status == "Rejected") {
      return UIColor.rejected;
    } else {
      return UIColor.admin;
    }
  }

  static Color getRoleColor(String role) {
    if (role == "Superadmin") {
      return UIColor.superadmin;
    } else if (role == "Admin") {
      return UIColor.admin;
    } else if (role == "Propose") {
      return UIColor.propose;
    } else if (role == "Member") {
      return UIColor.member;
    } else {
      return UIColor.typoGray2;
    }
  }
}
