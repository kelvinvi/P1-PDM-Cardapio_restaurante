import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  final List<Map<String, String>> usuariosCadastrados;

  TelaLogin({required this.usuariosCadastrados});

  @override
  StateTelaLogin createState() => StateTelaLogin();
}

class StateTelaLogin extends State<TelaLogin> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void login() {
    String email = emailController.text;
    String senha = senhaController.text;

    bool usuarioValido = widget.usuariosCadastrados.any(
      (usuario) => usuario['email'] == email && usuario['senha'] == senha,
    );

    if (usuarioValido) {
      Navigator.pushReplacementNamed(context, '/menu');
    } else {
      mostrarMensagemErro('Email ou senha incorretos');
    }
  }

  void mostrarMensagemErro(String mensagem) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Erro'),
        content: Text(mensagem),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text('Bem-vindo', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(
                controller: senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: login, child: Text('Entrar')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/registro'),
                child: Text('Criar Conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
