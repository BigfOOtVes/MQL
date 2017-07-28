/*
�������� ���������� ��� �������� ������ �� ���������� ���� � ����������� �� �� ����� ���� ��� �� ����� ���������.
*/
//+------------------------------------------------------------------+
//|                                                     Ves_Test.mq4 |
//|                                                         Ves Volk |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Ves Volk"
#property link      ""


extern double ��� = 0.1;
extern int ��� = 100;
extern int ���� = 150;
extern int ���� = 300;

int �����������, �����������, ����������������������, a;

int start()
  {
   //��������� ������� �������
   if (OrdersTotal() > 0)
      //���� ������. ��������� �������
      //���� ����
      if (OrdersTotal() == 1)
         {
          if (OrderSelect(0,SELECT_BY_POS) == true)
            {
             if (OrderType() == OP_BUY)
               {
                a = OrderSend (Symbol(), OP_SELLLIMIT, ���, NormalizeDouble(Bid + ��� * Point, Digits), 2, NormalizeDouble(Bid + ��� * Point + ���� * Point, Digits), NormalizeDouble(Bid + ��� * Point - ���� * Point, Digits));
                if (a == -1)
                   Print ("����� ������ ������ ", GetLastError());
                return;
               }
             else
               if (OrderType() == OP_SELL)
                  {
                   a = OrderSend (Symbol(), OP_BUYLIMIT, ���, NormalizeDouble(Bid - ��� * Point, Digits), 2, NormalizeDouble(Bid - ��� * Point - ���� * Point, Digits), NormalizeDouble(Bid - ��� * Point + ���� * Point, Digits));
                   if (a == -1)
                     Print ("����� ������ ������ ", GetLastError());
                   return;
                  }
               else
                  if (OrderType() == OP_SELLLIMIT)
                     {
                      �������������� (OrderTicket(), ���);
                      a = OrderSend (Symbol(), OP_BUYLIMIT, ���, NormalizeDouble(Bid - ��� * Point, Digits), 2, NormalizeDouble(Bid - ��� * Point - ���� * Point, Digits), NormalizeDouble(Bid - ��� * Point + ���� * Point, Digits));
                      if (a == -1)
                        Print ("����� ������ ������ ", GetLastError());
                      return;
                     }
                  else
                     if (OrderType() == OP_BUYLIMIT)
                        {
                         �������������� (OrderTicket(), ���);
                         a = OrderSend (Symbol(), OP_SELLLIMIT, ���, NormalizeDouble(Bid + ��� * Point, Digits), 2, NormalizeDouble(Bid + ��� * Point + ���� * Point, Digits), NormalizeDouble(Bid + ��� * Point - ���� * Point, Digits));
                         if (a == -1)
                            Print ("����� ������ ������ ", GetLastError());
                         return;
                        }
                     else
                        return;
             
            }
         }//----------------------------
      //���� ���
      else
         {
          ���������������������� = 0;
          for (int i = 0; i <= OrdersTotal() -1; i++)
            {
             if (OrderSelect(i, SELECT_BY_POS) == true)
               {
                if (OrderType() < 2)
                  {
                   ����������������������++;
                   ����������� = 0;
                   ����������� = 0;
                   continue;
                  }
                if (OrderType() == OP_BUYLIMIT)
                  ����������� = OrderTicket();
                if (OrderType() == OP_SELLLIMIT)
                  ����������� = OrderTicket();
               } 
            }
            
          //���� ��� �������� �������
          if (���������������������� == 0)
            {
               �������������� (�����������, ���);
               �������������� (�����������, ���);
               return;
            }
          //���� ���� ���� �������� �����
          else
            if (���������������������� == 1)
               if (����������� > 0)
                  �������������� (�����������, ���);
               else
                  �������������� (�����������, ���);
            //���� ��� �������� ������      
            else
               return;
         }
   
   //��� ������� ���������� �����
   else
      {
       a = OrderSend (Symbol(), OP_BUYLIMIT, ���, NormalizeDouble(Bid - ��� * Point, Digits), 2, NormalizeDouble(Bid - ��� * Point - ���� * Point, Digits), NormalizeDouble(Bid - ��� * Point + ���� * Point, Digits));
       if (a == -1)
         Print ("����� ������ ������ ", GetLastError());
       
       a = OrderSend (Symbol(), OP_SELLLIMIT, ���, NormalizeDouble(Bid + ��� * Point, Digits), 2, NormalizeDouble(Bid + ��� * Point + ���� * Point, Digits), NormalizeDouble(Bid + ��� * Point - ���� * Point, Digits));
       if (a == -1)
         Print ("����� ������ ������ ", GetLastError());
      }
  
   return(0);
  }


//------------������� ����� ����� ������---------------------
void �������������� (int ���������, int ��������)
   {
    if (OrderSelect(���������, SELECT_BY_TICKET) == true)
      {
       if (OrderType() == OP_BUYLIMIT)
         if (Bid - OrderOpenPrice() > �������� * Point)
            OrderModify (OrderTicket(), NormalizeDouble(Bid - �������� * Point, Digits), NormalizeDouble(Bid - �������� * Point - ���� * Point, Digits), NormalizeDouble(Bid - �������� * Point + ���� * Point, Digits), 0);
         else
            return;
            
       if (OrderType() == OP_SELLLIMIT)
         if (OrderOpenPrice() - Bid > �������� * Point)
            OrderModify (OrderTicket(), NormalizeDouble(Bid + �������� * Point, Digits), NormalizeDouble(Bid + �������� * Point + ���� * Point, Digits), NormalizeDouble(Bid + �������� * Point - ���� * Point, Digits), 0);
         else
            return;
      }
   }