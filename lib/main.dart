import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'model.dart';
import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ingestão de água'),
          centerTitle: true,
        ),
        body: TestForm(),
      ),
    );
  }
}

class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  bool isChecked = false;

  bool alcVal = false;
  bool diabVal = false;
  int mascValue = 0;
  int femValue = 0;
  //bool wedVal = false;

  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  List<String> text = ["Feminino", "Masculino"];

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Nome',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Insira seu nome';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.firstName = value;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Peso',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Insira seu peso';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.lastName = value;
                    },
                  ),
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 230),
                child: Text("Consumo álcool"),
              ),
              Padding(
                padding: EdgeInsets.only(right: 250.0),
                child: Checkbox(
                  value: alcVal,
                  onChanged: (value) {
                    setState(() {
                      alcVal = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 250),
                child: Text("Gestante"),
              ),
              Padding(
                padding: EdgeInsets.only(right: 250),
                child: Checkbox(
                  value: diabVal,
                  onChanged: (bool value) {
                    setState(() {
                      diabVal = value;
                    });
                  },
                ),
              )
            ],
          ),
          Text("Masculino"),
          Radio(
            groupValue: mascValue,
            onChanged: (int i) => setState(() => mascValue = i),
            value: 1,
          ),
          Text("Feminino"),
          Radio(
            groupValue: femValue,
            onChanged: (int i) => setState(() => femValue = i),
            value: 1,
          ),
          RaisedButton(
            color: Colors.cyan,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Result(model: this.model)));
              }
            },
            
            child: Text(
              'Criar Nova Conta',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(12.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.purple[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
