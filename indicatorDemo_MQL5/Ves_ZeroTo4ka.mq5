//+------------------------------------------------------------------+
//|                                                Ves_ZeroTo4ka.mq5 |
//|                                                              Ves |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Ves"
#property link      "http://www.mql5.com"
#property version   "1.00"

//� ��������� ����
#property indicator_separate_window
//���������� ������� ��� ����������
#property indicator_buffers 1
//���������� �������� ���� �����
#property indicator_plots   1
//������ ���������� � ���� ������� �����
#property indicator_type1   DRAW_LINE
//����� ������������ �����
#property indicator_color1  Red
//������� �����
#property indicator_width1 2


//������� ���������
input int Usrednenie = 10;   //�������� ����������
input int KolBarov = 1000;   //���������� ����� ��� �������


//��� �������� ������� ���������� �������
int x1;


//���������� ������� ��� ������
double Bufer[];
//������� ��� �������� ������
double PraceClose[], MA[];
   


int OnInit()
  {
   //����������� ������ ���������� ������� ����������
   x1 = iMA (Symbol(), _Period, Usrednenie, 0, MODE_SMA, PRICE_CLOSE);
   //����������� ������� � ������� ����������
   SetIndexBuffer(0, Bufer, INDICATOR_DATA);
   //������ ������ ���������� � �������� � ����� �� ����
   ArraySetAsSeries(Bufer,true);
   ArraySetAsSeries(PraceClose,true);
   ArraySetAsSeries(MA,true);
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
   //����������� ���� �������� ����� �������
   CopyClose (Symbol(), _Period, 0, KolBarov, PraceClose);
   
   //����������� ������ ���������� � ������� ����� �����
   CopyBuffer (x1, 0, 0, KolBarov, MA);
   
   //��������� �������� ��� ������������ �������
   for (int a = 0; a < KolBarov; a++)
      {
       Bufer[a] = PraceClose[a] - MA[a];
      }
   return(rates_total);
  }
//+------------------------------------------------------------------+
