/*
������������� ������. ������ �������, ������� ������� ��� �������� ���� �����, ���������� �����������, ��������� ���������.
� ��������� ���� ������������ ����� ������� ������� ��� ������������ ������. � ��������� ��� �� �������������. ����� ������ ��� �� ������ �������
�� ����� �����������
*/
#property copyright "Ves Volk"
#property link      ""


extern double ��� = 0.01;
extern int ������� = 200;
extern int ����������� = 30;
extern int ������1������ = 200;
extern int �������� = -50;
extern int ������� = 8;
extern int �������������� = 2;
extern bool ����������� = false;
extern int ��������������� = 6;
extern int �������������� = 19;


int �����1��������, �����������, ������������������;
double ����������������������;
datetime ���������������;

int start()
  {
   //��������� ������� �������--------------------------------------------------------
      //���� ������
   if (OrdersTotal () > 0)
   {
      //���� �������� ����� ����
      if (OrdersTotal() == 1)
         //��������� �������� �� ������ ����� �� �������, ���� �� �� ��������� ��� ������
         if (OrderSelect(�����1��������, SELECT_BY_TICKET) == true)
            if (OrderCloseTime() > 0)
               �������������();
      //��������� ������� ����������� ���������
      ������������������ = OrdersTotal() - 1;
      //��������� ����� �� ��� ��������������-----------------------------------------
         //����� ��������������
      if (������������������ < ��������������)
      {
         //��������� ����� �������� ������
         ��������������� = 0;
         int a = 0;
         for (int i = OrdersTotal(); i != -1; i--)
            if (OrderSelect (i, SELECT_BY_POS) == true)
            {
               if (a == 0)
               {
                  a = 1;
                  ��������������� = TimeLocal() - OrderOpenTime();
                  ����������� = OrderTicket();
                  continue;
               }
               
               if (TimeLocal() - OrderOpenTime() < ���������������)
               {
                  ��������������� = TimeLocal() - OrderOpenTime();
                  ����������� = OrderTicket();
               }
            }
            
         //��������� ��� �������� ������---------------------------------------------------
         if (OrderSelect (�����������, SELECT_BY_TICKET) == true)
            //����� ��������
            if (OrderType() < 2)
            {
               //������� ������ � ������� ������
               if (OrdersTotal() == 2)
                  OrderModify (�����1��������, 0, 0, 0, 0);
               //���������� ���������� �����---------------------------------------------------
               if (OrderType() == OP_SELL)
               {
                  ����������� = OrderSend (Symbol(), OP_BUYSTOP, OrderLots() * �������, NormalizeDouble (OrderOpenPrice() + ������� * Point, Digits), 2, 0, 0);
                  if (����������� == -1)
                  {
                     Print ("����� ������ ������ ", GetLastError());
                     return;
                  }
               }
               else
               {
                  ����������� = OrderSend (Symbol(), OP_SELLSTOP, OrderLots() * �������, NormalizeDouble (OrderOpenPrice() - ������� * Point, Digits), 2, 0, 0);
                  if (����������� == -1)
                  {
                     Print ("����� ������ ������ ", GetLastError());
                     return;
                  }
               }
            }
            //���������� �����
            else
            {
               //���� �������� ����� ���� �� �� ������ ��������� �� �����
               if (OrdersTotal() == 2)
                  return;
               //��������� ����� ���������� ��������� ������
               ��������������� = 0;
               int b = 0;
               for (int i2 = OrdersTotal(); i2 != -1; i2--)
                  if (OrderSelect (i2, SELECT_BY_POS) == true)
                  {
                     if (OrderType() > 1)
                        continue;
                     if (b == 0)
                     {
                        b = 1;
                        ��������������� = TimeLocal() - OrderOpenTime();
                        ����������� = OrderTicket();
                        continue;
                     }
               
                     if (TimeLocal() - OrderOpenTime() < ���������������)
                     {
                        ��������������� = TimeLocal() - OrderOpenTime();
                        ����������� = OrderTicket();
                     }
                  }
               //��������� ������ ���������� ��������� ������------------------------------------------------------
               if (OrderSelect (�����������, SELECT_BY_TICKET) == true)
                  //���� ��� �����
                  if (OrderType() == OP_SELL)
                  {
                     //���� ������ ������������� �� �������
                     if (OrderOpenPrice() - Ask <= 0)
                        return;
                     //���� ������ �������������   
                     else
                        if (OrderOpenPrice() - Ask >= ����������� * Point)
                           �������������();
                  }
                  //���� ��� �����      
                  else
                  {
                     //���� ������ ������������� �� �������
                     if (Bid - OrderOpenPrice() <= 0)
                        return;
                     //���� ������ �������������   
                     else
                        if (Bid - OrderOpenPrice() >= ����������� * Point)
                           �������������();
                   }
            }
      }
         //������ ��������������-------------------------------------------------------------------------------------
      else
      {
         //��������� ����� �������� ������
         ��������������� = 0;
         int c = 0;
         for (int i3 = OrdersTotal(); i3 != -1; i3--)
            if (OrderSelect (i3, SELECT_BY_POS) == true)
            {
               if (c == 0)
               {
                  c = 1;
                  ��������������� = TimeLocal() - OrderOpenTime();
                  ����������� = OrderTicket();
                  continue;
               }
               
               if (TimeLocal() - OrderOpenTime() < ���������������)
               {
                  ��������������� = TimeLocal() - OrderOpenTime();
                  ����������� = OrderTicket();
               }
            }
         
         //��������� ��� ���������� ������----------------------------------------------------------------------
         if (OrderSelect (�����������, SELECT_BY_TICKET) == true)
            //������� ����� �������� ��������
            if (OrderType() < 2)
               //���
               if (OrderType() == OP_SELL)
               {
                  //���� ������ �������������
                     if (OrderOpenPrice() - Ask <= �������� * Point)
                        �������������();
                     //���� ������ �������������   
                     else
                        if (OrderOpenPrice() - Ask >= ����������� * Point)
                           �������������();
               }
               //���
               else
               {
                  //���� ������ �������������
                     if (Bid - OrderOpenPrice() <= �������� * Point)
                        �������������();
                     //���� ������ �������������   
                     else
                        if (Bid - OrderOpenPrice() >= ����������� * Point)
                           �������������();
                }
            //������� ����� �������� ����������
            else
            {
               //��������� ����� ���������� ��������� ������
               ��������������� = 0;
               int bb = 0;
               for (int i4 = OrdersTotal(); i4 != -1; i4--)
                  if (OrderSelect (i4, SELECT_BY_POS) == true)
                  {
                     if (OrderType() > 1)
                        continue;
                     if (bb == 0)
                     {
                        bb = 1;
                        ��������������� = TimeLocal() - OrderOpenTime();
                        ����������� = OrderTicket();
                        continue;
                     }
               
                     if (TimeLocal() - OrderOpenTime() < ���������������)
                     {
                        ��������������� = TimeLocal() - OrderOpenTime();
                        ����������� = OrderTicket();
                     }
                  }
                  
               //��������� ��������� �������� ����� �� ������---------------------------------------------------------------
               if (OrderSelect (�����������, SELECT_BY_TICKET) == true)
                  //���� ��� �����
                  if (OrderType() == OP_SELL)
                  {
                     //���� ������ ������������� �� �������
                     if (OrderOpenPrice() - Ask <= 0)
                        return;
                     //���� ������ �������������   
                     else
                        if (OrderOpenPrice() - Ask >= ����������� * Point)
                           �������������();
                  }
                  //���� ��� �����      
                  else
                  {
                     //���� ������ ������������� �� �������
                     if (Bid - OrderOpenPrice() <= 0)
                        return;
                     //���� ������ �������������   
                     else
                        if (Bid - OrderOpenPrice() >= ����������� * Point)
                           �������������();
                   }
            }
         
      }
   }
      //��� �������-------------------------------------------------------------------------------------------------------
   else
   {
      //��������� ������� �� �������� �������
      if (�����������)
      {
         //���� ����� �� �������, �� �������
         if (Hour() < ��������������� || Hour() > ��������������)
            return;
      }
      //���������� �������
      �����1�������� = OrderSend (Symbol(), OP_BUY, ���, NormalizeDouble(Ask, Digits), 2, 0, 0);
      if (�����1�������� == -1)
      {
         Print ("����� ������ ������ ", GetLastError());
         return;
      }
      
      if (OrderSelect (�����1��������, SELECT_BY_TICKET) == true)
         ���������������������� = OrderOpenPrice();
      
      OrderModify (�����1��������, 0, 0, NormalizeDouble (���������������������� + ������1������ * Point, Digits), 0);
      
      ����������� = OrderSend (Symbol(), OP_SELLSTOP, ��� * �������, NormalizeDouble(���������������������� - ������� * Point, Digits), 2, 0, 0);
      if (����������� == -1)
      {
         Print ("����� ������ ������ ", GetLastError());
         OrderClose (�����1��������, ���, NormalizeDouble(Bid, Digits), 2);
         return;
      }
   }    
   
   return(0);
  }




//---------------------������� �������� ���� �������------------------------------------------------------------------------
void ������������� ()
{
   for (int del = OrdersTotal(); del != -1; del --)
      if (OrderSelect (del, SELECT_BY_POS) == true)
         if (OrderType() == OP_BUY)
            OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), 2);
         else
            if (OrderType() == OP_SELL)
               OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Ask, Digits), 2);
            else
               OrderDelete(OrderTicket());
}