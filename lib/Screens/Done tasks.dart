import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class donetasks extends StatefulWidget {
  @override
  State<donetasks> createState() => _historyState();
}

class _historyState extends State<donetasks> {
  List <QueryDocumentSnapshot>data =[];

  bool isLoading = true;

  getData()async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Donation').where('state',isEqualTo:'Done').get();
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
      appBar: AppBar(

      ),
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
