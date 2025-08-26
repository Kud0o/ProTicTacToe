
class cell_info{
 int Row_indx;
int Col_indx;
int Winner;
cell_info({Row,Col,State})
{
  Row_indx = Row;
  Col_indx = Col;
  Winner = State;
}
cell_info Get_info() => this;
}