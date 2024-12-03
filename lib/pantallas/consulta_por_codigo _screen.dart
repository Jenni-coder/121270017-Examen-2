import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constantes/api_constants.dart';  // Asegúrate de que esta constante esté definida
import '../modelos/pais_model.dart';  // Asegúrate de que el modelo Pais esté correctamente implementado

class ConsultaPorCodigoScreen extends StatefulWidget {
  @override
  _ConsultaPorCodigoScreenState createState() =>
      _ConsultaPorCodigoScreenState();
}

class _ConsultaPorCodigoScreenState extends State<ConsultaPorCodigoScreen> {
  final TextEditingController _controller = TextEditingController();
  Pais? pais;

  Future<void> fetchPaisPorCodigo(String codigo) async {
    final response = await http.get(Uri.parse('$BY_CODE_ENDPOINT$codigo'));

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
      appBar: AppBar(
        title: Text('Consulta por Código'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Código del País (alfa-3)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                fetchPaisPorCodigo(_controller.text.trim());
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
                        Text('Dominios: ${pais!.tld.join(', ')}'),
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