/*
�������� �������� �� 3 �����������:
1 - ��� ���������� �������
2 - ����
3 - ���������
������ ��� ����� ������������ � ���� � ��������� ��������� � ���� ���������� ������ 
��������� ����� � ����������� �� �����������
��� ������ ��������� ��������� ���������� #include <OpenOrder.mqh>
*/

#property copyright "Ves"
#property link      ""
#include <OpenOrder.mqh>
#include <DelOrdersAll.mqh>
#include <OrderClos.mqh>

extern int TP = 20;       //���� ������ 
extern int SL = 10;       //��������
extern double Lot = 0.1;  //���

//SMA 26 and EMA 13
double SMA[4], EMA[4];  //�������� ���������� �� ��������� 4 �����
extern int SMAm = 26;   //�������� ��������� ���������� 
extern int EMAb = 13;   //�������� ������� ����������
bool MAbuy = false;     //������ �� ������� 
bool MAsell = false;    //������ �� �������

//MACD 12,26,9
double MACDmin, MACDmax;           //������ �� ���������� �� �������� ����� ��������� ������
double MACDur[170];                //������ ��� ������� �������
double MACD[4], MACDsignal[4];     //�������� ���������� �� ��������� 4 �����
extern int fastEMA = 12;           //�������� ������� ����������
extern int slowEMA = 26;           //�������� ���������� ����������
extern int signalEMA = 9;          //�������� ���������� �����
bool MACDbuy = false;              //������ �� ������� 
bool MACDsell = false;             //������ �� �������
extern int k = 70;                 //������� ����/���� �������� ����� ��������� ������ �� �������
                                   //� ���������� �����������
//Stach 5,3,3
double Stoch[4], Stochsignal[4];   //�������� ���������� �� ��������� 4 �����
extern int Kperiod = 5;
extern int Dperiod = 3;
extern int slow = 3;
extern int Stochmax = 85;          //������� �� ������� ����� ��������� ������ �� ���
extern int Stochmin = 15;          //������� �� ������� ����� ��������� ������ �� ���
bool Stochbuy = false;             //������ �� ������� 
bool Stochsell = false;            //������ �� �������

int buy, sell;  //������

int start()
  {
   SMAf ();
   MACDf ();
   Stochf ();
   //���� ����� �������� �� ����� �� �������� �����
   if (OrderSelect (buy, SELECT_BY_TICKET) == true)
      if (OrderCloseTime () > 0)
         buy = 0;
   if (OrderSelect (sell, SELECT_BY_TICKET) == true)
      if (OrderCloseTime () > 0)
         sell = 0;
   
   //��������� ����� ��� �������
   if (MACDbuy == true && Stochbuy == true && MAbuy == true && buy == 0)
      buy = OpenOrder (Symbol (), Lot, SL, TP, OP_BUY, 0);
      
   if (MACDsell == true && Stochsell == true && MAsell == true && sell == 0)
      sell = OpenOrder (Symbol (), Lot, SL, TP, OP_SELL, 0);
      
      
   return(0);
  }



void SMAf ()
   {
    //����������� �������� ������������ ������
    for (int i = 0; i < 4; i++)
      {
       SMA[i] = iMA (Symbol (), 0, SMAm, 0, MODE_SMA, PRICE_CLOSE, i);
       EMA[i] = iMA (Symbol (), 0, EMAb, 0, MODE_EMA, PRICE_CLOSE, i);
      }
    //��������� ������� �� ���
    if (SMA[3] > EMA[3] && SMA[1] <  EMA[1])
      MAbuy = true;
    else MAbuy = false;
    //��������� ������� �� ���
    if (SMA[3] < EMA[3] && SMA[1] > EMA[1])
      MAsell = true;
    else MAsell = false;
   }
   
void MACDf ()
   {
    for (int a = 0; a < 4; a++)
      {
       //����������� ���� ���������� �� ��������� 4 �����
       MACD[a] = iMACD (Symbol (), 0, fastEMA, slowEMA, signalEMA, PRICE_CLOSE, MODE_MAIN, a);
       MACDsignal[a] = iMACD (Symbol (), 0, fastEMA, slowEMA, signalEMA, PRICE_CLOSE, MODE_SIGNAL, a);
      }
    //���������� ������� �� ���
    if (MACD[1] > MACDsignal[1] && MACDsignal[1] < 0)
      MACDbuy = true;
    else MACDbuy = false;
    //��������� ������� �� ���
    if (MACD[1] < MACDsignal[1] && MACDsignal[1] > 0)
      MACDsell = true;
    else MACDsell = false;
   }
   
void Stochf ()
   {
    //������ �������� ���������� �� ��������� 4 �����
    for (int b = 0; b < 4; b++)
      {
       Stoch[b] = iStochastic (Symbol (), 0, Kperiod, Dperiod, slow, MODE_SMA, PRICE_CLOSE, MODE_MAIN, b);
       Stochsignal[b] = iStochastic (Symbol (), 0, Kperiod, Dperiod, slow, MODE_SMA, PRICE_CLOSE, MODE_SIGNAL, b);
      }
    //��������� ������� �� ���
    if (Stoch[1] > Stochsignal[1] && Stochsignal[1] < 0)
      Stochbuy = true;
    else Stochbuy = false;
    //��������� ������� �� ���
    if (Stoch[1] < Stochsignal[1] && Stochsignal[1] > 0)
      Stochsell = true;
    else Stochsell = false;
   }

