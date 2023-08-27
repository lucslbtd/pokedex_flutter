import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/update_password_page.dart';

class ConfirmPasswordPage extends StatefulWidget {
  final String password;

  const ConfirmPasswordPage({Key? key, required this.password})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmPasswordPageState createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  bool _obscureText = true;
  final confirmPasswordController = TextEditingController();
  String errorMessage = '';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _verifyCurrentPassword() {
    if (confirmPasswordController.text == widget.password) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UpdatePasswordPage(
            newPassword: '',
          ),
        ),
      );
    } else {
      setState(() {
        errorMessage = "A senha digitada não coincide com sua senha atual";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Trocar Senha',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Digite sua senha atual',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 48),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: '*******',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Material(
                  elevation: 5.0,
                  color: const Color.fromRGBO(23, 62, 165, 1),
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: _verifyCurrentPassword,
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
