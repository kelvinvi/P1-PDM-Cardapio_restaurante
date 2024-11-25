import 'package:flutter/material.dart';

class TelaDetalhesItem extends StatefulWidget {
  @override
  StateTelaDetalhesItem createState() => StateTelaDetalhesItem();
}

class StateTelaDetalhesItem extends State<TelaDetalhesItem> {
  int quantidade = 1;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? dados = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (dados == null || !dados.containsKey('produto') || !dados.containsKey('carrinho')) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Erro"),
        ),
        body: Center(child: Text("Dados não encontrados")),
      );
    }

    final produto = dados['produto'] as Map<String, dynamic>;
    final List<Map<String, dynamic>> carrinho = List<Map<String, dynamic>>.from(dados['carrinho']);

    return Scaffold(
      appBar: AppBar(
        title: Text(produto['nome']),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/${produto['imagem']}',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                produto['nome'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                produto['descricao'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'R\$ ${produto['preco'].toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Quantidade:', style: TextStyle(fontSize: 16)),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantidade > 1) {
                              quantidade--;
                            }
                          });
                        },
                      ),
                      Text('$quantidade', style: TextStyle(fontSize: 16)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantidade++;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bool itemExistente = false;
                      for (var item in carrinho) {
                        if (item['nome'] == produto['nome']) {
                          item['quantidade'] += quantidade;
                          itemExistente = true;
                          break;
                        }
                      }
                      if (!itemExistente) {
                        carrinho.add({
                          'nome': produto['nome'],
                          'preco': produto['preco'],
                          'quantidade': quantidade,
                        });
                      }
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Item Adicionado'),
                          content: Text('${produto['nome']} foi adicionado ao carrinho!'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(ctx);
                                Navigator.pop(context, carrinho);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Adicionar ao Carrinho'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
