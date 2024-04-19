import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../widget/Button.dart';

class request extends StatefulWidget {
  const request({super.key});

  @override
  State<request> createState() => _requestState();
}

class _requestState extends State<request> {
  List <QueryDocumentSnapshot>data =[];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;


  searchResultList(){
    var showResult = [];
    if(_searchController.text != ''){
      for(var clientSnapshot in data)
      {
        var name = clientSnapshot['fullname'].toString().toLowerCase();
        if(name.contains(_searchController.text.toLowerCase()))
          {
            showResult.add(clientSnapshot);
          }
      }
    }else{showResult =List.from(data);}
    setState(() {
      _resultList = showResult;
    });
  }
  getData()async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Donation').where('state',isEqualTo:'Loading').get();
    data.addAll(querySnapshot.docs);
    isLoading =false;
    setState(() {

    });
    searchResultList();
  }
  @override
  void initState() {

    _searchController.addListener(_onSearchChanged);
    super.initState();
  }
  _onSearchChanged(){
    print(_searchController.text);
    searchResultList;
  }
  void dispose(){
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        //title: CupertinoSearchTextField(
          //controller: _searchController,
        //),
        elevation: 0,
      ),
      body: isLoading== true? Center(child: CircularProgressIndicator()): Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 16/25,
              ),
              itemCount: _resultList.length,
              itemBuilder: (context, int i) {
                return Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 60,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  offset: Offset(3, 3),
                                )
                              ],
                              color: Color.fromRGBO(158, 4, 4, 1),
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
                          Column(children:
                          [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                              child: Text(
                                '${data[i]['hospital']}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                              child: Text(
                                '${data[i]['date']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0,vertical: 16),
                        child: Row(
                          children: [
                            Text(
                              'الاسم : ${_resultList[i]['fullname']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 30,),
                            Text(
                              'السن : ${_resultList[i]['age']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
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
                                'فصيلة الدم : ${_resultList[i]['blood type']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              child: Text(
                                '${_resultList[i]['phone']}',
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
                                '${_resultList[i]['service']}',
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
                          await FirebaseFirestore.instance.collection('Donation').doc(data[i].id).update({'state':'Progress'});
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
                                  'Accept',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          text: 'Cancel',
                          onTap: () async {
                            await FirebaseFirestore.instance.collection('Donation').doc(data[i].id).delete();
                            setState(() {});
                            Navigator.of(context).pushReplacementNamed('Home');

                          },
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
