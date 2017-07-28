//+------------------------------------------------------------------+
//|                                                      ObemVes.mq4 |
//|                                                              Ves |
//|                                                                  |
//+------------------------------------------------------------------+

/*
��������� ���������� ���������� ������� ����������� �� ���. ����
���� ���� ����������, �� ���������� ������� ����������� �� ��� ����������
�������� (������� ���), ���� ���� ���� ����������, �� ���������� ������� 
����������� �� ��� ���������� �������� (������� ���).
��������� �������� �������� ����� �������� ��������� ��� ����� �������������
��� � �������.
��������� �������� ������ � ���� ���� �� ������� ��� ����������.
*/
#property copyright "Ves"
#property link      ""

#property indicator_separate_window   //��������� � ��������� ����
//#property indicator_minimum -50      //������� ������ ������������� ����
//#property indicator_maximum 50       //�������� ������ ������������� ����
#property  indicator_buffers 2        //���������� ������� � ����������
#property  indicator_color1  Green    //���� ������� ������ ����������
#property  indicator_color2  Red      //���� ������� ������ ����������
#property  indicator_width1  2        //������������� ������� �����
#property  indicator_width2  2        //������������� ������� �����

double inGreen[];      //��������� ������ ��� ������� ������
double inRed[];        //��������� ������ ��� ������� ������

double val = 0.0;      //��������� ���� ����� ��� � ������������� ���� ��� ������������
int StartBar = 0;      //��� � �������� �������� �������
int BariNaGrafike;     //������� �����

bool Zapusk = false;   //������� �������
double ObemControl;    //�������� �������
double LP;             //��������� ������� ��������� ������ ����������� �� ���
double LM;             //��������� ������� ���������� ������ ���������� �� ���
int noviyBar;          //������� ��������� ������� ���� ��� ������ ����������
double LotPlus[10000000];      //������ ������ �������� ����
double LotMinus[10000000];     //������ ������ ��������� ����
double LotPlusP;
double LotMinusP;
double BBid;

int init()
  {
   //IndicatorBuffers(4);
   SetIndexBuffer(0,inGreen);           //����������� ������ � 1 ������ ����������
   SetIndexBuffer(1,inRed);             //����������� ������ � 2 ������ ����������
   //SetIndexBuffer(2,LotPlus);           //������ ������ ��� ��������
   //SetIndexBuffer(3,LotMinus);          //������ ������ ��� ��������
   SetIndexStyle(0,DRAW_HISTOGRAM);     //���������� 1 ����� ��� �����������
   SetIndexStyle(1,DRAW_HISTOGRAM);     //���������� 2 ����� ��� �����������
   noviyBar = Bars;                     //�������� ���� ��� ������ ������
   return(0);
  }
  
  
int start()
  {
   BBid = Bid;    //����������� ���� ���. ��� ������������ ���� ���������� ����������� ���.
   
   if (noviyBar == Bars)   //���� ������ ���� � ��������
      return;
   else{
       
       //����������� ������ �������� ��������� ��� �������
   if (Zapusk == false)
      {  
       BariNaGrafike = Bars;                //������ ����� ���������� ����� �� �������
       Zapusk = true;
       ObemControl = iVolume(Symbol(),0,0); //������ ��������� �����
       val = BBid;                           //������ ��������� ���� ��� 
      }
   
       //���� �������� ����� ���
   if (BariNaGrafike != Bars)      
      {
       StartBar ++; BariNaGrafike = Bars; 
       ObemControl = iVolume(Symbol(),0,0);
       LotPlus[StartBar] = 0;
       LotMinus[StartBar] = 0;
       LotPlusP = 0;
       LotMinusP = 0;
      }   

       //��������� ������
   if (BBid >= val)    //���� ��� �������������
      {
       LP = iVolume(Symbol(),0,0) - ObemControl;
       LotPlusP = LotPlusP + LP;
       LotPlus[StartBar] = LotPlusP;
       ObemControl = iVolume(Symbol(),0,0);
       val = BBid;
      }
   else              //���� ��� �������������
      {
       LM = iVolume(Symbol(),0,0) - ObemControl;
       LotMinusP = LotMinusP - LM;
       LotMinus[StartBar] = LotMinusP;
       ObemControl = iVolume(Symbol(),0,0);
       val = BBid;
      }
  
        //�������� ������ � ������ ����������
   int i2 = 0;
   for (int i = StartBar; i >= 0 && i2 <= StartBar; i--)
      {inGreen[i] = LotPlus[i2]; i2++;}
   
   int e2 = 0;
   for (int e = StartBar; e >= 0 && e2 <= StartBar; e--)
      {inRed[e] = LotMinus[e2]; e2++;}
   
   Comment ("\n ���������� ������������ ����� = ",StartBar);
  }
   return(0);
  }


