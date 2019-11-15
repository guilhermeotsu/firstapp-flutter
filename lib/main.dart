import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  // criando propriedades para armazenar o valor os inputs do formulário
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        children: <Widget>[
          Editor(
              controlador: _controllerNumeroConta,
              rotulo: 'Numero da conta',
              dica: '0000'),
          Editor(
            controlador: _controllerValor,
            rotulo: 'Valor',
            dica: '000.0',
            icone: Icons.monetization_on,
          ),
          RaisedButton(
            onPressed: () => _criaTransferencia(),
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _criaTransferencia() {
    // fazendo a conversão de valores
    final int numeroConta = int.tryParse(_controllerNumeroConta.text);
    final double valor = double.tryParse(_controllerValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
    }
  }
}

// classe para criar os campos do formulário
class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador, // faz com que pegue os valores do campos
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

// classe para refatorar o código
class ListaTransferencias extends StatelessWidget {
  // sobrescrever o método obrigatório
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tranferências'),
      ),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(200.0, 1001)),
          ItemTransferencia(Transferencia(300.0, 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  // final -> valor constante
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia { valor: $valor, numeroConta: $numeroConta }';
  }
}
