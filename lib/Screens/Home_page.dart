
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'tasks.dart';
import 'request.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    request(),
    tasks(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(222, 44, 44, 1),
                ),
                child: Text(
                  'Email Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Update the UI based on the drawer item selected
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.done_outline),
                title: Text('Done Tasks'),
                onTap: () {
                  // Update the UI based on the drawer item selected
                  Navigator.pushNamed(context,'donetasks'); // Close the drawer
                },
              ),
              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                  onTap: ()async{
                    await FirebaseAuth.instance.signOut();
                    setState(() {});
                    Navigator.pushReplacementNamed(context,'Login');
                  }
              ),
              ListTile(
                  leading: Icon(Icons.contact_support_outlined),
                  title: Text('Contact Us'),
                  onTap: (){
                    setState(() {});
                    Navigator.pushNamed(context,'contactUs');
                  }
              ),
              // Add more list tiles for additional items as needed
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'الصفحة الرئيسية',
                    ),
        ),
        body: _tabs[_currentIndex],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(158, 4, 4, 1),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: AlertDialog(
                      title: Text(
                        'شروط التبرع بالدم',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      content: Text(
                        'مهم يجب قرائتها جيدا',
                        style: TextStyle(
                          color: Color.fromRGBO(158, 4, 4, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      actions: <Widget>[
                        Text(
                          '1. يجب أن تكون في حالة صحية جيدة.            ',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '2. يجب أن يكون العمر بين 18 إلى 65 عامًا.                   ',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '3. يجب أن يكون الوزن على الأقل 50 كيلوجرام.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '4. يجب أن تكون نسبة الهيموجلوبين في الدم على الأقل 12.5 جم/ديسيلتر.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '5. يجب أن لا تكون قد تبرعت بالدم خلال الـ 56 يومًا الماضية.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '6. يجب أن لا تعاني من أي أمراض معدية.                            ',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '7. يجب أن لا تكون قد أجريت عملية جراحية كبيرة خلال الـ 6 أشهر الماضية.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '8. يجب أن لا تكون قد تلقيت نقلًا للدم خلال الـ 6 أشهر الماضية.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '9. يجب أن لا تكون حاملًا أو ترضع.                                     ',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '10. يجب أن لا تكون قد تناولت الكحول خلال الـ 48 ساعة الماضية.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '11. يجب أن لا تكون قد تناولت أي أدوية تؤثر على تخثر الدم.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'DonationForm');
                          },
                          child: Text('Accept'),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Color.fromRGBO(158, 4, 4, 1),
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.timelapse_outlined),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
                SizedBox(width: 50),
                // This is to create space in the middle for the FAB
                IconButton(
                  icon: Icon(Icons.task_alt),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
