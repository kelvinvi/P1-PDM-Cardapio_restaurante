import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaRegistro extends StatefulWidget {
  const TelaRegistro({super.key});

  @override
  StateTelaRegistro createState() => StateTelaRegistro();
}

class StateTelaRegistro extends State<TelaRegistro> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  Future<void> cadastrar() async {
    final nome = nomeController.text;
    final email = emailController.text;
    final senha = senhaController.text;
    final confirmarSenha = confirmarSenhaController.text;

    if (nome.isEmpty || email.isEmpty || senha.isEmpty || confirmarSenha.isEmpty) {
      mostrarMensagemErro('Todos os campos devem ser preenchidos');
      return;
    }
    if (senha != confirmarSenha) {
      mostrarMensagemErro('As senhas não coincidem');
      return;
    }
    if (email.length < 6 || !email.contains('@') || !email.contains('.')) {
      mostrarMensagemErro('Email inválido');
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user?.uid).set({
        'nome': nome,
        'email': email,
      });

      Navigator.pushReplacementNamed(context, '/');  
    } catch (e) {
      mostrarMensagemErro('Erro ao criar conta: ${e.toString()}');
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
            onPressed: () {
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
              ),
              TextField(
                controller: confirmarSenhaController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: cadastrar,
                child: const Text('Criar Conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}