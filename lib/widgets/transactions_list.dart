import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/text_output.dart';
import '../models/text_output.dart';
import 'package:intl/intl.dart';
import './chat_bar.dart';
import '../widgets/transactions_list.dart';
import 'package:flutter/src/widgets/icon.dart';

class TransactionList extends StatelessWidget {


final List<Transaction> transactions;
final Function deleteTx;
TransactionList(this.transactions,this.deleteTx);



  @override
  Widget build(BuildContext context) {
    return
      Container(
       height: 500,
       alignment: AlignmentDirectional.center,
        child:transactions.isEmpty?
         Column(
          children: <Widget>[
            Text('   No Transactions Added Yet!!',
            style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,

            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
             child: Image.asset('assets/images/waiting.png',fit:BoxFit.cover),
            ),

          ],

        )
          :
      ListView.builder(
          itemBuilder: ((ctx,index){
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child:ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child:Text('\$${transactions[index].amount}'),
                        ),
                      )
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(icon: Icon(Icons.delete),color: Colors.red,
                  onPressed: ()=>deleteTx(transactions[index].id),
                  ),
                ),
            );

          }),

          itemCount: transactions.length,
    ),);
  }
}
