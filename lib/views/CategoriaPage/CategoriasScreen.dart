import 'package:financass/config/Rotas.dart';
import 'package:financass/controllers/CategoriasController.dart';
import 'package:financass/models/CategoriasModel.dart';
import 'package:flutter/material.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  List<Categorias> listaCategorias = [];
  bool _isLoading = false;

  final _categoriaController = TextEditingController();
  final GlobalKey<FormState> _formCategorias = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    getCategoriasFromApi();
  }

  void getCategoriasFromApi() async {
    var value = await getCategorias(ip: AppRoutes.Ipservidor);
    setState(() {
      listaCategorias = value;
    });
    _isLoading = false;
  }

  var appBar = AppBar(
    title: const Text(
      'Tipo de Categoria',
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
                    ? const LinearProgressIndicator(
                        minHeight: 5,
                      )
                    : Container(
                        height: maxSizeUtilBody * 0.85,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: listaCategorias.length,
                            itemBuilder: ((context, index) => ListTile(
                                  title: Text(
                                      '${listaCategorias[index].categoria}'),
                                ))),
                      )),
            FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Color.fromARGB(255, 27, 75, 72),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Text(
                        'Adicionar Categoria',
                        textAlign: TextAlign.center,
                      ),
                      content: SingleChildScrollView(
                        child: Container(
                          width: double.maxFinite,
                          height: maxSizeUtilBody * 0.19,
                          child: Form(
                              key: _formCategorias,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (tipo) {
                                      String tipoDigitado = tipo ?? '';
                                      if (tipoDigitado.isEmpty) {
                                        return 'Categoria deve ser informado.';
                                      }
                                      return null;
                                    },
                                    controller: _categoriaController,
                                    decoration: InputDecoration(
                                        labelText: 'Nome da Categoria',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  )
                                ],
                              )),
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          child: Text('Salvar'),
                          onPressed: () async {
                            if (_formCategorias.currentState!.validate()) {
                              try {
                                String msgRetorno = await salvarCategorias(
                                    ip: AppRoutes.Ipservidor,
                                    categoria: _categoriaController.text);
                                // ignore: use_build_context_synchronously
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: Text('Mensagem API'),
                                          content: Text('${msgRetorno}'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (msgRetorno ==
                                                      'Categoria cadastrada com sucesso') {
                                                    setState(() {
                                                      _categoriaController
                                                          .text = '';
                                                      _isLoading = true;
                                                      getCategoriasFromApi();
                                                    });
                                                    Navigator.of(context).pop();
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'))
                                          ],
                                        ));
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: Text('Erro'),
                                          content: Text('${e.toString()}'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            )
                                          ],
                                        ));
                              }
                            }
                          },
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
