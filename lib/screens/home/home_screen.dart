import 'package:corelabo_app_challenge/screens/toadd/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:corelabo_app_challenge/screens/account/account_screen.dart';
import 'package:corelabo_app_challenge/screens/announcement/announcement_screen.dart';
import 'package:corelabo_app_challenge/screens/categories/category_screen.dart';
import 'package:corelabo_app_challenge/screens/favorites/favorite_screen.dart';
import 'package:corelabo_app_challenge/database/db.dart';
import 'package:corelabo_app_challenge/models/annoucement_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _buscaController = TextEditingController();
  bool cliqueBusca = false;
  String buscaTexto = '';
  int paginaAtual = 0;
  late PageController pc;
  List<Anuncio> _anuncios = [];
  List<Anuncio> _anunciosFiltrados = [];
  List<String> historicoBusca = [];

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
    _loadAnuncios();
  }

  Future<void> _loadAnuncios() async {
    final anuncios = await DatabaseHelper().getAnuncios();
    setState(() {
      _anuncios = anuncios;
      _anunciosFiltrados = _filterAnuncios(buscaTexto);
    });
  }

  List<Anuncio> _filterAnuncios(String searchText) {
    if (searchText.isEmpty) {
      return _anuncios;
    } else {
      return _anuncios
          .where((anuncio) =>
              anuncio.titulo.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  void _cliqueBuscaMudou(String valor) {
    setState(() {
      buscaTexto = valor;
      _anunciosFiltrados = _filterAnuncios(buscaTexto);
    });
  }

  void _adicionarHistoricoBusca(String valor) {
    if (!historicoBusca.contains(valor) && valor.isNotEmpty) {
      setState(() {
        historicoBusca.add(valor);
      });
    }
  }

  void _realizarBusca(String termo) {
    setState(() {
      _buscaController.text = termo;
      buscaTexto = termo;
      _anunciosFiltrados = _filterAnuncios(buscaTexto);
    });
  }

  void setPaginaAtual(int pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _buscaController,
                  onChanged: (valor) {
                    _cliqueBuscaMudou(valor);
                    _adicionarHistoricoBusca(valor);
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    hintText: 'Buscar...',
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black54),
                onPressed: () {
                  setState(() {
                    cliqueBusca = !cliqueBusca;
                    if (!cliqueBusca) {
                      _buscaController.clear();
                      _cliqueBuscaMudou('');
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: cliqueBusca
          ? Column(
              children: [
                if (_anunciosFiltrados.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${_anunciosFiltrados.length} anúncio(s) encontrado(s)',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                Expanded(
                  child: _anunciosFiltrados.isEmpty
                      ? Center(child: Text('Resultado não encontrado'))
                      : ListView.builder(
                          itemCount: _anunciosFiltrados.length,
                          itemBuilder: (context, index) {
                            final anuncio = _anunciosFiltrados[index];
                            return ListTile(
                              title: Text(anuncio.titulo),
                            );
                          },
                        ),
                ),
                Divider(),
                Expanded(
                  child: ListView(
                    children: historicoBusca
                        .map((termo) => ListTile(
                              title: Text(termo),
                              trailing: IconButton(
                                icon: Icon(Icons.refresh),
                                onPressed: () => _realizarBusca(termo),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            )
          : PageView(
              controller: pc,
              onPageChanged: setPaginaAtual,
              children: const [
                AnnouncementScreen(),
                CategoryScreen(),
                AddScreen(),
                FavoriteScreen(),
                AccountScreen(),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Categorias'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Adicionar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Conta')
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
