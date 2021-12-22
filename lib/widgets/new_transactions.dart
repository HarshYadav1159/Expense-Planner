import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransactions extends StatefulWidget {
  final Function addTx;
  NewTransactions(@required this.addTx);
  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {


  final titleController= TextEditingController();
  final amountController= TextEditingController();
  DateTime selectedDate;

  void submitData(){
    if(amountController.text.isEmpty){
      return;
    }
    final eneteredTitle=titleController.text;
    final eneteredAmount=double.parse(amountController.text);
    if(eneteredTitle.isEmpty || eneteredAmount<=0){
      return;
    }

    widget.addTx(
        eneteredTitle,
        eneteredAmount,
        selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate=pickedDate;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_)=>submitData(),
              // onChanged: (val){
              //
              //   // titleInput=val;
              // },
            ),
            TextField(decoration: InputDecoration(labelText: 'Amount'),
              controller:amountController,
              keyboardType: TextInputType.datetime,
              onSubmitted: (_)=>submitData(),
              // onChanged: (val){

              // amountInput=val;
              // },
            ),
            Container(
              height: 70,
              child:Row(
                children:<Widget>[
                  Text(selectedDate==null ?'No Date chosen':
                  DateFormat.yMd().format(selectedDate)),
                  FlatButton(onPressed: presentDatePicker,
                    textColor: Colors.purple ,
                  child: Text('Choose Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  )
                ],

              ),
            ),


            RaisedButton(onPressed:  submitData,
              textColor: Colors.white,
              child: Text('Add Transaction',
              ),
              color: Colors.purple,


            )
          ],
        ),
      ),);
  }
}
