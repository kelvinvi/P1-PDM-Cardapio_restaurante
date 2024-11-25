import 'package:flutter/material.dart';

class TelaCarrinho extends StatefulWidget {
  const TelaCarrinho({super.key});

  @override
  StateTelaCarrinho createState() => StateTelaCarrinho();
}

class StateTelaCarrinho extends State<TelaCarrinho> {
  late List<Map<String, dynamic>> carrinho;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      carrinho = arguments as List<Map<String, dynamic>>;
    } else {
      carrinho = [];
    }
  }

  void removerItem(int index) {
    setState(() {
      carrinho.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var item in carrinho) {
      total += item['preco'] * item['quantidade'];
    }

    Widget bodyContent;

    if (carrinho.isEmpty) {
      bodyContent = const Center(child: Text('O carrinho está vazio.'));
    } else {
      bodyContent = ListView.builder(
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          final item = carrinho[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['nome'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('Quantidade: ${item['quantidade']}'),
                        Text('Preço Unitário: R\$ ${item['preco'].toStringAsFixed(2)}'),
                        Text('Preço Total: R\$ ${(item['preco'] * item['quantidade']).toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (item['quantidade'] > 1) {
                                  item['quantidade']--;
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                item['quantidade']++;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              removerItem(index);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo do Pedido'),
      ),
      body: bodyContent,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total: R\$ ${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Pedido Confirmado'),
                    content: const Text('Seu pedido foi confirmado com sucesso!'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Confirmar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}