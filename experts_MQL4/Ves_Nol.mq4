/*
�������� ��������� ��� � ��� ������ ����� ������������ ���������� ������� �������� 
���������� ����� � ��������� ���� � ���� ������. ������ ����� ����������� �� ���
��� ���� �� ����� ��������� ����� ������������ ������� ���� ������� � ���������, 
����� ������ ���������, �� ��� ������ ����������� � ��� ���������� ������.
*/


//+------------------------------------------------------------------+
//|                                                      Ves_Nol.mq4 |
//|                                                         Ves Volk |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Ves Volk"
#property link      ""

extern double TotalProfit   = 10.0;  //������� ��� ������ ��� ���������� ������ ������� � �������
extern double Lot           = 1.0;   //���
extern int Shag             = 20;    //������ ���� � ������� ��� �������� ����������� ������ � �������� ������

double CloseProfit;    //���������� ������� �������� � ����
int Napravlenie;       //����������� �������� �������: 0 - �����������, 1 - �������, 2 - �������
int umn, PunktPlus;


int start()
  {
   if (Digits == 5)
      umn = 100000;
   if (Digits == 4)
      umn = 10000;
  
   //������� ����� ������ �� �����
   Comment ("\n  ����� ������� ������� � ��������� �������� ", AccountProfit () + CloseProfit,
            "\n  ������� ��� ������ ��� ���������� ������� � ", TotalProfit,
            "\n  ��������������� ������� ", CloseProfit);
   
   
   //��������� �� ������� �������� �������
   if (OrdersTotal () > 0)
      {
       //��������� ����� ������� ������� � �������
         //���� ����� �������������, �� ��������� ��� ������
       if (AccountProfit () + CloseProfit > TotalProfit)
         {
          for (int a = OrdersTotal(); OrdersTotal() != 0; a--)
            {
             if (OrderSelect (a - 1, SELECT_BY_POS) == true)
               {
                if (OrderType () == OP_BUY)
                  OrderClose (OrderTicket(), OrderLots(), NormalizeDouble (MarketInfo (OrderSymbol (), MODE_BID), Digits), 2);
                if (OrderType () == OP_SELL)
                  OrderClose (OrderTicket(), OrderLots(), NormalizeDouble (MarketInfo (OrderSymbol (), MODE_ASK), Digits), 2);
                if (OrderType () > 1)
                  OrderDelete (OrderTicket ());
               }
             if (a == 0 && OrdersTotal () != 0)
               a = OrdersTotal ();
            }
         }
         
         else
         {
         //���� ������� �������������, �� ���� ���������� �����
            //���� ������� ��� �������� ������, �� ���������� ����������� ��������
          if (OrdersTotal () == 2 && Napravlenie == 0)
            {
             for (int x = OrdersTotal (); x != -1; x--)
                if (OrderSelect (x, SELECT_BY_POS) == true)
                  if (OrderProfit () > 0)
                     {
                      if (OrderType () == OP_BUY) //���� ����� ���
                        {
                         PunktPlus = (Bid - OrderOpenPrice ()) * umn;
                         if (PunktPlus >= Shag)
                           {
                            CloseProfit = CloseProfit + OrderProfit ();
                            Napravlenie = 1;
                            OrderClose (OrderTicket (), OrderLots (), NormalizeDouble (Bid, Digits), 2);
                            OrderSend (Symbol (), OP_BUY, Lot, NormalizeDouble (Ask,Digits), 2, 0, 0);
                            OrderSend (Symbol (), OP_SELL, Lot, NormalizeDouble (Bid,Digits), 2, 0, 0);
                            return;
                           }
                        }
                      if (OrderType () == OP_SELL)   //���� ����� ���
                        {
                         PunktPlus = (OrderOpenPrice () - Ask) * umn;
                         if (PunktPlus >= Shag)
                           {
                            CloseProfit = CloseProfit + OrderProfit ();
                            Napravlenie = 2;
                            OrderClose (OrderTicket (), OrderLots (), NormalizeDouble (Ask, Digits), 2);
                            OrderSend (Symbol (), OP_BUY, Lot, NormalizeDouble (Ask,Digits), 2, 0, 0);
                            OrderSend (Symbol (), OP_SELL, Lot, NormalizeDouble (Bid,Digits), 2, 0, 0);
                            return;
                           }
                        }
                     }
            }
            //���� ����������� �������� ���������� � ������� ������ ���� �������� �������
          if (OrdersTotal () > 2 && Napravlenie > 0)
            {
             if (Napravlenie == 1)  //���� ����������� �� ���
               {
                for (int c = OrdersTotal (); c != -1; c--)
                  if (OrderSelect (c, SELECT_BY_POS) == true)
                     {
                      if (OrderType () == OP_SELL)
                        continue;
                      if (OrderProfit () < 0)
                        continue;
                      else
                        {
                         PunktPlus = (Bid - OrderOpenPrice ()) * umn;
                         if (PunktPlus >= Shag)
                           {
                            CloseProfit = CloseProfit + OrderProfit ();
                            OrderClose (OrderTicket (), OrderLots (), NormalizeDouble (Bid, Digits), 2);
                            OrderSend (Symbol (), OP_BUY, Lot, NormalizeDouble (Ask,Digits), 2, 0, 0);
                            OrderSend (Symbol (), OP_SELL, Lot, NormalizeDouble (Bid,Digits), 2, 0, 0);
                            return;
                           }
                        }
                     }
               }
             if (Napravlenie == 2)  //���� ����������� �� ���
               {
                for (int bb = OrdersTotal (); bb != -1; bb--)
                  if (OrderSelect (bb, SELECT_BY_POS) == true)
                     {
                      if (OrderType () == OP_BUY)
                        continue;
                      if (OrderProfit () < 0)
                        continue;
                      else
                        {
                         PunktPlus = (OrderOpenPrice () - Ask) * umn;
                         if (PunktPlus >= Shag)
                           {
                            CloseProfit = CloseProfit + OrderProfit ();
                            OrderClose (OrderTicket (), OrderLots (), NormalizeDouble (Ask, Digits), 2);
                            OrderSend (Symbol (), OP_BUY, Lot, NormalizeDouble (Ask,Digits), 2, 0, 0);
                            OrderSend (Symbol (), OP_SELL, Lot, NormalizeDouble (Bid,Digits), 2, 0, 0);
                            return;
                           }
                        }
                     }
               }
            }
         }
      }
      //���� �������� ������� ���, �� �������� ������
   else
      {
       OrderSend (Symbol (), OP_BUY, Lot, NormalizeDouble (Ask,Digits), 2, 0, 0);
       OrderSend (Symbol (), OP_SELL, Lot, NormalizeDouble (Bid,Digits), 2, 0, 0);
       CloseProfit = 0;
       Napravlenie = 0;
      }
   return(0);
  }

