import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  StateTelaLogin createState() => StateTelaLogin();
}

class StateTelaLogin extends State<TelaLogin> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void login() async {
    String email = emailController.text;
    String senha = senhaController.text;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      Navigator.pushReplacementNamed(context, '/menu');
    } catch (e) {
      mostrarMensagemErro('Erro ao fazer login: ${e.toString()}');
    }
  }

  void mostrarMensagemErro(String mensagem) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro'),
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
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text('Bem-vindo', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: login, child: const Text('Entrar')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/registro'),
                child: const Text('Criar Conta'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/recuperar-senha'),
                child: const Text('Esqueceu sua senha?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}