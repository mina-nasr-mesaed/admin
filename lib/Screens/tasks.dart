import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class tasks extends StatefulWidget {
  @override
  State<tasks> createState() => _historyState();
}

class _historyState extends State<tasks> {
  List <QueryDocumentSnapshot>data =[];

  bool isLoading = true;

  getData()async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Donation').where('state',isEqualTo:'Progress').get();
    data.addAll(querySnapshot.docs);
    isLoading =false;
    setState(() {

    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: isLoading== true? Center(child: CircularProgressIndicator()):Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 16/22,
              ),
              itemCount: data.length,
              itemBuilder: (context, int i) {
                return Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 170,
                            height: 60,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  offset: Offset(3, 3),
                                )
                              ],
                              color: Color.fromRGBO(56, 173, 12, 1.0),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(90)),
                            ),
                            child: Center(
                                child: Text(
                                  '${data[i]['state']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Text(
                                '${data[i]['hospital']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0,vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'الاسم : ${data[i]['fullname']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              child: Text(
                                'السن : ${data[i]['age']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0,vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'فصيلة الدم : ${data[i]['blood type']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              child: Text(
                                '${data[i]['phone']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0,vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${data[i]['service']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: Text(
                            'التاريخ المرضي : ${data[i]['history']}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseFirestore.instance.collection('Donation').doc(data[i].id).update({'state':'Done'});
                          setState(() {});
                          Navigator.of(context).pushReplacementNamed('Home');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(41, 124, 6, 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: double.infinity,
                              height: 60,
                              child: Center(
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],

                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        )
                      ]),
                );
              }),
        ),
      ),
    );
  }
}

//
//
// Center(
// child: Padding(
// padding: const EdgeInsets.all(20.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// CircleAvatar(
// radius: 70,
// backgroundColor: Colors.blue,
// child: Icon(
// Icons.person,
// size: 70,
// color: Colors.white,
// ),
// ),
// SizedBox(height: 20),
// Text(
// 'John Doe',
// style: TextStyle(
// fontSize: 28,
// fontWeight: FontWeight.bold,
// ),
// ),
// SizedBox(height: 10),
// Text(
// 'johndoe@example.com',
// style: TextStyle(
// fontSize: 20,
// color: Colors.grey[700],
// ),
// ),
// SizedBox(height: 5),
// Text(
// '+1234567890',
// style: TextStyle(
// fontSize: 20,
// color: Colors.grey[700],
// ),
// ),
// SizedBox(height: 20),
// Divider(
// height: 20,
// color: Colors.grey[400],
// ),
// SizedBox(height: 20),
// ProfileItem(
// icon: Icons.location_on,
// text: '123 Main Street, City, Country',
// ),
// ProfileItem(
// icon: Icons.calendar_today,
// text: 'Joined: January 1, 2022',
// ),
// ProfileItem(
// icon: Icons.work,
// text: 'Occupation: Software Engineer',
// ),
// ],
// ),
// ),
// ),

//
//
//
// class ProfileItem extends StatelessWidget {
//   final IconData icon;
//   final String text;
//
//   const ProfileItem({
//     Key? key,
//     required this.icon,
//     required this.text,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 28,
//             color: Colors.blue,
//           ),
//           SizedBox(width: 10),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.grey[700],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
