//+------------------------------------------------------------------+
//|                                                       Ves_MA.mq5 |
//|                                                          BigfOOt |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "BigfOOt"
#property link      "http://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

input int TP = 30;
input int SL = 15;
input double Lot = 0.1;

input int BistSred = 20;    //���������� ������� �������
input int MedlSred = 40;    //���������� ��������� �������

int HendlBistSred;          //����� ������� �������
int HendMedlSred;           //����� ��������� �������
double BistMA[], MedlMA[];  //������� ��� �������� ������ �������

MqlTradeRequest   TorgPrikaz = {0};   //��������� ������ ��� �������� �������� ��������        
MqlTradeResult    TorgRezult = {0};   //��������� ������ � ����������� ���������� ��������� �������

int OnInit()
  {
   //����������� ������ ����������� ����������
   HendlBistSred = iMA (_Symbol, _Period, BistSred, 0, MODE_SMA, PRICE_CLOSE);
   HendMedlSred = iMA (_Symbol, _Period, MedlSred, 0, MODE_SMA, PRICE_CLOSE);
   return(0);
  }

void OnDeinit(const int reason)
  {
   //����������� ������ �����������
   IndicatorRelease (HendlBistSred);
   IndicatorRelease (HendMedlSred);
  }


void OnTick()
  {
  
//+----------------------------------------------------------------------------------+
//| ���� ������ �� �����������                                                       |                         
//|----------------------------------------------------------------------------------+                                                         
//|������ ����� ������ � ������� � ������� �� ������ ���������� ��� ������ �� ���� ��� MQL4
   ArraySetAsSeries(BistMA,true);
   ArraySetAsSeries(MedlMA,true);
   
   //����������� ������ ������������� ������ � ������� ����� �����
   CopyBuffer (HendlBistSred, 0, 0, 5, BistMA);
   CopyBuffer (HendMedlSred, 0, 0, 5, MedlMA);                                           
//----------------------------------------------------------------------------------
   
   //��������� ���������� �������� ������� �� �������� ����
   if (PositionSelect (_Symbol) == true) //���� ������ �����
      {
       //��������� ��� ������
       if (PositionGetInteger (POSITION_TYPE) == POSITION_TYPE_BUY)  //���� ������ ����� ���
         {
          //��������� ���� �� ������ �� ���������� �� �������
          if (BistMA[1] < MedlMA[1] && BistMA[3] > MedlMA[3])  //���� ������
            {
             //��������� ����� ��� � ��������� ����� �� �������
             TorgPrikaz.action = TRADE_ACTION_DEAL;
             TorgPrikaz.magic  = 102;
             TorgPrikaz.symbol = _Symbol;
             TorgPrikaz.volume = Lot * 2;
             TorgPrikaz.price  = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_BID), _Digits);
             TorgPrikaz.sl     = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_BID) + SL * SymbolInfoDouble (Symbol (), SYMBOL_POINT), _Digits);
             TorgPrikaz.tp     = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_BID) - TP * SymbolInfoDouble (Symbol (), SYMBOL_POINT), _Digits);
             TorgPrikaz.deviation = 2;
             TorgPrikaz.type   = ORDER_TYPE_SELL;
             TorgPrikaz.type_filling = ORDER_FILLING_FOK; 
             
             ResetLastError ();                 //�������� ��������� ������
             OrderSend(TorgPrikaz, TorgRezult); //��������� �����
             
             if (GetLastError () != 0)  //���� ����� ����� ������
               {
                Print ("������ = ", GetLastError ());
                Print ("��� ��������� ������� = ", TorgRezult.retcode);
               }
             return;  //�������
            }
          else       //��� �������
            return;  //�������
         }
       else    //���� ������ ����� ���
         {
          //��������� ���� �� ������ �� ���������� �� �������
          if (BistMA[1] > MedlMA[1] && BistMA[3] < MedlMA[3])  //���� ������
            {
             //��������� ����� �� ������� � ��������� ����� �� �������
             TorgPrikaz.action = TRADE_ACTION_DEAL;
             TorgPrikaz.magic  = 102;
             TorgPrikaz.symbol = _Symbol;
             TorgPrikaz.volume = Lot * 2;
             TorgPrikaz.price  = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_ASK), _Digits);
             TorgPrikaz.sl     = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_ASK) - SL * SymbolInfoDouble (Symbol (), SYMBOL_POINT), _Digits);
             TorgPrikaz.tp     = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_ASK) + TP * SymbolInfoDouble (Symbol (), SYMBOL_POINT), _Digits);
             TorgPrikaz.deviation = 2;
             TorgPrikaz.type   = ORDER_TYPE_BUY;
             TorgPrikaz.type_filling = ORDER_FILLING_FOK; 
             
             ResetLastError ();                 //�������� ��������� ������
             OrderSend(TorgPrikaz, TorgRezult); //��������� �����
             
             if (GetLastError () != 0)  //���� ����� ����� ������
               {
                Print ("������ = ", GetLastError ());
                Print ("��� ��������� ������� = ", TorgRezult.retcode);
               }
             return;  //�������
            }
          else      //��� �������
            return; //�������
         }
      }
   else    //��� �������� ������� �� �������� ����
      {
       //��������� ���� �� ������ �� ���������� �� ���
       if (BistMA[1] > MedlMA[1] && BistMA[3] < MedlMA[3])  //���� ������
         {
          //��������� ����� ���
          TorgPrikaz.action = TRADE_ACTION_DEAL;
          TorgPrikaz.magic  = 102;
          TorgPrikaz.symbol = _Symbol;
          TorgPrikaz.volume = Lot;
          TorgPrikaz.price  = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_ASK), _Digits);
          TorgPrikaz.sl     = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_ASK) - SL * SymbolInfoDouble (Symbol (), SYMBOL_POINT), _Digits);
          TorgPrikaz.tp     = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_ASK) + TP * SymbolInfoDouble (Symbol (), SYMBOL_POINT), _Digits);
          TorgPrikaz.deviation = 2;
          TorgPrikaz.type   = ORDER_TYPE_BUY;
          TorgPrikaz.type_filling = ORDER_FILLING_FOK; 
             
          ResetLastError ();                 //�������� ��������� ������
          OrderSend(TorgPrikaz, TorgRezult); //��������� �����
             
          if (GetLastError () != 0)  //���� ����� ����� ������
             {
              Print ("������ = ", GetLastError ());
              Print ("��� ��������� ������� = ", TorgRezult.retcode);
             }
          return;  //�������
         }
       else    //��� �������
         {
          //��������� ���� �� ������ �� ���������� �� ���
          if (BistMA[1] < MedlMA[1] && BistMA[3] > MedlMA[3])  //���� ������
            {
             //��������� ����� ���
             TorgPrikaz.action = TRADE_ACTION_DEAL;
             TorgPrikaz.magic  = 102;
             TorgPrikaz.symbol = _Symbol;
             TorgPrikaz.volume = Lot;
             TorgPrikaz.price  = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_BID), _Digits);
             TorgPrikaz.sl     = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_BID) + SL * SymbolInfoDouble (Symbol (), SYMBOL_POINT), _Digits);
             TorgPrikaz.tp     = NormalizeDouble (SymbolInfoDouble (Symbol (), SYMBOL_BID) - TP * SymbolInfoDouble (Symbol (), SYMBOL_POINT), _Digits);
             TorgPrikaz.deviation = 2;
             TorgPrikaz.type   = ORDER_TYPE_SELL;
             TorgPrikaz.type_filling = ORDER_FILLING_FOK; 
             
             ResetLastError ();                 //�������� ��������� ������
             OrderSend(TorgPrikaz, TorgRezult); //��������� �����
             
             if (GetLastError () != 0)  //���� ����� ����� ������
               {
                Print ("������ = ", GetLastError ());
                Print ("��� ��������� ������� = ", TorgRezult.retcode);
               }
             return;  //�������
            }
          else        //��� �������
            return;   //�������
         }
      }
   
  }   
