import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../navigation/bottom_button_approval.dart';
import '../widget/ui_colors.dart';

class FormProposeEvent extends StatefulWidget {
  const FormProposeEvent({super.key});

  @override
  FormProposeEventState createState() => FormProposeEventState();
}

class FormProposeEventState extends State<FormProposeEvent> {
  TextEditingController adminNoteController = TextEditingController(text: '-');

  // late ScrollController _scrollController;
  // bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   if (_scrollController.hasClients) {
    //     final isScrolled = _scrollController.offset > 200;
    //     if (isScrolled != _isScrolled) {
    //       setState(() {
    //         _isScrolled = isScrolled;
    //       });
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_scrollListener);
    // _scrollController.dispose();
    super.dispose();
  }

  // void _scrollListener() {
  //   if (_scrollController.offset > 200 && !_isScrolled) {
  //     setState(() {
  //       _isScrolled = true;
  //     });
  //   } else if (_scrollController.offset <= 200 && _isScrolled) {
  //     setState(() {
  //       _isScrolled = false;
  //     });
  //   }
  // }

  // Fungsi untuk mengubah status
  void _changeStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog();
      },
    );
  }

  // Fungsi untuk menampilkan dialog pengeditan
  void _showEditNoteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Admin Note"),
          content: TextField(
            controller: adminNoteController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter new admin note...",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Update admin note dengan teks baru dari controller
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            surfaceTintColor: UIColor.solidWhite,
            elevation: 0,
            // pinned: true,
            // expandedHeight: MediaQuery.of(context).size.width /
            //     1.4, //! Buat tinggi gambar berbanding dengan lebar layar
            leading: IconButton(
              color:
                  // _isScrolled ?
                  // UIColor.typoBlack,
                  // :
                  UIColor.typoBlack,
              icon: Icon(UIconsPro.regularRounded.angle_small_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            title: Text(
              "Propose Form",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    // _isScrolled ?
                    // UIColor.typoBlack,
                    // :
                    UIColor.typoBlack,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Title",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: UIColor.typoBlack),
                    ),
                  ),
                  // Container(
                  //   // margin: EdgeInsetsDirectional.only(bottom: 4),
                  //   width: double.infinity,
                  //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  //   decoration: BoxDecoration(
                  //     color: UIColor.solidWhite,
                  //     borderRadius: BorderRadius.circular(12),
                  //     // border: Border.all(color: Colors.grey[300]!),
                  //   ),
                  // child:
                  TextFormField(
                    expands: false,
                    // controller: _passwordController,
                    // focusNode: _passwordFocusNode,
                    // obscureText: securePassword,
                    cursorColor: UIColor.primary,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: UIColor.solidWhite,
                      labelText: 'Title',
                      // errorText: _passwordError,
                      floatingLabelStyle: TextStyle(
                          color:
                              // _passwordFocusNode.hasFocus
                              // ? UIColor.primary
                              //         :
                              UIColor.typoGray),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: UIColor.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            // color: _passwordFocusNode.hasFocus
                            //     ? UIColor.primary
                            //     : UIColor.typoGray
                            ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: UIColor.rejected),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: UIColor.rejected),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(
                        UIconsPro.regularRounded.head_side_thinking,
                        // color: _passwordFocusNode.hasFocus
                        //     ? UIColor.primary
                        //     : UIColor.typoGray,
                      ),
                      // suffixIcon: IconButton(
                      //     // color: _passwordFocusNode.hasFocus
                      //     //     ? UIColor.primary
                      //     //     : UIColor.typoGray,
                      //     onPressed: () {
                      //       // showhide();
                      //     },
                      //     icon: Icon(securePassword
                      //         ? UIconsPro.solidRounded.eye_crossed
                      //         : UIconsPro.solidRounded.eye)),
                    ),
                  ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomButtonApproval(
      //     changeStatus: _changeStatus, showEditNoteDialog: _showEditNoteDialog),
    );
  }
}
