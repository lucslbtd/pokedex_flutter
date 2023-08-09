import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/onboard_page.dart';
//import 'package:pokedex_flutter/screens/load_login.dart';
import 'package:pokedex_flutter/screens/login_success.dart';

class Login01 extends StatelessWidget {
  const Login01({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OnboardPage()),
              );
            }),
        title: const Text(
          'Entrar',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bem vindo de volta!',
              style: TextStyle(fontFamily: 'Poppins',fontSize: 24),
            ),
            const Text(
              'Preencha os dados',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 26),
            ),
            const SizedBox(height: 80),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Senha',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login01()),
                );
              },
              child: const Text(
                'Esqueceu sua senha?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color.fromRGBO(23, 62, 165, 1),
                ),
              ),
            ),
            const SizedBox(height: 100.0),
            Material(
              elevation: 5.0,
              color: const Color.fromRGBO(23, 62, 165, 1),
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginSuccess()),
                  );
                },
                minWidth: 200.0,
                height: 42.0,
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
