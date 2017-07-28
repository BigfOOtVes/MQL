//+------------------------------------------------------------------+
//|                                                       Ves_MA.mq5 |
//|                                                          BigfOOt |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "BigfOOt"
#property link      "http://www.mql5.com"
#property version   "1.00"



//�������� ��������� � ��������� ����
#property indicator_separate_window
//���������� ������� ��� ����������
#property indicator_buffers 5
//���������� �������� ��� ��� ������
#property indicator_plots   5
//������ ���������� � ���� ������� �����
#property indicator_type1   DRAW_LINE
#property indicator_type2   DRAW_LINE
#property indicator_type3   DRAW_LINE
#property indicator_type4   DRAW_LINE
#property indicator_type5   DRAW_LINE
//����� ������������ �����
#property indicator_color1  Red
#property indicator_color2  Green
#property indicator_color3  Black
#property indicator_color4  DeepSkyBlue
#property indicator_color5  DarkOrchid
//������� �����
#property indicator_width1 2
#property indicator_width2 2
#property indicator_width3 3
#property indicator_width4 2
#property indicator_width5 2


//������� ��������� ����������
input string Instr1   = "EURUSD.m";   //������ ����
input bool type1      = false;        //��� ������ ������ ���� false - ���, true - ���
input double lot1     = 0.1;          //��� ��� ������ ����
input string Instr2   = "GBPUSD.m";   //������ ����
input bool type2      = true;         //��� ������ ������ ���� false - ���, true - ���
input double lot2     = 0.1;          //��� ��� ������ ����
input string Instr3   = "AUDUSD.m";   //������ ����
input bool type3      = true;         //��� ������ ������� ���� false - ���, true - ���
input double lot3     = 0.1;          //��� ��� ������ ����
input string Instr4   = "USDCHF.m";   //������ ����
input bool type4      = true;         //��� ������ ��������� ���� false - ���, true - ���
input double lot4     = 0.1;          //��� ��� ������ ����
input datetime StartTime = D'2012.01.01 00:00:00';   //����� ������ �������

//������ ��� ������
double Bufer1[];
double Bufer2[];
double Balance[];
double Bufer3[], Bufer4[];
//������� ��� �������� ������ �� ���������� �������
double ClosePara1[], ClosePara2[], ClosePara3[], ClosePara4[];
double StartPara1, StartPara2, StartPara3, StartPara4;


//---------------------------------------------------------
int OnInit()
  {/*
   //������� ����������� �������������� ������
   ObjectCreate(0, "inf1df2", OBJ_LABEL, ChartWindowFind(), 0, 0);
   ObjectSetString(0, "inf1df2", OBJPROP_TEXT, Instr1);
   ObjectSetInteger(0, "inf1df2", OBJPROP_COLOR, Red);
   ObjectSetInteger(0, "inf1df2", OBJPROP_XDISTANCE, 210);
   ObjectSetInteger(0, "inf1df2", OBJPROP_YDISTANCE, 1);
   
   ObjectCreate(0, "infdssf22", OBJ_LABEL, ChartWindowFind(), 0, 0);
   ObjectSetString(0, "infdssf22", OBJPROP_TEXT, Instr2);
   ObjectSetInteger(0, "infdssf22", OBJPROP_COLOR, Green);
   ObjectSetInteger(0, "infdssf22", OBJPROP_XDISTANCE, 310);
   ObjectSetInteger(0, "infdssf22", OBJPROP_YDISTANCE, 1);
   */
   
   //����������� ������� � ������� ����������
   SetIndexBuffer(0, Bufer1, INDICATOR_DATA);
   SetIndexBuffer(1, Bufer2, INDICATOR_DATA);
   SetIndexBuffer(2, Balance, INDICATOR_DATA);
   SetIndexBuffer(3, Bufer3, INDICATOR_DATA);
   SetIndexBuffer(4, Bufer4, INDICATOR_DATA);
   
   //������ ������ ���������� � �������� � ����� �� ����
   ArraySetAsSeries(Bufer1,true);
   ArraySetAsSeries(Bufer2,true);
   ArraySetAsSeries(Bufer3,true);
   ArraySetAsSeries(Bufer4,true);
   ArraySetAsSeries(Balance,true);
   ArraySetAsSeries(ClosePara1,true);
   ArraySetAsSeries(ClosePara2,true);
   ArraySetAsSeries(ClosePara3,true);
   ArraySetAsSeries(ClosePara4,true);
   
   //�������� ���������� � ����� ����������
   PlotIndexSetString (0, PLOT_LABEL, Instr1);
   PlotIndexSetString (1, PLOT_LABEL, Instr2);
   PlotIndexSetString (2, PLOT_LABEL, "Balance");
   PlotIndexSetString (3, PLOT_LABEL, Instr3);
   PlotIndexSetString (4, PLOT_LABEL, Instr4);
   
   return(0);
  }


//--------------------------------------------------------
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
   
   //����������� ���� �������� ��� ��������
   CopyOpen (Instr1, _Period, TimeCurrent(), StartTime, ClosePara1);
   CopyOpen (Instr2, _Period, TimeCurrent(), StartTime, ClosePara2);
   CopyOpen (Instr3, _Period, TimeCurrent(), StartTime, ClosePara3);
   CopyOpen (Instr4, _Period, TimeCurrent(), StartTime, ClosePara4);
   
   //��������� �������� ��� ������������ �������
   StartPara1 = ClosePara1[ArraySize(ClosePara1) - 1];
   StartPara2 = ClosePara2[ArraySize(ClosePara2) - 1];
   StartPara3 = ClosePara3[ArraySize(ClosePara3) - 1];
   StartPara4 = ClosePara4[ArraySize(ClosePara4) - 1];
   double PunktPara1 = 10 * lot1;
   double PunktPara2 = 10 * lot2; 
   double PunktPara3 = 10 * lot3;
   double PunktPara4 = 10 * lot4;
   
   for (int a = ArraySize(ClosePara1) - 1; a != -1; a--)
   {
      if (type1 == false)
         Bufer1[a] = StringToDouble(DoubleToString(ClosePara1[a] - StartPara1,Digits())) * 10000 * PunktPara1;
      else
         Bufer1[a] = StringToDouble(DoubleToString(StartPara1 - ClosePara1[a],Digits())) * 10000 * PunktPara1;
      
      if (type2 == false)
         Bufer2[a] = StringToDouble(DoubleToString(ClosePara2[a] - StartPara2,Digits())) * 10000 * PunktPara2;
      else
         Bufer2[a] = StringToDouble(DoubleToString(StartPara2 - ClosePara2[a],Digits())) * 10000 * PunktPara2;
         
      if (type3 == false)
         Bufer3[a] = StringToDouble(DoubleToString(ClosePara3[a] - StartPara3,Digits())) * 10000 * PunktPara3;
      else
         Bufer3[a] = StringToDouble(DoubleToString(StartPara3 - ClosePara3[a],Digits())) * 10000 * PunktPara3;
         
      if (type4 == false)
         Bufer4[a] = StringToDouble(DoubleToString(ClosePara4[a] - StartPara4,Digits())) * 10000 * PunktPara4;
      else
         Bufer4[a] = StringToDouble(DoubleToString(StartPara4 - ClosePara4[a],Digits())) * 10000 * PunktPara4;
               
         
      Balance[a] = Bufer1[a] + Bufer2[a] + Bufer3[a] + Bufer4[a];
   }

   return(rates_total);
  }
