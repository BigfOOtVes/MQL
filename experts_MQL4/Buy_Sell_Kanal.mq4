//+------------------------------------------------------------------+
//|                                                    ZigZagVes.mq4 |
//|                                                              Ves |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Ves"
#property link      ""
/*
�������� ���������� ��� ������ ��� � ��� �� ������� UrUp � UrDown (������ � �������), �� ������� ���������� �������������� �����,
���� �������� ����� �� �������� ���������� ����� ���� ������ UrUp, �� ��������� ����� �� �������,
���� ������� ����� �� �������� ���������� ����� ���� ������ UrDown, �� ��������� ����� �� �������.
���� ����� � ������� �� ������� ������ �������� ...
�������� �������� ����� F3 - ���� ���������� ����������, ����� �������� ���� ��������� Start = 1
*/

extern int TP = 100;         //����������
extern int SL = 100;         //�������
extern double Lot = 0.1;     //���
double Start = 0;            //���������� �� ��������
double UrUp = 0.0;           //������� ������� ��� ������
double UrDown = 0.0;         //������ ������� ��� ������
int buy, sell;               //������


int init ()
   {
    GlobalVariableSet("UrUp",0.0);       //������� ���������� ����������
    GlobalVariableSet("UrDown",0.0);
    GlobalVariableSet("Start",0.0);
    return(0);
   }

int start()
  {
   UrUp = GlobalVariableGet("UrUp");         //���������� �������� �� ���������� ����������
   UrDown = GlobalVariableGet("UrDown");
   Start = GlobalVariableGet("Start");
   
   if (Start == 0){ ObjectDelete("UrUp");ObjectDelete("UrDown");   //���� �������� ���������, �� ������� ��� �������� ������ � �������
      if (OrderSelect(buy,SELECT_BY_TICKET) == true)
         OrderClose(buy,OrderLots(),NormalizeDouble(Bid,Digits),2);
      if (OrderSelect(sell,SELECT_BY_TICKET) == true)
         OrderClose(sell,OrderLots(),NormalizeDouble(Ask,Digits),2); buy = 0; sell = 0;}
  
   if (Start == 1)    //���� �������� ���������
      {
       ObjectCreate("UrUp",OBJ_HLINE,0,0,UrUp);         //������� �������������� �����
       ObjectSet("UrUp",OBJPROP_COLOR,DarkBlue);
       ObjectCreate("UrDown",OBJ_HLINE,0,0,UrDown);
       ObjectSet("UrDown",OBJPROP_COLOR,Red);
      
      
       if (Close[1] > UrUp && buy == 0){       //��������� ������� ����� �� ��������
         buy = OrderSend(Symbol(),OP_BUY,Lot,NormalizeDouble(Ask,Digits),2,NormalizeDouble(Ask-SL*Point,Digits),NormalizeDouble(Ask+TP*Point,Digits));
         if (buy < 0) Comment (" ����� ������ ������ ",GetLastError());}
       
       if (Close[1] < UrUp && buy > 0){        //��������� ������� ����� �� ��������
         OrderClose(buy,Lot,NormalizeDouble(Bid,Digits),2);
         if (GetLastError() == 0) buy = 0;} 
      
        if (Close[1] < UrDown && sell == 0){    //��������� ������ ����� �� ��������
         sell = OrderSend(Symbol(),OP_SELL,Lot,NormalizeDouble(Bid,Digits),2,NormalizeDouble(Bid+SL*Point,Digits),NormalizeDouble(Bid-TP*Point,Digits));
         if (sell < 0) Comment (" ����� ������ ������  ",GetLastError());} 
         
       if (Close[1] > UrDown && sell > 0){      //��������� ������ ����� �� ��������
         OrderClose(sell,Lot,NormalizeDouble(Ask,Digits),2);
         if (GetLastError() == 0) sell = 0;}       
      }       
   return(0);
  }

