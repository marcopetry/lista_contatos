import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

List<String> nomes = [];
List<String> numeros = [];

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navigation Basics',
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: ListaContatos(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionaContato()),
          );
        },
      ),
    );
  }
}

class AdicionaContato extends StatefulWidget {
  const AdicionaContato({Key key}) : super(key: key);

  @override
  _AdicionaContato createState() => _AdicionaContato();
}

class _AdicionaContato extends State<AdicionaContato> {
  final nomeCtrl = TextEditingController();
  final numeroCtrl = TextEditingController();
  var marcaraTelefone =
      new MaskedTextController(mask: '(00)00000-0000', text: '');
  String nome = "";
  String numero = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Contato"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            TextField(
                controller: nomeCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite o nome:',
                )),
            Padding(padding: EdgeInsets.all(10)),
            new TextField(
                //controller: numeroCtrl,
                controller: marcaraTelefone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite o número:',
                )),
            Padding(padding: EdgeInsets.all(20)),
            ButtonTheme(
                minWidth: 500.0,
                height: 50.0,
                child: RaisedButton(
                    color: Colors.orangeAccent,
                    textColor: Colors.black,
                    onPressed: () {
                      enviar();
                    },
                    child: Text('Cadastrar', style: TextStyle(fontSize: 20)))),
          ],
        ),
      ),
    );
  }

  enviar() {
    var valor1 = nomeCtrl.text;
    final valor2 = marcaraTelefone.text;
    if (valor1.length == 0 || valor2.length == 0 || valor2.length < 14) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Problema ao cadastrar!"),
            content: new Text(
                "Você tem campos vazios e/ou seu telefone está com números a menos!"),
            actions: <Widget>[
              // define os botões na base do dialogo
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    valor1 = valor1 + '                              ';

    setState(() {
      nomes.add(valor1);
      numeros.add(valor2);
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }
}

class ListaContatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return nomes.length == 0
        ? Center(child: Text('Você não tem nenhum contato adicionado!'))
        : ListView.builder(
            itemCount: nomes.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Colors.lightBlue.shade900),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.phone_android,
                      color: Colors.black,
                      size: 40.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text(nomes[index].substring(0, 15)),
                        Text(numeros[index])
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.message,
                          size: 40,
                          color: Colors.black,
                        ),
                        Icon(
                          Icons.call,
                          size: 40,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ));
            },
          );
  }
}
