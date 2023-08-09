import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'load_login.dart'; // Importe a biblioteca do Firebase Auth

class NamePage extends StatefulWidget {
  final String email;
  final String password;

  const NamePage({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quase lá...',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Qual é o seu nome?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 48),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: widget.email,
                    password: widget.password,
                  );

                  // Se a conta for criada com sucesso, podemos adicionar o nome do usuário ao perfil
                  userCredential.user?.updateDisplayName(name);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadLoginScreen()),
                  );

                  // Aqui, você pode navegar para a tela principal ou mostrar uma mensagem de sucesso
                  // Por exemplo: Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                } catch (e) {
                  if (kDebugMode) {
                    print('Erro ao criar a conta: $e');
                  }
                  // Aqui, você pode mostrar uma mensagem de erro ao usuário
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Finalizar'),
            ),
          ],
        ),
      ),
    );
  }
}
