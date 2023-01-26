import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _createPDF();
          },
          child: const Text(
            'Criar PDF',
          ),
        ),
      ),
    );
  }
}

Future<void> _createPDF() async {
  try {
    // Criação do documento
    PdfDocument document = PdfDocument();

    // Texto extremamente grande
    String text =
        'Lorem ipsum at posuere facilisis dictum felis mauris consectetur eu class metus, quisque ligula aptent risus dictum aliquam auctor curabitur nisl molestie, sem habitant quis aenean tortor leo eros fusce eget malesuada. nibh magna per at adipiscing tempus purus ipsum, curae ipsum sagittis conubia a gravida risus molestie, primis adipiscing lacus faucibus praesent volutpat. duis sed fusce platea enim metus justo, facilisis fringilla morbi nisl luctus fringilla purus, molestie nam sapien cubilia habitant. posuere a curae massa pellentesque dictumst vivamus pellentesque nec quisque netus dui euismod, nunc gravida eros potenti arcu luctus lacinia quisque rutrum non. ';

    // Adicionando uma página
    PdfPage page = document.pages.add();

    // Adicionar imagem - Suporte JPEG e PNG
    page.graphics.drawImage(
      PdfBitmap(
        File(
          // TODO: O caminho relativo não está funcionando, é necessário colocar o caminho completo do sistema :/
          '/Users/fulvio/Documents/repositorios/estudo-desenvolvimento/pdf_creation/assets/images/logo_app.png',
        ).readAsBytesSync(),
      ),
      const Rect.fromLTWH(0, 0, 80, 80),
    );

    // Adicionar texto
    page.graphics.drawString(
      text,
      PdfStandardFont(PdfFontFamily.helvetica, 20),
      bounds: const Rect.fromLTWH(0, 100, 0, 0),
    );

    // Salvar documento - Método mais curto, mas sem seleção de caminho
    File(
      // TODO: O caminho relativo não está funcionando, é necessário colocar o caminho completo do sistema :/
      '/Users/fulvio/Documents/repositorios/estudo-desenvolvimento/pdf_creation/lib/Output.pdf',
    ).writeAsBytes(await document.save());

    document.dispose();

    // // Salvar documento - Método mais longo e com seleção de caminho
    // List<int> bytes = await document.save();
    // document.dispose();
    // final directory = await getApplicationSupportDirectory();
    // final path = directory.path;
    // File file = File('$path/Output.pdf');
    // await file.writeAsBytes(bytes, flush: true);

    // // Abrir arquivo
    // OpenFile.open('$path/Output.pdf');
  } catch (e) {
    print(e);
  }
}
