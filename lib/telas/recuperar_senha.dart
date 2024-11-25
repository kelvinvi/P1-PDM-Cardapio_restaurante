import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaRecuperarSenha extends StatefulWidget {
  const TelaRecuperarSenha({super.key});

  @override
  State<TelaRecuperarSenha> createState() => TelaRecuperarSenhaState();
}

class TelaRecuperarSenhaState extends State<TelaRecuperarSenha> {
  final emailController = TextEditingController();

  void recuperarSenha() async {
    String email = emailController.text;

    if (email.isEmpty) {
      mostrarMensagem('Por favor, insira seu email.');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      mostrarMensagem('Email de recuperação enviado! Verifique sua caixa de entrada.');
    } catch (e) {
      mostrarMensagem('Erro ao enviar email: ${e.toString()}');
    }
  }

  void mostrarMensagem(String mensagem) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Recuperação de Senha'),
        content: Text(mensagem),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Senha')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Digite seu email para recuperar a senha',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: recuperarSenha,
                child: const Text('Enviar Email de Recuperação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
