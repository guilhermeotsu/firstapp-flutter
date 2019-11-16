import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = Text('Tranferências');

// classe para refatorar o código
class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {
  // sobrescrever o método obrigatório
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _tituloAppBar,
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, index) {
          final Transferencia transferencia = widget._transferencias[index];
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
            if (transferenciaRecebida != null) {
              // setState faz com que o build seja chamado e atualize o conteúdo
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });
            }
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
