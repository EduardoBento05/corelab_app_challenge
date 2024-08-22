import 'dart:io';

import 'package:corelabo_app_challenge/database/db.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/annoucement_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _tituloController = TextEditingController();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _selectedCategory;
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categories = await DatabaseHelper().getCategorias();
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _saveAd() async {
    final title = _tituloController.text;
    final category =
        _selectedCategory != null ? int.tryParse(_selectedCategory!) : null;

    if (title.isNotEmpty && category != null && _imageFile != null) {
      final anuncio = Anuncio(
        titulo: title,
        categoriaId: category,
        imagem: _imageFile!.path,
      );

      await DatabaseHelper().insertAnuncio(anuncio);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anúncio salvo com sucesso!')),
      );

      _tituloController.clear();
      setState(() {
        _selectedCategory = null;
        _imageFile = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Anúncio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
              ),
              items: _categories.map<DropdownMenuItem<String>>((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(category['nome']),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            _imageFile != null
                ? Image.file(
                    File(_imageFile!.path),
                    height: 150,
                  )
                : const SizedBox(
                    height: 150,
                    child: Center(child: Text('Nenhuma imagem selecionada')),
                  ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Escolher Imagem'),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveAd,
              child: const Text('Salvar Anúncio'),
            ),
          ],
        ),
      ),
    );
  }
}
