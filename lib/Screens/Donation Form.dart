
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget/Button.dart';
import '../widget/constasts.dart';


class DonationForm extends StatefulWidget {
  @override
  _BloodDonationPageState createState() => _BloodDonationPageState();
}
class _BloodDonationPageState extends State<DonationForm> {
  bool val1 = false;
  onChangeFunctin1(bool newValue1) {
    setState(() {
      val1 = newValue1;
    });
  }


  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _selectedBloodType = '';
  String _selectedServiceType = '';
  String _selectedHospital = '';
  var phoneNumber= TextEditingController();
  var age=TextEditingController();
  var history=TextEditingController();
  var Fullname =TextEditingController();
  List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  List<String> _Hospital = [
    'مستشفي الطوارئ',
  'مستشفى الجراحة',
    'المستشفى الجامعي ',
    'مستشفى الأطفال الجامعي',
    'مستشفى القلب الجامعي',
    'مستشفى الأمراض الباطنة',
  ];
  List<String> _service = [
    'متبرع',
    'بحاجة الي التبرع',
    'تقديم المساعدة للمستشفي'
  ];
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    //String formattedTime = DateFormat('HH:mm:ss').format(now);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Blood Donation Form'),
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Enter your details:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: Fullname,
                    decoration: InputDecoration(
                      labelText: 'الاسم كامل',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    value:
                        _selectedServiceType.isNotEmpty ? _selectedServiceType : null,
                    items: _service.map((String service) {
                      return DropdownMenuItem(
                        value: service,
                        child: Text(service),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedServiceType = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'الخدمة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    value: _selectedBloodType.isNotEmpty ? _selectedBloodType : null,
                    items: _bloodTypes.map((String bloodType) {
                      return DropdownMenuItem(
                        value: bloodType,
                        child: Text(bloodType),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBloodType = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'فصيلة الدم',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الموبايل',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: age,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'السن',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // _phoneNumber = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                 Text(
                   'تاريخك الصحي',
                   style: TextStyle(fontWeight: FontWeight.w300),
                 ),
                 TextFormField(
                   controller: history,
                   maxLines: 8,
                   decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     hintText:
                         'من فضلك اكتب لنا حالتك الصحية والامراض التي تعاني منها',
                   ),
                 ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    value:
                    _selectedHospital.isNotEmpty ? _selectedHospital : null,
                    items: _Hospital.map((String Hospital) {
                      return DropdownMenuItem(
                        value: Hospital,
                        child: Text(Hospital),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedHospital = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'اختر المستشفي',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    children: [
                      customSwtich(
                          'لقد قرأت الشروط بعناية واستوفيت الشروط', val1, onChangeFunctin1),
                    ],
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    text: 'Submit',
                    onTap: () {
                      CollectionReference Ref =FirebaseFirestore.instance.collection('Donation');
                      Ref.add({
                        'fullname': Fullname.text,
                        'service': _selectedServiceType,
                        'blood type':_selectedBloodType,
                        'hospital':_selectedHospital,
                        'phone': phoneNumber.text,
                        'age':age.text,
                        'history':history.text,
                        'state':'Loading',
                        'date':formattedDate,

                      });
                      Navigator.pushReplacementNamed(context,'Home');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget customSwtich(String text, bool val, Function onChangeMehtod) {
  return Padding(
    padding: const EdgeInsets.only(
      right: 15.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        Spacer(),
        CupertinoSwitch(
            trackColor: Colors.grey,
            activeColor: kPrimarycolor,
            value: val,
            onChanged: (newValue) {
              onChangeMehtod(newValue);
            })
      ],
    ),
  );
}
