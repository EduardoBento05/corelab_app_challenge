import 'package:corelabo_app_challenge/models/annoucement_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'anuncios.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Cria a 'categorias' table
        await db.execute('''
          CREATE TABLE categorias(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT
          )
        ''');

        const categories = [
          'Anestésicos e Agulhas Gengival',
          'Resultado não encontrado',
          'Falta de internet',
          'Problemas com o servidor',
          'Ortodontia',
          'Endodontia',
          'Periféricos e Peças de Mão',
          'Moldagem',
          'Prótese',
          'Cimentos',
          'Instrumentos',
          'Cirurgia e Periodontia',
          'Radiologia'
        ];

        for (var category in categories) {
          await db.insert('categorias', {'nome': category},
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        await db.execute('''
          CREATE TABLE anuncios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            categoria_id INTEGER,
            imagem TEXT,
            FOREIGN KEY (categoria_id) REFERENCES categorias (id)
          )
        ''');
      },
    );
  }

  Future<void> insertCategoria(String nome) async {
    final db = await database;
    await db.insert('categorias', {'nome': nome},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCategorias() async {
    final db = await database;
    return await db.query('categorias');
  }

  Future<void> insertAnuncio(Anuncio anuncio) async {
    final db = await database;
    await db.insert('anuncios', anuncio.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Anuncio>> getAnuncios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('anuncios');

    return List.generate(maps.length, (i) {
      return Anuncio(
        id: maps[i]['id'],
        titulo: maps[i]['titulo'],
        categoriaId: maps[i]['categoria_id'],
        imagem: maps[i]['imagem'],
      );
    });
  }
}
