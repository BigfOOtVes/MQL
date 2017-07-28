/*
�������� �������� ��� ����������� �� ����������� ���������� ����������
*/
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
#include <Trade\PositionInfo.mqh>


input int Profit = 20;           //����� ������ � �������
input int Ubitok = -20;          //����� ������ � �������
input double Lot = 1.0;          //������ ����
input double MaxZnach = 0.005;   //������������ �������� ��� ��������
input bool CloseMinZnach = false;//��������� �� ������������ �������� ���������� ?
input double MinZnach = 0.0005;  //����������� �������� ��� �������� �������

input bool Dolivka1 = false;     //��������� ������ ������� ?
input int Profit1Dolivka = 40;   //������ ��� ������ �������
input int Ubitok1Dolivka = -80;  //������ ��� ������ �������

//������� ��������� ����������
input string Instr1   =  "EURUSD.m";  //������ ����
input string Instr2   =  "GBPUSD.m";  //������ ����
input int    KolBarov = 3000;         //���������� �������������� �����

input int       ExtParam5 = 1000;   //����� ����������� ��� ������� �����������
input int       ExtParam6 = 1000;   //����� ����������� ��� ������� �����������
input int       ExtParam7 = 21;     //��������� �������
input int       ExtParam8 = 13;     //������� �������
input ENUM_MA_METHOD      ExtParam9  = MODE_SMMA;        //����� ����������
input ENUM_APPLIED_PRICE  ExtParam10 = PRICE_WEIGHTED;   //������������ ���� ��� ����������


//����� ����������
int Hendl;
//������������ ������
double para1[], para2[];

CTrade GO;            //������ ���������� ��� ��������
CPositionInfo GOinfo;
int a;                //��� �������� ������ �������
double TotalProfit;
double Money;
double Rasxod, MaxRasxod, Sch;
int KolDolivok;
bool StartDolivka1 = Dolivka1;


int OnInit()
{
   Hendl = iCustom (Symbol(), PERIOD_CURRENT, "Ves_2toolsV3", Instr1, Instr2, KolBarov, ExtParam5, ExtParam6, ExtParam7, ExtParam8, ExtParam9, ExtParam10);
   ArraySetAsSeries(para1,true);
   ArraySetAsSeries(para2,true);
   return (0);
}


void OnTick()
{
   //����������� �������� ���������� ��������
   CopyBuffer (Hendl, 0, 0, KolBarov, para1);
   CopyBuffer (Hendl, 1, 0, KolBarov, para2);
   //��������� ����������� ����������
   if(para1[0] > para2[0])
      Rasxod = NormalizeDouble(para1[0] - para2[0], Digits());
   else
      Rasxod = NormalizeDouble(para2[0] - para1[0], Digits());
      
   //��������� ������������ �������� �����������
   for (int x = 0; x < KolBarov; x++)
   {
      if(para1[x] > para2[x])
         Sch = NormalizeDouble(para1[x] - para2[x], Digits());
      else
         Sch = NormalizeDouble(para2[x] - para1[x], Digits());
         
      if (Sch > MaxRasxod)
         MaxRasxod = Sch;
   }
   //��������� ������� �������----------------------------------------------------------------------------------------------------
   //������ �������
   if (PositionsTotal() > 0) 
   {
      //��������� ��������� �� ����� ������ � �������----------------------------------------------------------------------------
      Money = AccountInfoDouble (ACCOUNT_PROFIT);
      TotalProfit = (Money / (10 * Lot));
      //������ ���������
      if (TotalProfit >= Profit)
      {
         switch (KolDolivok)
         {
            case 1:
               if (TotalProfit >= Profit1Dolivka)
               {
                  CloseAllOrders();
                  Print ("�������� �� ������ ������� ", TotalProfit + " �������");
                  Print ("������ � ������ ", Money);
                  TotalProfit = 0;
                  KolDolivok = 0;
                  StartDolivka1 = Dolivka1;
               }
               break;
            default:
               CloseAllOrders();
               Print ("�������� �� ������ ������� ", TotalProfit + " �������");
               Print ("������ � ������ ", Money);
               TotalProfit = 0;
               break;
         }
         
         
         /*
         CloseAllOrders();
         Print ("������ � ������ ", Money, ". �������� �� ������ ������� ", TotalProfit + " �������");
         TotalProfit = 0;*/
      }
      else
      {
         //��������� ����� ������ � �������--------------------------------------------------------------------------------------
         switch (KolDolivok)
         {
            case 1:
               if (TotalProfit <= Ubitok1Dolivka)
               {
                  CloseAllOrders();
                  Print ("�������� �� ������ ������� ", TotalProfit + " �������");
                  Print ("������ � ������ ", Money);
                  TotalProfit = 0;
                  KolDolivok = 0;
                  StartDolivka1 = Dolivka1;
               }
               break;
            default:
               if (TotalProfit <= Ubitok)
               {
                  //���� ������� ���������, �� ����������
                  if (StartDolivka1 == true)
                  {
                     //����������� � �� �� ������� ������������ ������ ������
                     GOinfo.Select(Instr1);
                     if (GOinfo.PositionType() == POSITION_TYPE_BUY)
                     {
                        OrdersOpen_Sell_Buy (Instr2, Instr1, Lot * 2);
                        Print ("�������. ������� ", Instr2, ", ������ ", Instr1);
                        Print ("������ ", TotalProfit + " �������");
                     }
                     else
                     {
                        OrdersOpen_Sell_Buy (Instr1, Instr2, Lot * 2);
                        Print ("�������. ������� ", Instr1, ", ������ ", Instr2);
                        Print ("������ ", TotalProfit + " �������");
                     }
                        
                     KolDolivok ++;
                     StartDolivka1 = false;
                  }
                  //���� ������� ���������, �� ��������� ������
                  else
                  {
                     CloseAllOrders();
                     Print ("�������� �� ������ ������� ", TotalProfit + " �������");
                     Print ("������ � ������ ", Money);
                     TotalProfit = 0;
                  }
               }
               break;
         }
         
         
         /*
         if (TotalProfit <= Ubitok)
         {
            //���� ������� ���������, �� ����������
            if (Dolivka1 == true)
            {
               //����������� � �� �� ������� ������������ ������ ������
               GOinfo.Select(Instr1);
               if (GOinfo.PositionType() == POSITION_TYPE_BUY)
                  OrdersOpen_Sell_Buy (Instr2, Instr1, Lot * 2);
               else
                  OrdersOpen_Sell_Buy (Instr1, Instr2, Lot * 2);
                  
               KolDolivok ++;
            }
            //���� ������� ���������, �� ��������� ������
            else
            {
               CloseAllOrders();
               Print("������ � ������ ", Money, ". �������� �� ������ ������ ", TotalProfit + " �������");
               TotalProfit = 0;
            }
         }*/
      }
      //�������� ������ ���� ����������� �������� ���������� ����������------------------------------------------------------------
      if(Rasxod <= MinZnach && CloseMinZnach == true)
      {
         CloseAllOrders();
         Print("�������� �� ������������ �������� ���������� ", Rasxod);
         Print("������ � ������ ", Money);
         TotalProfit = 0;
      }
   }
   //������ �����������------------------------------------------------------------------------------------------------------------
   else
   {
      //���������� ���� �� ������ �� ����������
      //������� 1-�� �����������-----------------------------------------------------------------------------------------------------
      if (Rasxod >= MaxZnach && para1[0] > para2[0])
      {
         OrdersOpen_Sell_Buy (Instr1, Instr2, Lot);
         Print ("������� ", Instr1, ", ������ ", Instr2);
         Print ("����������� ", Rasxod);
      }
      //������� 2-�� �����������---------------------------------------------------------------------------------------------------
      else
      {
         if (Rasxod >= MaxZnach)
         {
            OrdersOpen_Sell_Buy (Instr2, Instr1, Lot);
            Print ("������� ", Instr2, ", ������ ", Instr1);
            Print ("����������� ", Rasxod);
         }
      }
   }
   
   Comment ("\n  ������ = ", TotalProfit,
            "\n  ������� ����������� = ", Rasxod,
            "\n  ������������ ����������� = ", MaxRasxod);
}


//--------------------�������-----------------------------------------------------------------------------------
void OrdersOpen_Sell_Buy (string inst1, string inst2, double llot)
{
   //���������� ����� �� �������
   ResetLastError();
   a = GO.Sell (llot, inst1);
   if (a == false || GetLastError() != 0)
   {
      Print ("����� ������ ������ ", GetLastError());
      Print ("������ ��������� ������� ", GO.ResultRetcode());
   }
   
   //���������� ����� �� �������
   ResetLastError();
   a = GO.Buy (llot, inst2);
   if (a == false || GetLastError() != 0)
   {
      Print ("����� ������ ������ ", GetLastError());
      Print ("������ ��������� ������� ", GO.ResultRetcode());
      GO.PositionClose(inst1, 2);
   }
}



void CloseAllOrders ()
{
   GO.PositionClose(Instr1, 2);
   GO.PositionClose(Instr2, 2);
}