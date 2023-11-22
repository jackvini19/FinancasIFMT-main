import 'package:financass/config/Rotas.dart';
import 'package:flutter/material.dart';
import 'package:financass/controllers/BancoController.dart';
import 'package:financass/models/BancoModel.dart';

class BancoScreen extends StatefulWidget {
  const BancoScreen({super.key});

  @override
  State<BancoScreen> createState() => _BancoScreenState();
}

class _BancoScreenState extends State<BancoScreen> {
  List<Banco> listaBancos = [];
  bool _isLoading = false;

  // Variáveis do Formulário
  final _bancoController = TextEditingController();
  final _agenciaController = TextEditingController();
  final _contaController = TextEditingController();
  final _saldoController = TextEditingController();
  final GlobalKey<FormState> _formBanco = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    getBancosFromApi();
  }

  void getBancosFromApi() async {
    var value = await getBanco(ip: AppRoutes.Ipservidor);
    setState(() {
      listaBancos = value;
    });
    _isLoading = false;
  }

  var appBar = AppBar(
    backgroundColor: const Color.fromARGB(255, 27, 75, 72),
    title: Text(
      'Lista de Bancos',
      style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
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
                        itemCount: listaBancos!.length,
                        itemBuilder: ((context, index) => ListTile(
                              title: Text('${listaBancos![index].banco}'),
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
                    builder: ((context) => AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Text(
                            'Adicionar Banco',
                            textAlign: TextAlign.center,
                          ),
                          content: SingleChildScrollView(
                            child: Container(
                              width: double.maxFinite,
                              height: maxSizeUtilBody * 0.54,
                              child: Form(
                                key: _formBanco,
                                child: Column(children: [
                                  TextFormField(
                                    validator: (banco) {
                                      String bancoDigitado = banco ?? '';
                                      if (bancoDigitado.isEmpty) {
                                        return 'Banco deve ser preenchido.';
                                      }
                                      return null;
                                    },
                                    controller: _bancoController,
                                    decoration: InputDecoration(
                                        labelText: 'Banco',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: maxSizeUtilBody * 0.02,
                                  ),
                                  TextFormField(
                                    validator: (agencia) {
                                      String agenciaDigitado = agencia ?? '';
                                      if (agenciaDigitado.isEmpty) {
                                        return 'Agência deve ser preenchido.';
                                      }
                                      return null;
                                    },
                                    controller: _agenciaController,
                                    decoration: InputDecoration(
                                        labelText: 'Agência',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: maxSizeUtilBody * 0.02,
                                  ),
                                  TextFormField(
                                    validator: (conta) {
                                      String contaDigitado = conta ?? '';
                                      if (contaDigitado.isEmpty) {
                                        return 'Conta deve ser preenchido.';
                                      }
                                      return null;
                                    },
                                    controller: _contaController,
                                    decoration: InputDecoration(
                                        labelText: 'Conta',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: maxSizeUtilBody * 0.02,
                                  ),
                                  TextFormField(
                                    validator: (saldo) {
                                      String saldoDigitado = saldo ?? '';
                                      if (double.tryParse(saldoDigitado)
                                          is double) {
                                        return null;
                                      }
                                      if (saldoDigitado.isEmpty) {
                                        return 'O Campo não pode ser vazio.';
                                      }
                                      return 'Valor informado não é válido.';
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    controller: _saldoController,
                                    decoration: InputDecoration(
                                        labelText: 'Saldo',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                child: Text(
                                  'Salvar',
                                ),
                                onPressed: () async {
                                  if (_formBanco.currentState!.validate()) {
                                    try {
                                      String msgRetorno = await salvarBanco(
                                          ip: AppRoutes.Ipservidor,
                                          banco: _bancoController.text,
                                          conta: _contaController.text,
                                          agencia: _agenciaController.text,
                                          saldo: double.parse(
                                              _saldoController.text));
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
                                                            'Banco cadastrado com sucesso') {
                                                          setState(() {
                                                            _bancoController
                                                                .text = '';
                                                            _agenciaController
                                                                .text = '';
                                                            _contaController
                                                                .text = '';
                                                            _saldoController
                                                                .text = '';
                                                            _isLoading = true;
                                                            getBancosFromApi();
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Ok'))
                                                ],
                                              ));
                                    } catch (e) {
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                title: Text('Erro'),
                                                content:
                                                    Text('${e.toString()}'),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Ok'))
                                                ],
                                              ));
                                    }
                                  }
                                })
                          ],
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
