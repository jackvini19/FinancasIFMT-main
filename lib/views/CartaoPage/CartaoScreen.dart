import 'package:financass/config/Rotas.dart';
import 'package:flutter/material.dart';
import 'package:financass/controllers/CartaoController.dart';
import 'package:financass/models/CartaoModel.dart';

class CartaoScreen extends StatefulWidget {
  const CartaoScreen({super.key});

  @override
  State<CartaoScreen> createState() => _CartaoScreenState();
}

class _CartaoScreenState extends State<CartaoScreen> {
  List<Cartao> listaCartoes = [];
  bool _isLoading = false;

  final _cartaoController = TextEditingController();
  final GlobalKey<FormState> _formCartoes = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    getCartoesFromApi();
  }

  void getCartoesFromApi() async {
    var value = await getCartao(ip: AppRoutes.Ipservidor);
    setState(() {
      listaCartoes = value;
    });
    _isLoading = false;
  }

  var appBar = AppBar(
    title: const Text(
      'Cartões',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: const Color.fromARGB(255, 27, 75, 72),
  );

  @override
  Widget build(BuildContext context) {
    var maxSizeUtilBody = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Color.fromARGB(75, 27, 75, 72),
        child: Column(
          children: [
            Container(
                child: _isLoading
                    ? LinearProgressIndicator(
                        minHeight: 5,
                      )
                    : Container(
                        height: maxSizeUtilBody * 0.85,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: listaCartoes.length,
                            itemBuilder: ((context, index) => ListTile(
                                  title: Text(
                                      '${listaCartoes[index].fechamento})'),
                                ))),
                      ))
          ],
        ),
      ),
    );
  }
}
