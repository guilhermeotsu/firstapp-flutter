import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
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
            onPressed: () => _criaTransferencia(context),
            child: Text('Confirmar'),
          ),
        ],
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
  final List<Transferencia> _transferencias = List();

  // sobrescrever o método obrigatório
  @override
  Widget build(BuildContext context) {
    _transferencias.add(Transferencia(100, 1100));
    return Scaffold(
      appBar: AppBar(
        title: Text('Tranferências'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, index) {
          final Transferencia transferencia = _transferencias[index];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // future vai receber o retorna da fução
          final Future<Transferencia> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          );
          // then é a função de callback que só vai receber esse valor no momento que acontecer o valor
          // basicamente ele fica monitorando até os eventos até que ele receba o valor
          future.then((transferenciaRecebida) {
            debugPrint('then nessa merdaaaa');
            debugPrint('$transferenciaRecebida');
            _transferencias.add(transferenciaRecebida);
          }); // no exemplo aqui a partir do confirmar que o valor é atribuido ao future
        }, // navegação nas telas
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
