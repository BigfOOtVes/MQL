/*
�������� �������� ��� ������� ���� � ���������� � ���������� ����
*/
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>          //����������� ���������� ��� ������������� �������� �������
#include <Trade\PositionInfo.mqh>   //����������� ���������� ��� ������������� ���������� �� �������� ��������


input string Para1 = "EURUSD.m";    //������ ����
input ENUM_POSITION_TYPE TypePara1 = POSITION_TYPE_BUY;    //��� �������� ������� ����

input string Para2 = "GBPUSD.m";    //������ ����
input ENUM_POSITION_TYPE TypePara2 = POSITION_TYPE_SELL;   //��� �������� ������ ����

input string Para3 = "EURGBP.m";    //������ ����
input ENUM_POSITION_TYPE TypePara3 = POSITION_TYPE_BUY;    //��� �������� ������� ����

input string Para4 = "GBPCHF.m";    //��������� ����
input ENUM_POSITION_TYPE TypePara4 = POSITION_TYPE_BUY;    //��� �������� ��������� ����

input string Para5 = "EURNZD.m";    //����� ����
input ENUM_POSITION_TYPE TypePara5 = POSITION_TYPE_BUY;     //��� �������� ����� ����

input string Para6 = "NZDCHF.m";    //������ ����
input ENUM_POSITION_TYPE TypePara6 = POSITION_TYPE_BUY;     //��� �������� ������ ����

input double Lot = 1.0;             //���
input int Profit = 100;             //����� ������ ��� �������� ������
input bool TypeDD = false;          //��� �������: true - � ����� �������� "1-� �������"(DD), false - ������� ����
input int DD  = 100;                //1-� �������
input int DD2 = 100;                //2-� �������
input int DD3 = 200;                //3-� �������
input bool StopProfitPara = false;  //�������� �������� ������������� ������� ����
input int ProfitPara = 500;         //������� ������� �������� ����. �������� ��� StopProfitPara = truy;
input bool revers = false;          //��������� � �������� ����������� ���� ����� ������������
input bool lotStart = false;        //������������� ��������� ��� ����� ������������ 
input bool Time = false;            //�������� � ������������ �����
input int timeStart = 7;            //� ������ ���� ��������
input int timeFinish = 18;          //����� ������ ���� �����������
input int Piatnica = 17;            //� ������� ����� ������ ���� �����������
input bool TimePeriod = false;      //������ ��������� ����� ������� �������� ���� �������� ����������
input bool ProfitControl = false;   //��������� ������ ���������, � �� ��� ������ �������� ����. �������� ����� TimePeriod = true

CTrade GO;              //������ ������ ��� �������� �������     
CPositionInfo GOinfo;   //������ ������ ��� ��������� ���������� �� �������� ��������
MqlDateTime timeServer; //������ ��������� ��� ��������� ������� �������

double PricePara1, PricePara2, PricePara3, PricePara4, PricePara5, PricePara6;
int qpara1, qpara2, qpara3, qpara4, qpara5, qpara6;
int AddDD1, AddDD2, AddDD3, AddDD4, AddDD5, AddDD6;
int BarsControl;

void OnTick()
{
   //���� ��� �������� �������-------------------------------------------------------------------------------
   if (PositionsTotal() == 0)
   {
      //�������� �������� �� ����� ���� ���. �� ������� ���� ������� ��������
      if (Time == true)
         TimeClose();
      
      //���������� �������
      if (Para1 != "")
         OpenPosition (Para1, TypePara1, PricePara1, qpara1);
      if (Para2 != "")
         OpenPosition (Para2, TypePara2, PricePara2, qpara2);
      if (Para3 != "")
         OpenPosition (Para3, TypePara3, PricePara3, qpara3);
      if (Para4 != "")
         OpenPosition (Para4, TypePara4, PricePara4, qpara4);
      if (Para5 != "")
         OpenPosition (Para5, TypePara5, PricePara5, qpara5);
      if (Para6 != "")
         OpenPosition (Para6, TypePara6, PricePara6, qpara6);
      
      BarsControl = Bars (Symbol(), PERIOD_CURRENT);
   }
   //���� �������� �������------------------------------------------------------------------------------------------
   else
   {
      //��������� ��������� �� ������ ���� ������� �������
      if (ProfitControl == true)
         if (AccountInfoDouble(ACCOUNT_PROFIT) >= Profit)
            ProfitPlusAllClose();
      
      //������ �� ���������� ����(������������� �������) ���� ������� ��������
      if (TimePeriod == true)
         NewBarGoExp();
      
      //��������� ��������� �� ������---------------------------------------------------------------------------------
      if (AccountInfoDouble(ACCOUNT_PROFIT) >= Profit)
         ProfitPlusAllClose();
      //���� ������ �� ���������
      else
      {
         //��������� ������ �� �����
         if (GOinfo.Select(Para1) == true)
            ControlPosition (Para1, PricePara1, qpara1, AddDD1);
         if (GOinfo.Select(Para2) == true)
            ControlPosition (Para2, PricePara2, qpara2, AddDD2);
         if (GOinfo.Select(Para3) == true)
            ControlPosition (Para3, PricePara3, qpara3, AddDD3);
         if (GOinfo.Select(Para4) == true)
            ControlPosition (Para4, PricePara4, qpara4, AddDD4);
         if (GOinfo.Select(Para5) == true)
            ControlPosition (Para5, PricePara5, qpara5, AddDD5);
         if (GOinfo.Select(Para6) == true)
            ControlPosition (Para6, PricePara6, qpara6, AddDD6);
      }
   }
}
  
   
//-------------------------------------------------------�������---------------------------------------------------------


//�������� �������� �� ����� ���� ���. �� ������� ���� ������� ��������
void TimeClose ()
{
   TimeCurrent(timeServer);
   if (timeServer.day_of_week == 5 && timeServer.hour > Piatnica)
      return;
   if (timeServer.hour < timeStart || timeServer.hour > timeFinish)
      return;        
}


//��������� ��������� �� ������ ���� ��������� ���������-------------------------------
void ProfitPlusAllClose ()
{
   double pp = AccountInfoDouble(ACCOUNT_PROFIT);
   if (GOinfo.Select(Para1) == true)
      GO.PositionClose(Para1, 2);
   if (GOinfo.Select(Para2) == true)
      GO.PositionClose(Para2, 2);
   if (GOinfo.Select(Para3) == true)
      GO.PositionClose(Para3, 2);
   if (GOinfo.Select(Para4) == true)
      GO.PositionClose(Para4, 2);
   if (GOinfo.Select(Para5) == true)
      GO.PositionClose(Para5, 2);
   if (GOinfo.Select(Para6) == true)
      GO.PositionClose(Para6, 2);
   Print ("�������� ���� �������. ������ ����� ", pp);
   AddDD1 = 0;
   AddDD2 = 0;
   AddDD3 = 0;
   AddDD4 = 0;
   AddDD5 = 0;
   AddDD6 = 0;
}   


//������ �� ���������� ����(������������� �������) ���� ������� ��������--------------------------
void NewBarGoExp ()
{
   //���� ����� ��� �� ��������, �� �������
   if (Bars (Symbol(), PERIOD_CURRENT) == BarsControl)
   {
      return;
   }
   //���� ����� ��� ��������
   else
   {
      BarsControl = Bars (Symbol(), PERIOD_CURRENT);
   }
}  


//������� ������� � ���������� ����-----------------------------------------------------------
void ControlPosition (string para, double &pricepara, int &qpara, int &addDD)
{
   if (GOinfo.Profit() > 0)
   {
      //��������� ���� � ��������� ���� ��� ������������ �������. ���� ������� ��������
      if (StopProfitPara == true)
      {
         double lot = GOinfo.Volume();
         double profit = GOinfo.Profit();
         ENUM_POSITION_TYPE type = GOinfo.PositionType();
         bool a;
         
         //������ ������ ���� ������� ��������
         if (revers == true)
         {
            if (type == POSITION_TYPE_BUY)
               type = POSITION_TYPE_SELL;
            else
               type = POSITION_TYPE_BUY;
         }
         
         //������ ��� ��������� ���� ������� ��������
         if (lotStart == true)
         {
            lot = LotBalance (para, Lot);
         }
         
         if (GOinfo.Profit() >= ProfitPara)
         {
            GO.PositionClose (para, 2);
            Print ("��������. ������ ���� ", para, " ", profit, ". ��� ���� ", GOinfo.Volume(), ". ��� ������� ", GOinfo.PositionType());
            ResetLastError();
            
            if (type == POSITION_TYPE_BUY)
            {
               a = GO.Buy (lot, para);
               if (a == false || GetLastError() != 0)
               {
                  Print ("����� ������ ������ ", GetLastError(), ". ������ ��������� ������� ", GO.ResultRetcode());
                  return;
               }
               Print ("������������ ���� ", para, " � ����� ", lot, ". ��� ������� ", type);
            }
            else
            {
               a = GO.Sell (lot, para);
               if (a == false || GetLastError() != 0)
               {
                  Print ("����� ������ ������ ", GetLastError(), ". ������ ��������� ������� ", GO.ResultRetcode());
                  return;
               }
               Print ("������������ ���� ", para, " � ����� ", lot, ". ��� ������� ", type);
            }
         }
      }
      //���� ������� ���
      if (GOinfo.PositionType() == POSITION_TYPE_BUY)
      {
         if (StringToDouble (DoubleToString ((SymbolInfoDouble(para, SYMBOL_ASK) - pricepara / qpara), 5)) * 100000 >= DD + addDD)
         {
                  ResetLastError();
                  double ask = SymbolInfoDouble (para, SYMBOL_ASK);
                  bool b = GO.Buy(LotBalance (para, Lot), para);
                  if (b == false || GetLastError() != 0)
                  {
                     Print ("����� ������ ������ ", GetLastError(), ". ������ ��������� ������� ", GO.ResultRetcode());
                     return;
                  }
                  pricepara = pricepara + ask;
                  qpara++;
                  
                  //����������� ������� ������� �� ��������� �������
                  if (TypeDD == false)
                  {
                     if (qpara >= 3 && qpara < 10)
                     {
                        addDD = DD2;
                     }
                     else
                     {
                        if (qpara >= 10)
                        addDD = DD2 + DD3;
                     }
                  }
                  else
                  {
                     addDD = addDD + DD;
                  }
   
                  Print("������� �� ", para, ". ����� ����� ", qpara, ". �������� ������� ����� ", addDD);      
         }
      }
      //���� ������� ���
      else
      {
         if (StringToDouble (DoubleToString ((pricepara / qpara - SymbolInfoDouble(para, SYMBOL_BID)), 5)) * 100000 >= DD + addDD)
         {
                  ResetLastError();
                  double bid = SymbolInfoDouble (para, SYMBOL_BID);
                  bool b = GO.Sell(LotBalance (para, Lot), para);
                  if (b == false || GetLastError() != 0)
                  {
                     Print ("����� ������ ������ ", GetLastError(), ". ������ ��������� ������� ", GO.ResultRetcode());
                     return;
                  }
                  pricepara = pricepara + bid;
                  qpara++;
                  
                  //����������� ������� ������� �� ��������� �������
                  if (TypeDD == false)
                  {
                     if (qpara >= 3 && qpara < 10)
                     {
                        addDD = DD2;
                     }
                     else
                     {
                        if (qpara >= 10)
                           addDD = DD2 + DD3;
                     }
                  }
                  else
                  {
                     addDD = addDD + DD;
                  }
                  
                  Print("������� �� ", para, ". ����� ����� ", qpara, ". �������� ������� ����� ", addDD);
         }
      }
   }
}


//������� ��� �������� ������ �������------------------------------------------------------
void OpenPosition (string para, ENUM_POSITION_TYPE type, double &pricepara, int &qpara)
{
   //��������� ���
   if (type == POSITION_TYPE_BUY)
   {
         pricepara = SymbolInfoDouble (para, SYMBOL_ASK);
         ResetLastError();
         bool a = GO.Buy (LotBalance (para, Lot), para);
         if (a == false || GetLastError() != 0)
         {
            Print ("����� ������ ������ ", GetLastError(), ". ������ ��������� ������� ", GO.ResultRetcode());
            return;
         }
         Print("������� ������� ", para);
         qpara = 1;
   }
   //��������� ���
   else
   {
         pricepara = SymbolInfoDouble (para, SYMBOL_BID);
         ResetLastError();
         bool a = GO.Sell (LotBalance (para, Lot), para);
         if (a == false || GetLastError() != 0)
         {
            Print ("����� ������ ������ ", GetLastError(), ". ������ ��������� ������� ", GO.ResultRetcode());
            return;
         }
         Print("������� ������� ", para);
         qpara = 1;
   }
}    


//������� ��������������� ��������� ������ �������� ���-----------------------------------------------------
double LotBalance (string para, double InputLot)
{
   double PipPrice = 10 * InputLot;    //��������� ������ ������ ��� ����������� ���� �� ������� ���������� ������������� � �������� ���� xxxUSD
   double llot = 0; 
   double pips = 0;
   //���� � �������� ���������� xxxUSD
   if (SymbolInfoString (para, SYMBOL_CURRENCY_PROFIT) == "USD")
   {
      llot = InputLot;
   }
   //���� � ������ ���������� USDxxx
   else
   {
      if (SymbolInfoString (para, SYMBOL_CURRENCY_BASE) == "USD")
      {
         for (double l = 0.01; true; l = l + 0.01)
         {
            pips = SymbolInfoDouble (para, SYMBOL_TRADE_CONTRACT_SIZE)  *  SymbolInfoDouble (para, SYMBOL_TRADE_TICK_SIZE)  /  SymbolInfoDouble (para, SYMBOL_BID)  *  l  *  10;    //��������� �� 10 ���� ���� ��������
            if (pips > PipPrice)
               break;
            llot = l;
         }
      }
      //���� ����� ���� 
      else
      {
         double sym = SymbolInfoDouble (SymbolInfoString (para, SYMBOL_CURRENCY_BASE) + "USD.m", SYMBOL_BID);
         if (sym == 0)
            sym = SymbolInfoDouble ("USD" + SymbolInfoString (para, SYMBOL_CURRENCY_BASE) + ".m", SYMBOL_BID);
         
         for (double l = 0.01; true; l = l + 0.01)
         {
            pips = SymbolInfoDouble (para, SYMBOL_TRADE_CONTRACT_SIZE)  *  SymbolInfoDouble (para, SYMBOL_TRADE_TICK_SIZE)  *  sym  /  SymbolInfoDouble (para, SYMBOL_BID)  *  l  *  10;    //��������� �� 10 ���� ���� ��������
            if (pips > PipPrice)
               break;
            llot = l;
         }
      }
   }
   return (StringToDouble(DoubleToString (llot, 2)));
}