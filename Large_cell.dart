import 'dart:math';
import 'Cell_Class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Tiny_cell.dart';
import 'package:provider/provider.dart';
import 'My_Providers.dart';
class LargeCell extends StatefulWidget {
  int Row_pos_large=0;
  int Col_pos_large=0;

  LargeCell({ Key key,this.Row_pos_large,this.Col_pos_large,this.IsEndGame }) : super(key: key){
    Content=[[cell_info(Row:0,Col:0,State:0), cell_info(Row:0,Col:1,State:0),cell_info(Row:0,Col:2,State:0)],
      [cell_info(Row:1,Col:0,State:0),cell_info(Row:1,Col:1,State:0),cell_info(Row:1,Col:2,State:0)]
      ,[ cell_info(Row:2,Col:0,State:0), cell_info(Row:2,Col:1,State:0), cell_info(Row:2,Col:2,State:0)]];

    //valid= true;
  }
  final VoidCallback IsEndGame;
  bool valid= true;
  /*List<List<Widget>> Content = [[cell(state: 0,Row_pos_tiny: 0,Col_pos_tiny: 0,),cell(state: 0,Row_pos_tiny: 0,Col_pos_tiny: 1,),cell(state: 0,Row_pos_tiny: 0,Col_pos_tiny: 2,)],
    [cell(state: 0,Row_pos_tiny: 1,Col_pos_tiny: 0,),cell(state: 0,Row_pos_tiny: 1,Col_pos_tiny: 1,),cell(state: 0,Row_pos_tiny: 1,Col_pos_tiny: 2,)],
    [cell(state: 0,Row_pos_tiny: 2,Col_pos_tiny: 0,),cell(state: 0,Row_pos_tiny: 2,Col_pos_tiny: 1,),cell(state: 0,Row_pos_tiny: 2,Col_pos_tiny: 2,)]];
*/
List<List<cell_info>>Content=[[new cell_info(Row:0,Col:0,State:0),new cell_info(Row:0,Col:1,State:0),new cell_info(Row:0,Col:2,State:0)],
  [new cell_info(Row:1,Col:0,State:0),new cell_info(Row:1,Col:1,State:0),new cell_info(Row:1,Col:2,State:0)]
  ,[new cell_info(Row:2,Col:0,State:0),new cell_info(Row:2,Col:1,State:0),new cell_info(Row:2,Col:2,State:0)]];


 void Cheack_Win_Lose(BuildContext context){
   //Provider.of<Last_Active>(context,listen:true).Big_Grid;
    int state= 0;
    for(int i=0 ;i<3;i++)
    {
      if(Content[0][i].Winner==Content[1][i].Winner&&Content[1][i].Winner==Content[2][i].Winner&&Content[1][i].Winner!=0)
      {state =Content[0][i].Winner; }

      if(Content[i][0].Winner==Content[i][1].Winner&&Content[i][1].Winner==Content[i][2].Winner&&Content[i][1].Winner!=0)
      {state =Content[i][0].Winner; }
    }

    if(Content[0][0].Winner==Content[1][1].Winner&&Content[1][1].Winner==Content[2][2].Winner&&Content[2][2].Winner!=0)
    {state =Content[0][0].Winner; }

    if(Content[0][2].Winner==Content[1][1].Winner&&Content[1][1].Winner==Content[2][0].Winner&&Content[2][0].Winner!=0)
    {state =Content[2][0].Winner; }

    if(state ==0){
      int filled =0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if(Content[i][j].Winner !=0)
            filled++;
        }
      }

      if(filled==9)
        state=3;
    }
    //print(this.Content_info.Winner); I Couldn't modify this.Content_info.Winner !!!
    print("${state}"+" ---");
    print("validation is ${this.valid}"+" -");
    try {
      Provider.of<Last_Active>(context, listen: false).accept_win_lose(
          this.Row_pos_large, this.Col_pos_large, state);

        this.valid =Provider.of<Last_Active>(context, listen: false).Get_cell_state(
            this.Row_pos_large, this.Col_pos_large);

      Provider.of<Last_Active>(context, listen: false).Cheack_Win_Lose();

    }
    catch(E){print(E);}
  }

  @override
  _LargeCellState createState() => _LargeCellState();
}

class _LargeCellState extends State<LargeCell> {

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    widget.Content=[[new cell_info(Row:0,Col:0,State:0),new cell_info(Row:0,Col:1,State:0),new cell_info(Row:0,Col:2,State:0)],
    [new cell_info(Row:1,Col:0,State:0),new cell_info(Row:1,Col:1,State:0),new cell_info(Row:1,Col:2,State:0)]
      ,[new cell_info(Row:2,Col:0,State:0),new cell_info(Row:2,Col:1,State:0),new cell_info(Row:2,Col:2,State:0)]];

  }

  void updateTiny(int row,int col, int state)
  {
    setState(() {
      widget.Content[row][col].Winner=state;
      widget.Cheack_Win_Lose(context);
      context.read<Last_Active>().Prepare_For_Next_Move();

      print('validation is ${!Provider.of<Last_Active>(context,listen:false).Get_cell_state(widget.Row_pos_large, widget.Col_pos_large)
      } ');
      context.read<Last_Active>().Cheack_Win_Lose();

    });

    widget.IsEndGame();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double dim = min(size.height, size.width);
    return AbsorbPointer(
      absorbing:
    !Provider.of<Last_Active>(context,listen:false).Get_cell_state(widget.Row_pos_large, widget.Col_pos_large),
      child: Container(margin:EdgeInsets.all(dim/4100),padding:EdgeInsets.all(size.width/50),
        decoration: BoxDecoration(

            gradient: LinearGradient(
                begin: Alignment(-1.0, -.08),
                end: Alignment(1.08, 3.0),
                colors:!(Provider.of<Last_Active>(context,listen:false).Get_cell_state(widget.Row_pos_large, widget.Col_pos_large))? [Color(0X55c2e9fb),Color(0X55a1c4fd)]:[Color(0Xff00c6fb),Color(0Xff2575fc)]),
            borderRadius: BorderRadius.circular(dim/16)),
        child:Flex(direction:Axis.vertical,mainAxisAlignment:MainAxisAlignment.spaceEvenly,

        children: (Provider.of<Last_Active>(context,listen:true).Get_cell_winner(widget.Row_pos_large, widget.Col_pos_large)==1)?[Icon(Icons.circle,size: (dim*5.05/19+dim/50))] :
        (Provider.of<Last_Active>(context,listen:false).Get_cell_winner(widget.Row_pos_large, widget.Col_pos_large)==2)?[Icon(Icons.album_outlined,size: (dim*5.05/19+dim/50))] :
        [
          Flex(direction: Axis.horizontal,children:widget.Content[0].map((e) => cell(Content:e,onChange:(int R,int C,int S){updateTiny(R,C,S);})).toList(),mainAxisAlignment:MainAxisAlignment.spaceEvenly),
          Flex(direction: Axis.horizontal,children: widget.Content[1].map((e) => cell(Content:e,onChange:(int R,int C,int S){updateTiny(R,C,S);})).toList(),mainAxisAlignment:MainAxisAlignment.spaceEvenly),
          Flex(direction: Axis.horizontal,children: widget.Content[2].map((e) => cell(Content:e,onChange:(int R,int C,int S){updateTiny(R,C,S);})).toList(),mainAxisAlignment:MainAxisAlignment.spaceEvenly)
        ],
      ),
      ),
    );
  }
}
