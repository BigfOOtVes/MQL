//+------------------------------------------------------------------+
//|                                                    Ves_2line.mq5 |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window

//�������� ��������� � ��������� ����
#property indicator_separate_window
//���������� ������� ��� ����������
#property indicator_buffers 2
//���������� �������� ��� ��� ������
#property indicator_plots   2
//������ ���������� � ���� ������� �����
#property indicator_type1   DRAW_LINE
#property indicator_type2   DRAW_LINE
//����� ������������ �����
#property indicator_color1  Red
#property indicator_color2  Green
//������� �����
#property indicator_width1 2
#property indicator_width2 2


input string para1 = "EURUSD.m"; //������ ����
input string para2 = "GBPUSD.m"; //������ ����
input int kolBarov = 3000;       //����� �������
input bool revPara1 = false;     //����������� ������ ����
input bool revPara2 = false;     //����������� ������ ����

input int fast_ema_period = 12;  // ������ ������� �������
input int slow_ema_period = 26;  // ������ ��������� �������
input int signal_period = 9;     // ������ ���������� ��������
input ENUM_APPLIED_PRICE metod = PRICE_CLOSE;   //������� �� ����� �����

double bufer1[], bufer2[];         //������� ��� ������
double macdPara1[], macdPara2[];   //������� ��� �������� �������� ���������� MACD
int handlMacd1, handlMacd2;        //������ ����������� MACD ��� ��������
int reversPara1, reversPara2;      //��� ���������� ����


int OnInit()
{
   //����������� ������� � ������� ����������
   SetIndexBuffer(0, bufer1, INDICATOR_DATA);
   SetIndexBuffer(1, bufer2, INDICATOR_DATA);
   
   //����������� ������ ����������� � ����������
   handlMacd1 = iMACD (para1, Period(), fast_ema_period, slow_ema_period, signal_period, metod);
   handlMacd2 = iMACD (para2, Period(), fast_ema_period, slow_ema_period, signal_period, metod);
   
   //������ ������ ���������� � �������� � ����� �� ����
   ArraySetAsSeries(bufer1,true);
   ArraySetAsSeries(bufer2,true);
   ArraySetAsSeries(macdPara1,true);
   ArraySetAsSeries(macdPara2,true);
   
   //�������� ����� ����������
   PlotIndexSetString (0, PLOT_LABEL, SymbolInfoString(para1, SYMBOL_CURRENCY_BASE) + SymbolInfoString(para1, SYMBOL_CURRENCY_PROFIT));
   PlotIndexSetString (1, PLOT_LABEL, SymbolInfoString(para2, SYMBOL_CURRENCY_BASE) + SymbolInfoString(para2, SYMBOL_CURRENCY_PROFIT));

   return(0);
}



int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   //����������� �������� ���������� MACD � �������� ����� �����
   CopyBuffer (handlMacd1, 0, 0, kolBarov, macdPara1);
   CopyBuffer (handlMacd2, 0, 0, kolBarov, macdPara2);
   
   //�������������� ���� ���� ������� ��������
   if (revPara1 == true)
      reversPara1 = -1;
   else
      reversPara1 = 1;
   
   if (revPara2 == true)
      reversPara2 = -1;
   else
      reversPara2 = 1;
   
   //������ �������� �������
   for (int a = kolBarov - 1; a != -1; a --)
   {
      bufer1[a] = macdPara1[a] * reversPara1;
      bufer2[a] = macdPara2[a] * reversPara2;
   }
   return(rates_total);
}
