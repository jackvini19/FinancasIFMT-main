import 'package:financass/common/gerenciamento.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleDrawer extends StatelessWidget {
  final IconData iconData;
  final String titulo;
  final int pagina;
  const TitleDrawer({
    super.key,
    required this.iconData,
    required this.pagina,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<Gerenciamento>().paginaAtual;
    Color setColor = currentPage == pagina
        ? Color.fromARGB(255, 15, 66, 55)
        : Color.fromARGB(255, 95, 95, 95);
    return InkWell(
      onTap: () {
        context.read<Gerenciamento>().setPage(pagina);
      },
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Icon(
                iconData,
                size: 30,
                color: setColor,
              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            Text(
              titulo,
              style: TextStyle(
                fontSize: 16,
                color: setColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
