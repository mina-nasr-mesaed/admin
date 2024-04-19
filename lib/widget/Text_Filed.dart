// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:blood_donation/widgets/constasts.dart';
//
// class TextBorder extends StatelessWidget {
//   TextBorder({required this.hintText, this.onchange,required this.TextType});
// TextEditingController TextType;
//   String? hintText;
//   Function(String)? onchange;
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//        controller: TextType,
//       keyboardType: TextInputType.visiblePassword,
//       cursorColor: kPrimarycolor,
//       autocorrect: true,
//       decoration: InputDecoration(
//         //suffixIcon: Icon(Icons.password),
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: kPrimarycolor,
//           ),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: kPrimarycolor),
//         ),
//         labelText: hintText,
//         labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
//       ),
//       onChanged: onchange,
//     );
//   }
// }
//
// class TextNoBorder extends StatelessWidget {
//   TextNoBorder({required this.hintText, this.onchange,required this.TextType});
//   TextEditingController TextType;
//   String? hintText;
//   Function(String)? onchange;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: TextFormField(
//          controller: TextType,
//         keyboardType: TextInputType.visiblePassword,
//         cursorColor: kPrimarycolor,
//         autocorrect: true,
//         decoration: InputDecoration(
//           //suffixIcon: Icon(Icons.password),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: kPrimarycolor,
//             ),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: kPrimarycolor),
//           ),
//           labelText: hintText,
//           labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
//         ),
//         onChanged: (text) {},
//       ),
//     );
//   }
// }
