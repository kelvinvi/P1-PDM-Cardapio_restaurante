import 'package:flutter/material.dart';

class TelaCarrinho extends StatefulWidget {
  final List<Map<String, dynamic>> carrinho;

  TelaCarrinho({required this.carrinho});

  @override
  StateTelaCarrinho createState() => StateTelaCarrinho();
}

class StateTelaCarrinho extends State<TelaCarrinho> {
  void removerItem(int index) {
    setState(() {
      widget.carrinho.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var item in widget.carrinho) {
      total += item['preco'] * item['quantidade'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do Pedido'),
      ),
      body: widget.carrinho.isEmpty
          ? Center(child: Text('O carrinho está vazio.'))
          : ListView.builder(
              itemCount: widget.carrinho.length,
              itemBuilder: (context, index) {
                final item = widget.carrinho[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['nome'], style: TextStyle(fontWeight: FontWeight.bold)),
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
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (item['quantidade'] > 1) {
                                        item['quantidade']--;
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      item['quantidade']++;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
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
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        color: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total: R\$ ${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Pedido Confirmado'),
                    content: Text('Seu pedido foi confirmado com sucesso!'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Text('Confirmar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
