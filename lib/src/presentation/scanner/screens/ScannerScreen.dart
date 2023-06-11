import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  void initState() {
    super.initState();
    startBarcodeScan();
  }

  Future<void> startBarcodeScan() async {
    String APIURL="http://40.124.104.203";
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#3D8BEF",
      "Cancelar",
      false,
      ScanMode.QR,
    );

    print("=======================> $barcodeScanRes"); // escaner

    var responsee = await Dio()
        .get("$APIURL:3003/horarioAulas/hora/3");
    print("responsee");
    print(responsee);


    final response = await Dio().post(
      '$APIURL:3003/bitacora/$barcodeScanRes/3/$responsee');
    // Aquí puedes realizar cualquier acción con el resultado del escaneo
    startBarcodeScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu QR'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
