class Anuncio {
  final int? id;
  final String titulo;
  final int categoriaId;
  final String imagem;

  Anuncio({
    this.id,
    required this.titulo,
    required this.categoriaId,
    required this.imagem,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'categoria_id': categoriaId,
      'imagem': imagem,
    };
  }
}
