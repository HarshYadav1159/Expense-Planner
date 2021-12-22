import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:untitled/widgets/new_transactions.dart';
import './widgets/transactions_list.dart';
import './widgets/chart.dart';


import 'models/text_output.dart';
void main()=> runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',

      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


// String titleInput;
// String amountInput;


  final List<Transaction> _userTransactions =[

  ];

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
    final tx=Transaction(id: DateTime.now().toString(),
        title: txTitle,
        date: chosenDate,
        amount: txAmount);
    setState(()
    {
      _userTransactions.add(tx);
    },);}

    void deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id==id );
    });

    }

    void _startAddNewTransaction(BuildContext ctx){
      showModalBottomSheet(context: ctx, builder: (_){
        return NewTransactions(_addNewTransaction);
      },
      );
    }



  @override
  Widget build(BuildContext context){
    return Container(
      child:MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
        textTheme:ThemeData.light().textTheme.copyWith(
      headline6: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),),
          appBarTheme: AppBarTheme(
            textTheme:ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      home:Scaffold(
        appBar:AppBar(
          title:Text('Expense Planner'),
          actions: <Widget>[
            IconButton(onPressed: ()=>_startAddNewTransaction(context), icon: Icon(Icons.add),)
          ],
        ) ,

        body:SingleChildScrollView(
        child:Column(


          // mainAxisAlignment: MainAxisAlignment.spaceAround  ,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            Chart(_recentTransactions),
            TransactionList(_userTransactions,deleteTransaction),


          ],),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(onPressed: ()=>_startAddNewTransaction(context),child: Icon(Icons.add),elevation: 5,),
        ),

      )
   );
  }

}