import 'package:flutter/material.dart';
import 'Large_cell.dart';
import 'package:provider/provider.dart';
import 'My_Providers.dart';

class Grid extends StatefulWidget {
 final String p1Name,p2Name;
  Grid(this.p1Name,this.p2Name,this.fromPlayPage);

  final VoidCallback fromPlayPage;
  @override
  _GridState createState() => _GridState();
}
class _GridState extends State<Grid> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Last_Active>().Get_Names(widget.p1Name, widget.p2Name);
  }


  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;

    void isFinalMove()
    {
      widget.fromPlayPage();
    }

    return ListView(
      children: [
        Container(child:  Column(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
            Row(children: [LargeCell(Row_pos_large: 0,Col_pos_large: 0,IsEndGame: isFinalMove,),LargeCell(Row_pos_large: 0,Col_pos_large: 1,IsEndGame: isFinalMove,),LargeCell(Row_pos_large: 0,Col_pos_large: 2,IsEndGame: isFinalMove,)],mainAxisAlignment:MainAxisAlignment.spaceEvenly),
            Row(children: [LargeCell(Row_pos_large: 1,Col_pos_large: 0,IsEndGame: isFinalMove,),LargeCell(Row_pos_large: 1,Col_pos_large: 1,IsEndGame: isFinalMove,),LargeCell(Row_pos_large: 1,Col_pos_large: 2,IsEndGame: isFinalMove,)],mainAxisAlignment:MainAxisAlignment.spaceEvenly),
            Row(children: [LargeCell(Row_pos_large: 2,Col_pos_large: 0,IsEndGame: isFinalMove,),LargeCell(Row_pos_large: 2,Col_pos_large: 1,IsEndGame: isFinalMove,),LargeCell(Row_pos_large: 2,Col_pos_large: 2,IsEndGame: isFinalMove,)],mainAxisAlignment:MainAxisAlignment.spaceEvenly)],
        ),),
      ],
    );
  }
}
