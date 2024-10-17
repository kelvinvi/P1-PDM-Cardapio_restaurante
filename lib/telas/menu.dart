import 'package:flutter/material.dart';
import 'pedidos.dart';

class TelaMenu extends StatefulWidget {
  @override
  StateTelaMenu createState() => StateTelaMenu();
}

class StateTelaMenu extends State<TelaMenu> {
  final List<Map<String, dynamic>> carrinho = [];

  final List<Map<String, dynamic>> categorias = [
    {
      'nome': 'Entradas',
      'itens': [
        {'nome': 'Bruschetta de Tomate com Manjericão', 'preco': 20.0, 'imagem': 'images/bruschetta.jpg', 'descricao': 'Bruschetta crocante com tomate fresco e manjericão.'},
        {'nome': 'Arancini Pomodoro', 'preco': 25.0, 'imagem': 'images/arancini.jpg', 'descricao': 'Bolinhos de arroz italianos recheados com queijo.'},
      ]
    },
    {
      'nome': 'Pratos Principais',
      'itens': [
        {'nome': 'Risotto de Cogumelos', 'preco': 50.0, 'imagem': 'images/risotto.jpg', 'descricao': 'Risotto cremoso com cogumelos frescos e parmesão.'},
        {'nome': 'Pizza Marguerita', 'preco': 40.0, 'imagem': 'images/pizza.jpg', 'descricao': 'Pizza clássica (8 fatias) com molho de tomate, manjericão e mussarela.'},
        {'nome': 'Lasanha', 'preco': 40.0, 'imagem': 'images/lasanha.jpg', 'descricao': 'Lasanha ao forno com camadas de carne, queijo mussarela e molho de tomate.'},
        {'nome': 'Spaguetti', 'preco': 30.0, 'imagem': 'images/spaguetti.jpg', 'descricao': 'Spaguetti com molho à bolonhesa e queijo parmesão.'},
      ]
    },
    {
      'nome': 'Bebidas',
      'itens': [
        {'nome': 'Vinho Tinto Suave', 'preco': 60.0, 'imagem': 'images/vinho.jpg', 'descricao': 'Garrafa de vinho tinto suave.'},
        {'nome': 'Coca-Cola', 'preco': 5.0, 'imagem': 'images/coca_cola.jpg', 'descricao': 'Coca-cola em lata (350 ml).'},
        {'nome': 'Suco de Laranja', 'preco': 10.0, 'imagem': 'images/suco_laranja.jpg', 'descricao': 'Copo de suco de laranja natural (450 ml).'},
        {'nome': 'Água', 'preco': 3.50, 'imagem': 'images/agua.jpg', 'descricao': 'Água mineral sem gás.'},
      ]
    },
    {
      'nome': 'Sobremesas',
      'itens': [
        {'nome': 'Gelato de Pistache', 'preco': 20.0, 'imagem': 'images/gelato.jpg', 'descricao': 'Gelato cremoso de pistache na casquinha.'},
        {'nome': 'Panna Cotta', 'preco': 15.0, 'imagem': 'images/panna_cotta.jpg', 'descricao': 'Sobremesa italiana clássica com calda de frutas.'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardápio'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCarrinho(carrinho: carrinho),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          return ExpansionTile(
            title: Text(categoria['nome'], style: TextStyle(fontSize: 24)),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoria['itens'].length,
                itemBuilder: (context, itemIndex) {
                  final produto = categoria['itens'][itemIndex];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.asset(produto['imagem'], width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(produto['nome']),
                      subtitle: Text('R\$ ${produto['preco'].toStringAsFixed(2)}'),
                      onTap: () {
                        Navigator.pushNamed(context, '/detalhes', arguments: {'produto': produto, 'carrinho': carrinho});
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}