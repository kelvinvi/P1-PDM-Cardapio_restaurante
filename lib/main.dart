import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'telas/login.dart';
import 'telas/menu.dart';
import 'telas/pedidos.dart';
import 'telas/detalhes_item.dart';
import 'telas/registro.dart';
import 'firebase_options.dart';
import 'telas/recuperar_senha.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const AppCardapioRestaurante(),
    ),
  );
}

class AppCardapioRestaurante extends StatefulWidget {
  const AppCardapioRestaurante({super.key});

  @override
  StateAppCardapioRestaurante createState() => StateAppCardapioRestaurante();
}

class StateAppCardapioRestaurante extends State<AppCardapioRestaurante> {
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
        '/': (context) => const TelaLogin(),
        '/menu': (context) => const TelaMenu(),
        '/carrinho': (context) => const TelaCarrinho(),
        '/detalhes': (context) => TelaDetalhesItem(),
        '/registro': (context) => const TelaRegistro(),
        '/recuperar-senha': (context) => const TelaRecuperarSenha(),
      },
      builder: DevicePreview.appBuilder,
    );
  }
}