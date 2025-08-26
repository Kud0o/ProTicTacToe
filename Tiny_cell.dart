import 'dart:math';
import 'Cell_Class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'My_Providers.dart';

class cell extends StatefulWidget {
  //int Row_pos_tiny;
  //int Col_pos_tiny,state;

  cell({ Key key,this.Content,this.onChange}) : super(key: key){

   // Content = new cell_info(Row: this.Row_pos_tiny,Col: this.Col_pos_tiny,State: state);

  }
  final Function(int,int,int) onChange;

  cell_info Content;

  int GetState(){return Content.Winner;}
  @override
  _cellState createState() => _cellState();
}

class _cellState extends State<cell> {

  /*@override
  void initState()
  {
    super.initState();
    widget.Content = new cell_info(Row: widget.Row_pos_tiny,Col: widget.Col_pos_tiny,State: widget.state);
  }*/
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double dim = min(size.height, size.width);
    return Container( height: dim/11,width: dim/11,alignment: Alignment.topLeft,margin:EdgeInsets.all(dim/300),
      //margin: EdgeInsets.all(0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),
        color: Color(0Xff66a6ff),
        boxShadow: [BoxShadow(spreadRadius: 1,blurRadius: 5,color: Colors.deepPurple[800])],
      ),
        child: IconButton(splashColor:Colors.lightBlueAccent,
        iconSize:dim/21,icon:(Icon((widget.Content.Winner==0)?null:((widget.Content.Winner==1)?Icons.circle:Icons.album_outlined))), onPressed:(){

          if(widget.Content.Winner==0) {
            setState((){
              print('${widget.Content.Row_indx},${widget.Content.Col_indx}');
              widget.Content.Winner= context.read<Current_player>().Get_Turn();
            });
            Provider.of<Last_Active>(context, listen: false).set_last(
                widget.Content.Row_indx, widget.Content.Col_indx,
                widget.Content.Winner);
            context.read<Current_player>().Swich_Player();
            context.read<Last_Active>().Prepare_For_Next_Move();
            widget.onChange(widget.Content.Row_indx,widget.Content.Col_indx,widget.Content.Winner);
            context.read<Last_Active>().Cheack_Win_Lose();

          }

        }

        ),

    );
  }
}
