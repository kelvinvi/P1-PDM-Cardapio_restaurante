import 'package:flutter/material.dart';

class TelaRegistro extends StatefulWidget {
  final List<Map<String, String>> usuariosCadastrados;

  TelaRegistro({required this.usuariosCadastrados});

  @override
  StateTelaRegistro createState() => StateTelaRegistro();
}
class StateTelaRegistro extends State<TelaRegistro> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  void cadastrar() {
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
    widget.usuariosCadastrados.add({
      'nome': nome,
      'email': email,
      'senha': senha,
    });
    Navigator.pushReplacementNamed(context, '/');
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
        title: Text('Registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_add, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
              ),
              TextField(
                controller: confirmarSenhaController,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: cadastrar,
                child: Text('Criar Conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
