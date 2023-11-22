import 'package:financass/common/gerenciamento.dart';
import 'package:financass/views/BancoPage/BancoScreen.dart';
import 'package:financass/views/CategoriaPage/CategoriasScreen.dart';
import 'package:financass/views/TipopagasPage/TipopagasScreen.dart';
import 'package:financass/views/CartaoPage/CartaoScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drawer extends StatefulWidget {
  const Drawer({super.key});

  @override
  State<Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Gerenciamento(pageController),
      child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          BancoScreen(),
          CategoriasScreen(),
          TipopagasScreen(),
          CartaoScreen(),
        ],
      ),
    );
  }
}
