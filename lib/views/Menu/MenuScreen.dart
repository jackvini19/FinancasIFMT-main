import 'package:financass/views/BancoPage/BancoScreen.dart';
import 'package:financass/views/CategoriaPage/CategoriasScreen.dart';
import 'package:financass/views/TipopagasPage/TipopagasScreen.dart';
import 'package:financass/views/CartaoPage/CartaoScreen.dart';
import 'package:flutter/material.dart';

class BottonScreen extends StatefulWidget {
  const BottonScreen({Key? key});

  @override
  State<BottonScreen> createState() => _BottonScreenState();
}

class _BottonScreenState extends State<BottonScreen> {
  int _selecionadoIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOpcao = <Widget>[
    CategoriasScreen(),
    CartaoScreen(),
    TipopagasScreen(),
    Text(
      'index 2 : teste',
      style: optionStyle,
    ),
  ];

  void _onItemSelecionado(int index) {
    setState(() {
      _selecionadoIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dropdown'),
      ),
      body: Center(
        child: _widgetOpcao.elementAt(_selecionadoIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Extratos',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Lançamentos',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Pagamentos',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Saida',
            backgroundColor: Colors.blueGrey,
          ),
        ],
        currentIndex: _selecionadoIndex,
        selectedItemColor: const Color.fromARGB(255, 8, 8, 8),
        onTap: _onItemSelecionado,
      ),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 75, 72),
        title: Text(
          'Menu',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(75, 27, 75, 72),
        child: Column(
          children: [
            Align(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TipopagasScreen()),
                  );
                },
                child: Text('Lista de Tipos Pagamentos',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ),
            Align(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CategoriasScreen()),
                  );
                },
                child: Text('Lista de Categorias',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ),
            Align(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BancoScreen()),
                  );
                },
                child: Text('Lista de Bancos',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ),
            Align(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartaoScreen()),
                  );
                },
                child: Text('Lista de Cartões',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
