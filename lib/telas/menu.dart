import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaMenu extends StatefulWidget {
  const TelaMenu({super.key});

  @override
  StateTelaMenu createState() => StateTelaMenu();
}

class StateTelaMenu extends State<TelaMenu> {
  List<Map<String, dynamic>> categorias = [];
  List<Map<String, dynamic>> carrinho = [];

  @override
  void initState() {
    super.initState();
    fetchCategorias();
  }

  fetchCategorias() async {
    final categoriasCollection = await FirebaseFirestore.instance.collection('categorias').get();
    final categoriasList = categoriasCollection.docs.map((doc) {
      Map<String, dynamic> categoria = {};
      if (doc.data().containsKey('nome')) categoria['nome'] = doc['nome'];
      if (doc.data().containsKey('descricao')) categoria['descricao'] = doc['descricao'];
      if (doc.data().containsKey('ordem')) categoria['ordem'] = doc['ordem'];
      return categoria;
    }).toList();

    setState(() {
      categorias = categoriasList;
    });
  }

  Future<List<Map<String, dynamic>>> fetchItens(String categoriaNome) async {
    final itensCollection = await FirebaseFirestore.instance
        .collection('itens_cardapio')
        .where('categoria', isEqualTo: categoriaNome)
        .get();

    return itensCollection.docs.map((doc) {
      Map<String, dynamic> item = {};
      if (doc.data().containsKey('nome')) item['nome'] = doc['nome'];
      if (doc.data().containsKey('descricao')) item['descricao'] = doc['descricao'];
      if (doc.data().containsKey('preco')) item['preco'] = doc['preco'];
      if (doc.data().containsKey('imagem')) item['imagem'] = doc['imagem'];
      if (doc.data().containsKey('ativo')) item['ativo'] = doc['ativo'];
      return item;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/carrinho',
                arguments: carrinho,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, categoriaIndex) {
          final categoria = categorias[categoriaIndex];

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchItens(categoria['nome']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("Nenhum item encontrado.");
              }

              final itens = snapshot.data!;

              return ExpansionTile(
                title: Text(categoria['nome'], style: const TextStyle(fontSize: 24)),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itens.length,
                    itemBuilder: (context, itemIndex) {
                      final produto = itens[itemIndex];

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/${produto['imagem']}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(produto['nome']),
                          subtitle: Text('R\$ ${produto['preco'].toStringAsFixed(2)}'),
                          onTap: () {
                            Navigator.pushNamed(
                              context, 
                              '/detalhes', 
                              arguments: {
                                'produto': produto,
                                'carrinho': carrinho
                              },
                            ).then((carrinhoAtualizado) {
                              if (carrinhoAtualizado != null && carrinhoAtualizado is List<Map<String, dynamic>>) {
                                setState(() {
                                  carrinho = List<Map<String, dynamic>>.from(carrinhoAtualizado);
                                });
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}