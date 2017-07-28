//+------------------------------------------------------------------+
//|                                                   FractalExp.mq4 |
//|                                                              Ves |
//|                                                                  |
//+------------------------------------------------------------------+

/*
�������� �������� �� ��������� � ����� �� ������� �������� (���� �������� ������������ �������.
������� ������������ ����� ���� ������ 2 ������ (��� � ���). ���� ������� �� ������ 2 �����, 
�� �������� ��������� �����, ���� ������� ������ �� ����� ���(�������� ��� ������� + 5 �������, ���������� ����� ��),
���� ������� ����� �� ����� ���
*/
#property copyright "Ves"
#property link      ""

extern double Lot = 0.1;     //���
extern bool ETime = false;   //�������� ����� ��������
extern int StartTime = 7;    //������ �������� ������������
extern int FinishTime = 19;  //����� �������� ������������

int orderBuy, orderSell;     //���� ������� 
double SL, TP;               //�������� � ����������

int start()
  {
   
   //**********************��������� ������� ���������*************************   
   
   int nU;               //������� �������� ��������
   double FracUp [5];    //�������� � 1-�� �������� �� 5-� �������
   int BarFracUp [5];    //����� ���� ��� ������� � 1 �� 5 �������
   int nD;               //������� ������� ��������
   double FracD [5];     //�������� � 1-�� �������� �� 5-� ������
   int BarFracD [5];     //����� ���� ��� ������� � 1 �� 5 ������
       
       
       //���� ���������� �������� ��������
    for ( int i = 0; i < Bars; i++)
      {    
       double fU = iFractals (Symbol(),0,MODE_UPPER,i);
       if (fU != 0 && fU != EMPTY_VALUE)
         {
          FracUp[nU] = fU;
          BarFracUp[nU] = i;
          nU ++;
          if ( nU >= 5) break;
         }
      }
        
        
        //���� ���������� ������� ��������
    for ( int a = 0; a < Bars; a++)
      {
       double fD = iFractals (Symbol(),0,MODE_LOWER,a);
       if (fD != 0 && fD != EMPTY_VALUE)
         {
          FracD[nD] = fD;
          BarFracD[nD] = a;
          nD ++;
          if ( nD >= 5) break;
         }
      }
      
    //*****************************������� ������ �������� ������*************

    if ( ETime == true && Hour() >= StartTime && Hour() <= FinishTime){ //���� ����� ��������
 
            //��������� �������� �� ����� ��� �� ������� ��� �����
    if (OrderSelect(orderBuy,SELECT_BY_TICKET) == true)
      if (OrderCloseTime() > 0)
         orderBuy = 0; 
          
          //��������� ���     
    if (BarFracD[0] < BarFracUp[0] && BarFracD[0] <= 2)
      {
       if (orderBuy == 0){
         SL = NormalizeDouble(FracD[0] - 5*Point,Digits);  //��������� ������� ���������
         TP = Ask - SL;      //��������� ������� �����������
         orderBuy = OrderSend(Symbol(),OP_BUY,Lot,NormalizeDouble(Ask,Digits),2,SL,NormalizeDouble(Ask + TP,Digits));
         if (orderBuy < 0) Comment(" ����� ������ ������ ",GetLastError());}
       
      }
         
         
         
         //��������� �������� �� ����� ��� �� ������� ��� �����
    if (OrderSelect(orderSell,SELECT_BY_TICKET) == true)
      if (OrderCloseTime() > 0)
         orderSell = 0;         
     
           //��������� ���
    if (BarFracUp[0] < BarFracD[0] && BarFracUp[0] <= 2)
      {
       if (orderSell == 0){
         SL = NormalizeDouble(FracUp[0] + 5*Point,Digits);  //��������� ������� ���������
         TP = SL - Bid;      //��������� ������� �����������
         orderSell = OrderSend(Symbol(),OP_SELL,Lot,NormalizeDouble(Bid,Digits),2,SL,NormalizeDouble(Bid-TP,Digits));
         if (orderSell < 0) Comment(" ����� ������ ������ ",GetLastError());}
       
      }      
   }
   
   else 
      return;       
   return(0);
  }

