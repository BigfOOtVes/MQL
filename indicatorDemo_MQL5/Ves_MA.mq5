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
#property indicator_buffers 3
//���������� �������� ��� ��� ������
#property indicator_plots   3
//������ ���������� � ���� ������� �����
#property indicator_type1   DRAW_LINE
#property indicator_type2   DRAW_LINE
#property indicator_type3   DRAW_LINE
//����� ������������ �����
#property indicator_color1  Red
#property indicator_color2  Green
#property indicator_color3  Blue
//������� �����
#property indicator_width1 2
#property indicator_width2 2
#property indicator_width3 2



//������� ��������� ����������
input int Usrednenie  = 15;         //���������� ��� ���
input string Instr1 =  "EURUSD";    //������ ����
input string Instr2 =  "GBPUSD";    //������ ����
input string Instr3 =  "AUDUSD";    //������ ����
input int KolBarov = 1000;          //���������� �������������� �����

int MA1, MA2, MA3;   //��� �������� ������� ���������� �������

//���������� ���� �������� ��� ������������ �������
double Para1[], Para2[], Para3[];
//������� ��� �������� ������ �� ���������� �������
double ParaMA1[], ParaMA2[], ParaMA3[];
//������� ��� �������� ��� ��������
double ClosePara1[], ClosePara2[], ClosePara3[];


//---------------------------------------------------------
int OnInit()
  {
   //����������� ������ ���������� ������� ����������
   MA1 = iMA (Instr1, _Period, Usrednenie, 0, MODE_SMA, PRICE_CLOSE);
   MA2 = iMA (Instr2, _Period, Usrednenie, 0, MODE_SMA, PRICE_CLOSE);
   MA3 = iMA (Instr3, _Period, Usrednenie, 0, MODE_SMA, PRICE_CLOSE);
   //����������� ������� � ������� ����������
   SetIndexBuffer(0, Para1, INDICATOR_DATA);
   SetIndexBuffer(1, Para2, INDICATOR_DATA);
   SetIndexBuffer(2, Para3, INDICATOR_DATA);
   //������ ������ ���������� � �������� � ����� �� ����
   ArraySetAsSeries(Para1,true);
   ArraySetAsSeries(Para2,true);
   ArraySetAsSeries(Para3,true);
   ArraySetAsSeries(ParaMA1,true);
   ArraySetAsSeries(ParaMA2,true);
   ArraySetAsSeries(ParaMA3,true);
   ArraySetAsSeries(ClosePara1,true);
   ArraySetAsSeries(ClosePara2,true);
   ArraySetAsSeries(ClosePara3,true);
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
   CopyClose (Instr1, _Period, 0, KolBarov, ClosePara1);
   CopyClose (Instr2, _Period, 0, KolBarov, ClosePara2);
   CopyClose (Instr3, _Period, 0, KolBarov, ClosePara3);
   //����������� ������ ������������� ������ ���������� ������� � �������� ����� �����
   CopyBuffer (MA1, 0, 0, KolBarov, ParaMA1);
   CopyBuffer (MA2, 0, 0, KolBarov, ParaMA2); 
   CopyBuffer (MA3, 0, 0, KolBarov, ParaMA3);
   //��������� �������� ��� ������������ �������
   for (int a = 0; a < KolBarov; a++)
      {
       Para1[a] = ClosePara1[a] - ParaMA1[a];
       Para2[a] = ClosePara2[a] - ParaMA2[a];
       Para3[a] = ClosePara3[a] - ParaMA3[a];
      }
      
   return(rates_total);
  }



//---------------------------------------------------------
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
   
  }
