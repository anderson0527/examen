import 'package:examen/components/loader_component.dart';
import 'package:examen/helpers/api_helper.dart';
import 'package:examen/models/information.dart';
import 'package:examen/models/response.dart';
import 'package:examen/models/token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  final Token token;

  HomeScreen({required this.token});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLoader = false;
  Information _information = Information(id: 0, date: '', email: '', qualification: 0, theBest: '', theWorst: '', remarks: '');
  SendInformation _sendInformation = SendInformation(email: '', qualification: 0, theBest: '', theWorst: '', remarks: '');

  @override
  void initState() {
    super.initState();
    _getInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: Text('Examen'),
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: _information.id.toString(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingresa tu id',
              ),
              onChanged: (value) { value != '' ? _information.id = int.parse(value) : value; },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: _information.email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingresa tu email',
              ),
              onChanged: (value) { _information.email = value; },
            ),
          ),
          RatingBar.builder(
            initialRating: _information.qualification.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => _icon(),
            onRatingUpdate: (rating) { rating != '' ? _information.qualification = rating.toInt() : rating; }
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: _information.theBest,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingresa tu theBest',
              ),
              onChanged: (value) { _information.theBest = value; },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: _information.theWorst,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingresa tu theWorst',
              ),
              onChanged: (value) { _information.theWorst = value; },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: _information.remarks,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingresa tu remarks',
              ),
              onChanged: (value) { _information.remarks = value; },
            ),
          ),
          Row(
            children: <Widget>[
              _showButton(),
              SizedBox(width: 20,),
            ],
          ),
        ],
      )
    );
  }

  Widget _showButton() {
    return Expanded(
      child: ElevatedButton(
        child: Text('Guardar'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Color(0xFF120E43);
            }
          ),
        ),
        onPressed: () => _saveInformation(), 
      ),
    );
  }

  Future<Null> _getInformation() async {
    setState(() { _showLoader = true; });

    Response response = await ApiHelper.getInformation(widget.token);

    setState(() { 
      (response.result.email != '') ? _information = response.result : _information = Information(id: 0, date: '', email: '', qualification: 0, theBest: '', theWorst: '', remarks: '');
    });
    setState(() { _showLoader = false; });
  }

  Future<Null> _saveInformation() async {
    setState(() { _showLoader = true; });

    Map<String, dynamic> sendInformation = {
      'email': _information.email,
      'qualification': _information.qualification,
      'theBest': _information.theBest,
      'theWorst': _information.theWorst,
      'remarks': _information.remarks
    };
    Response response = await ApiHelper.sendInformation(sendInformation, widget.token);

    setState(() { _showLoader = false; });
    setState(() { _information = response.result; });
  }

  Icon _icon() {
    if (_information.qualification == 1) {
      return Icon( Icons.sentiment_very_dissatisfied, color: Colors.red );
    } else if (_information.qualification == 2) {
      return Icon( Icons.sentiment_dissatisfied, color: Colors.redAccent );
    } else if (_information.qualification == 3) {
      return Icon( Icons.sentiment_neutral, color: Colors.amber );
    } else if (_information.qualification == 4) {
      return Icon( Icons.sentiment_satisfied, color: Colors.lightGreen );
    } else {
      return Icon( Icons.sentiment_very_satisfied, color: Colors.green );
    }
  }
}