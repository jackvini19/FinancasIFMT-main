import 'package:financass/config/Rotas.dart';
import 'package:financass/controllers/TipopagasController.dart';
import 'package:financass/models/TipopagasModel.dart';
import 'package:flutter/material.dart';

class TipopagasScreen extends StatefulWidget {
  const TipopagasScreen({super.key});

  @override
  State<TipopagasScreen> createState() => _TipopagasScreenState();
}

class _TipopagasScreenState extends State<TipopagasScreen> {
  List<Tipopagas> listaTipopagas = [];
  bool _isLoading = false;

  final _tipoController = TextEditingController();
  final GlobalKey<FormState> _formTipopagas = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    getTipopagasFromApi();
  }

  void getTipopagasFromApi() async {
    var value = await getTipopagas(ip: AppRoutes.Ipservidor);
    setState(() {
      listaTipopagas = value;
    });
    _isLoading = false;
  }

  var appBar = AppBar(
    title: Text(
      'Tipo de Pagamento',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Color.fromARGB(255, 27, 75, 72),
  );

  @override
  Widget build(BuildContext context) {
    var maxSizeUtilBody = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

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
                        itemCount: listaTipopagas.length,
                        itemBuilder: ((context, index) => ListTile(
                              title: Text('${listaTipopagas[index].tipo}'),
                            )),
                      ),
                    ),
            ),
            FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Color.fromARGB(255, 27, 75, 72),
                onPressed: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Text(
                            'Adicionar Tipo de Pagamento',
                            textAlign: TextAlign.center,
                          ),
                          content: SingleChildScrollView(
                            child: Container(
                              width: double.maxFinite,
                              height: maxSizeUtilBody * 0.19,
                              child: Form(
                                  key: _formTipopagas,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        validator: (tipo) {
                                          String tipoDigitado = tipo ?? '';
                                          if (tipoDigitado.isEmpty) {
                                            return 'Tipo de Pagamento deve ser informado.';
                                          }
                                          return null;
                                        },
                                        controller: _tipoController,
                                        decoration: InputDecoration(
                                            labelText: 'Tipo',
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
                                if (_formTipopagas.currentState!.validate()) {
                                  try {
                                    String msgRetorno = await salvarTipopagas(
                                        ip: AppRoutes.Ipservidor,
                                        tipo: _tipoController.text);
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
                                                          'Tipo de Pagamento cadastrado com sucesso') {
                                                        setState(() {
                                                          _tipoController.text =
                                                              '';
                                                          _isLoading = true;
                                                          getTipopagasFromApi();
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                      Navigator.of(context)
                                                          .pop();
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
                      });
                }),
          ],
        ),
      ),
    );
  }
}
