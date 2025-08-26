import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kudo0/Cell_Class.dart';
class Last_Active with ChangeNotifier
{cell_info Last_Hitted;
List<List<int>>Big_Grid;
List<List<bool>>Big_Grid_Validation;
String player1Name='p1',player2Name='p2';
int state=0;
int Big_winner=0;



  Last_Active() {
  //  Last_Hitted = new cell_info(Row: 0, Col: 0, State: 0);
    Big_Grid  = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
    Big_Grid_Validation  = [[true,true , true], [true, true, true], [true, true, true]];
    Last_Hitted = new cell_info(Row: -1,Col: -1,State: 0);

  }
  Reset_Grid()
  {  Big_Grid  = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
  Big_Grid_Validation  = [[true,true , true], [true, true, true], [true, true, true]];
  Last_Hitted = new cell_info(Row: -1,Col: -1,State: 0);
  state =0;
  Big_winner=0;
  }
set_last(int Row,int Column,int State){
  Last_Hitted.Row_indx= Row;
  Last_Hitted.Col_indx= Column;
  Last_Hitted.Winner=State;
  notifyListeners();
}
bool Get_cell_state(int Row,int Column){
  //notifyListeners();
  return Big_Grid_Validation[Row][Column];
  notifyListeners();
}
int Get_cell_winner(int Row,int Column){
  //notifyListeners();
  return Big_Grid[Row][Column];
  notifyListeners();
}
   accept_win_lose(int Row,int Col,int Winner)
  {Big_Grid[Row][Col]= Winner;
  notifyListeners();
  }
  void Prepare_For_Next_Move()
  {
    int Row =Last_Hitted.Row_indx;
    int Col = Last_Hitted.Col_indx;

    if(Row ==-1&& Col ==-1)
      {
        for(int i =0 ;i<3;i++) {
          for (int j = 0; j < 3; j++) {
            Big_Grid_Validation[i][j]=true;
          }
        }
        return;
      }
    if(Big_Grid[Row][Col]==0)
      {
      for(int i =0 ;i<3;i++) {
        for (int j = 0; j < 3; j++) {
            Big_Grid_Validation[i][j]=false;
        }
      }
      Big_Grid_Validation[Row][Col]=true;
      }
    else
      {for(int i =0 ;i<3;i++) {
        for (int j = 0; j < 3; j++) {
          if (Big_Grid[i][j] == 0)
            Big_Grid_Validation[i][j]=true;
          else
            Big_Grid_Validation[i][j]=false;
        }
      }}
    notifyListeners();
      }
Get_Names(String p1name,String p2name)
{
  player1Name=p1name;player2Name=p2name;
}

cell_info Cheack_Win_Lose()
{

for(int i=0 ;i<3;i++)
{
  if(Big_Grid[0][i]==Big_Grid[1][i] &&Big_Grid[1][i] ==Big_Grid[2][i]&&Big_Grid[1][i]!=0)
  {state =Big_Grid[0][i];Big_winner=state; }

  if(Big_Grid[i][0]==Big_Grid[i][1]&&Big_Grid[i][1]==Big_Grid[i][2]&&Big_Grid[i][1]!=0)
  {state =Big_Grid[i][0];Big_winner= state;}
}

if(Big_Grid[0][0] ==Big_Grid[1][1]&&Big_Grid[1][1]==Big_Grid[2][2] &&Big_Grid[1][1]!=0)
{state =Big_Grid[0][0];Big_winner= state;}
if(Big_Grid[0][2]==Big_Grid[1][1] &&Big_Grid[1][1] ==Big_Grid[2][0]&&Big_Grid[1][1] !=0)
{state =Big_Grid[0][2];Big_winner= state;}

//Big Gris is ful
bool end=true;
int player1 =0,player2=0;
for(int i=0 ;i<3;i++) {
  for(int j=0 ;j<3;j++) {
    if(Big_Grid[i][j]==0)
    {end=false;break;}
    if(Big_Grid[i][j]==1)
      player1++;
    if(Big_Grid[i][j]==2)
      player2++;
  }
}
if(end)
{
  if(player1>player2)
    Big_winner=1;
  else if(player1<player2)
    Big_winner=2;
  else
    Big_winner =3;
}

if(Big_winner!=0)
  {
    for(int i=0;i<3;i++)
      {
        for(int j=0;j<3;j++)
          {
            Big_Grid_Validation[i][j]=false;
          }
      }


  }
  if(Big_winner==1)
    print(player1Name);
  else if(Big_winner==2)
    print(player2Name);
  else if(Big_winner==3)
    print('Draw');
  Finish_the_Game();

}
String Get_Winner_Name()
{
  if(Big_winner==1)
    return player1Name+' Wins';
  else if(Big_winner==2)
    return player2Name+' Wins';
  else
    return 'Draw';
}
bool Finish_the_Game()
{if(Big_winner!=0) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      Big_Grid_Validation[i][j] = false;
    }
  }
}
  notifyListeners();
  if(Big_winner==0)
    return false;
  else
    return true;
}
}

class Current_player with ChangeNotifier{
  Current_player()
  { _Player =1;}

  int _Player ;
  int Get_Turn()
  {return _Player;}

  void Swich_Player()
  {
    if(_Player == 1)
      _Player = 2;
    else if(_Player ==2)
      _Player =1;
    else
      _Player=1;

    notifyListeners();
  }
}