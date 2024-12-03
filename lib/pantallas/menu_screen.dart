import 'package:flutter/material.dart';
import 'package:flutter_application_1/pantallas/consulta_por_codigo%20_screen.dart';
import 'consulta_por_nombre_screen.dart';
import 'consulta_por_codigo_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta País')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultaPorNombreScreen(),
                  ),
                );
              },
              child: Text('Consultar por Nombre'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultaPorCodigoScreen(),
                  ),
                );
              },
              child: Text('Consultar por Código'),
            ),
          ],
        ),
     ),
);
}
}