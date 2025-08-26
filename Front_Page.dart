
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kudo0/Play_Page.dart';
import  'package:shared_preferences/shared_preferences.dart';
class StartForm extends StatefulWidget {
  @override
  _StartFormState createState() => _StartFormState();
}

class _StartFormState extends State<StartForm> {
  SharedPreferences Data;
  TextEditingController p1 = new TextEditingController();
  TextEditingController p2 = new TextEditingController();
  bool Remember1=false,Remember2=false;

  void Cheak_Signed()async{

    Data = await SharedPreferences.getInstance();

    if(Data.get('Name1')!=null){
      setState(() {
        p1.text=Data.getString('Name1');
      });

    }
    if(Data.get('Name2')!=null)
    {
      setState(() {
        p2.text=Data.getString('Name2');
      });
    }
  }
  @override
  void initState(){
super.initState();
Cheak_Signed();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width= size.width;
    double height= size.height;
double text_size =  width/19;
    return Scaffold(
      appBar: AppBar(title: Text("Welcome",style:  TextStyle(fontWeight: FontWeight.bold),),bottomOpacity: 0.5,centerTitle: true,primary: true,),extendBodyBehindAppBar: true,
    body: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomRight,colors: [Colors.white,Color(0Xffc2e9fb),Color(0Xffa1c4fd)],)
    ),
      child: ListView(
    children: [      Container(height: width/20,),

      Container(height: width/20,),

      Row(/*direction: Axis.horizontal,*/mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
        children: [Icon(Icons.circle,color: Colors.deepPurple[900],),
          Container(width: width*2.3/3,height:text_size*2.5,margin: EdgeInsets.only(left: text_size*2/3),//decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(9))),
            child: TextField(decoration: InputDecoration(filled:true,border: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple,),borderRadius:BorderRadius.only(bottomLeft:Radius.circular(text_size*3),bottomRight: Radius.circular(text_size*3),topLeft: Radius.circular(text_size*3) /*Radius.circular(text_size*3)*/))
              ,
              labelText: 'Player1 Name',),
              controller: p1,maxLines: 1,
            ),
          ),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.center,/*direction: Axis.horizontal,*/children: [Text('Remember Me'),Checkbox(materialTapTargetSize:MaterialTapTargetSize.shrinkWrap ,value: Remember1, onChanged:(choice){setState(() {
        Remember1=choice;});}
      ),Container(width: text_size*2,)],),
      //Container(height: width/20,),

      Container(margin:EdgeInsets.only(bottom: text_size/3),child:Divider(indent: text_size*1.2,endIndent: text_size*1.2,thickness: text_size/10,)),

      Flex(direction: Axis.horizontal,mainAxisAlignment:MainAxisAlignment.start,
        children: [Icon(Icons.album_outlined,color: Colors.deepPurple[900],),
          Container(width: width*2.3/3,height:text_size*2.5,margin: EdgeInsets.symmetric(horizontal: text_size*2/3),//decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(90))),
            child: TextField(decoration: InputDecoration(filled: true,border: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple,),borderRadius:BorderRadius.only(bottomLeft:Radius.circular(text_size*3),bottomRight: Radius.circular(text_size*3),topLeft: Radius.circular(text_size*3) /*Radius.circular(text_size*3)*/))
              ,labelText: 'Player2 Name',),controller: p2,maxLines: 1,
            ),
          ),
        ],
      ),
    Flex(mainAxisAlignment: MainAxisAlignment.end,direction: Axis.horizontal,children: [Text('Remember Me'),Checkbox(materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,value: Remember2, onChanged:(choice){setState(() {
      Remember2=choice;});}
    ),Container(width: text_size*2,)],),

      Container(margin:EdgeInsets.symmetric(horizontal: text_size*4),decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(text_size*9))),
        child: ElevatedButton(autofocus: true,/*padding:EdgeInsets.all(text_size/2),color: Colors.lightGreen,*/style:ButtonStyle() ,
            child: Text("Play",style:  TextStyle(fontWeight: FontWeight.bold,fontFamily: 'GoudyOlsStyle',fontSize: text_size*19/15,color: Colors.black),),onPressed: ()async{
    Data = await SharedPreferences.getInstance();

          if(p1.text.trim()!='' && p2.text.trim()!=''){
            if(Remember1)Data.setString('Name1', p1.text);
            if(Remember2)Data.setString('Name2', p2.text);
        Navigator.of(context).pushReplacement(
        MaterialPageRoute( builder: (_){return PLay_Form(p1.text.toString(), p2.text.toString());},
        )
    );}
    }
    ),
      )
      ,Container(margin:EdgeInsets.symmetric(horizontal: text_size*5),
        child: RaisedButton(child: Text('Forget Names',style: TextStyle(fontWeight: FontWeight.bold,fontSize: text_size*13/15),),color: Colors.blue[600],
            onPressed:()async{
          Data = await SharedPreferences.getInstance();
          p1.text='';
          p2.text='';
Data.remove('Name1');
Data.remove('Name2');
        }),
      )
    ],
    ),
    ),

      drawer: Drawer(child: Scaffold(appBar: AppBar(title:Text('Game Instruction',style: TextStyle(fontWeight: FontWeight.bold),),),body: SingleChildScrollView(
        child: Padding(padding:EdgeInsets.symmetric(horizontal: text_size/2),

          child: RichText(softWrap: true, text:TextSpan(text:'\n',style: TextStyle(color:Colors.black,fontFamily: 'GoudyOlsStyle',fontWeight: FontWeight.bold),children:[WidgetSpan(child: Icon(Icons.control_camera)),TextSpan(text:' Moves\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: text_size+5)),
            TextSpan(text:'First you play any where, then the another player Can play only in the small bord at the same position you played in.\n',style: TextStyle(fontSize: text_size)),
            TextSpan(text:'\nFor Ex: player 1 played at top right small cell, player two must play in the top right small board\n\nAnd also player one plays according to the last move and so on. \n\n\nIf your turn assigned to finished small grid you can play ',style: TextStyle(fontSize: text_size))
,        TextSpan(text:'any where\n\n',style: TextStyle(fontSize: text_size,fontWeight: FontWeight.bold))
            ,TextSpan(text:'\n',style: TextStyle(color:Colors.black),children:[WidgetSpan(child: Icon(Icons.animation)),TextSpan(text:' Winning\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: text_size+5))]),
            TextSpan(text:'''- Win 3 adjacent large cells \n\n- Win small grids more than your opponent (first rule didn't happened)''' ,style: TextStyle(fontSize: text_size))

          ]),),
        ),
      ),),),
    );
  }
}
