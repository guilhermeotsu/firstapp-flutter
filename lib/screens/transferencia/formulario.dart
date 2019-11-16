import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloNumeroConta = 'Numero da conta';
const _dicaNumeroConta = '0000';
const _rotuloValor = 'Valor';
const _dicaValor = '000.0';
const _textRisedButton = Text('Confirmar');

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
// criando propriedades para armazenar o valor os inputs do formulário
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controllerNumeroConta,
              rotulo: _rotuloNumeroConta,
              dica: _dicaNumeroConta,
            ),
            Editor(
              controlador: _controllerValor,
              rotulo: _rotuloValor,
              dica: _dicaValor,
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              onPressed: () => _criaTransferencia(context),
              child: _textRisedButton,
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    // fazendo a conversão de valores
    final int numeroConta = int.tryParse(_controllerNumeroConta.text);
    final double valor = double.tryParse(_controllerValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('criando a merda da transferencia');
      debugPrint('$transferenciaCriada');
      // mandando a transferencia para o future da classe ListaTransferencia
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
