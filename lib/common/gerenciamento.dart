import 'package:flutter/material.dart';

class Gerenciamento {
  PageController _pageController;
  int paginaAtual = 0;
  Gerenciamento(this._pageController);

  void setPage(int pagina) {
    if (pagina == paginaAtual) return;
    {
      paginaAtual = pagina;
      _pageController.jumpToPage(pagina);
    }
  }
}
