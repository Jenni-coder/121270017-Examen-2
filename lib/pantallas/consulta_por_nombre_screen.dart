import 'package:flutter/material.dart';
import 'dart:convert';
import '../constantes/api_constants.dart';
import '../modelos/pais_model.dart';

class ConsultaPorNombreScreen extends StatefulWidget {
  @override
  _ConsultaPorNombreScreenState createState() =>
      _ConsultaPorNombreScreenState();
}

class _ConsultaPorNombreScreenState
    extends State<ConsultaPorNombreScreen> {
  final TextEditingController _controller = TextEditingController();
  Pais? pais;
  
  get http => null;

  Future<void> fetchPais(String nombre) async {
    final response =
        await http.get(Uri.parse('$BY_NAME_ENDPOINT$nombre'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        pais = Pais.fromJson(data[0]);
      });
    } else {
      setState(() {
        pais = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta por Nombre')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nombre del País',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                fetchPais(_controller.text.trim());
              },
              child: Text('Consultar'),
            ),
            SizedBox(height: 20),
            pais != null
                ? Expanded(
                    child: ListView(
                      children: [
                        Text('Nombre Común: ${pais!.commonName}'),
                        Text('Nombre Oficial: ${pais!.officialName}'),
                        Text('Nombre Nativo: ${pais!.nativeName}'),
                        Text('Región: ${pais!.region}'),
                        Text('Subregión: ${pais!.subregion}'),
                        Text('Dominios: ${pais!.tld}'),
                        Text('Fronteras: ${pais!.borders.join(', ')}'),
                      ],
                    ),
                  )
                : Text('No se encontró información'),
          ],
        ),
     ),
);
}
}
