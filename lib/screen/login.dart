import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  SharedPreferences? localStorage;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  void save() {
    localStorage!.setString('email', email);
    localStorage!.setString('pass', pass);
  }

  String email = '';
  String pass = '';
  var sh_email = '';
  var sh_pass = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  onSaved: (value) {
                    email = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "* Required";
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onSaved: (value) {
                    pass = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "* Required";
                    }
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      save();
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sh_email = localStorage!.getString('email')!;
                      sh_pass = localStorage!.getString('pass')!;
                    });
                  },
                  child: const Text('get'),
                ),
                Text('$sh_email'),
                Text('$sh_pass'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
