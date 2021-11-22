import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Page1()));
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('OneStep')),
        body: MyCustomForm(),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Abinwc')),
          ListTile(
              title: Text('Reels'),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              title: Text('Liked Videos'),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              title: Text('Streak'),
              onTap: () {
                Navigator.pop(context);
              })
        ])));
  }
}

//Form Widget
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

//Corresponding State class of the form
//All data of the form is present in this class
class MyCustomFormState extends State<MyCustomForm> {
// Setting a global key for uniquely finding the Form widget
// It is helpful doing form validations.
// Note : Its GlobalKey<FormState>() . Not GlobalKey<MyCustomFormState>()

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Using the global key to create a form.
    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.all(32.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Name'),
                  //The validator receives the value the user enters
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  })),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        //Validate return true if the validation passes , else returns false.
                        if (_formKey.currentState!.validate()) {
                          //If form is valid we display a SnackBar with the user entered data.
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Processing data.')));
                          Navigator.of(context).push(_createRoute());
                        }
                      },
                      child: const Text('Submit'))))
        ]));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.1);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: const Center(child: Text('Page 2')));
  }
}
