import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'telas/login.dart';
import 'telas/menu.dart';
import 'telas/pedidos.dart';
import 'telas/detalhes_item.dart';
import 'telas/registro.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => AppCardapioRestaurante(),
    ),
  );
}

class AppCardapioRestaurante extends StatefulWidget {
  @override
  StateAppCardapioRestaurante createState() => StateAppCardapioRestaurante();
}

class StateAppCardapioRestaurante extends State<AppCardapioRestaurante> {
  final List<Map<String, String>> usuariosCadastrados = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardápio do Restaurante',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TelaLogin(usuariosCadastrados: usuariosCadastrados),
        '/menu': (context) => TelaMenu(),
        '/carrinho': (context) => TelaCarrinho(carrinho: []),
        '/detalhes': (context) => TelaDetalhesItem(),
        '/registro': (context) => TelaRegistro(usuariosCadastrados: usuariosCadastrados),
      },
      builder: DevicePreview.appBuilder,
    );
  }
}
