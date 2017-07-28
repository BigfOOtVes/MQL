
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



void MACDf ()
   {
    for (int a = 0; a < 4; a++)
      {
       //����������� ���� ���������� �� ��������� 4 �����
       MACD[a] = iMACD (Symbol (), 0, fastEMA, slowEMA, signalEMA, PRICE_CLOSE, MODE_MAIN, a);
       MACDsignal[a] = iMACD (Symbol (), 0, fastEMA, slowEMA, signalEMA, PRICE_CLOSE, MODE_SIGNAL, a);
      }
    //������������ �������� ������� max and min
    
    MACDmin = 0; 
    MACDmax = 0;
    for (int x = 0; x <= 170; x++)
      {
       MACDur[x] = iMACD (Symbol (), 0, fastEMA, slowEMA, signalEMA, PRICE_CLOSE, MODE_MAIN, x);
       if (MACDur[x] > MACDmax)
         MACDmax = MACDur[x];
       if (MACDur[x] < MACDmin)
         MACDmin = MACDur[x];
      }
      MACDmax = MACDmax / 100 * k;
      MACDmin = MACDmin / 100 *k; 
    //���������� ������� �� ���
    if (MACD[3] < MACDsignal[3] && MACD[1] > MACDsignal[1] && MACD[3] < MACDmin)
      MACDbuy = true;
    else MACDbuy = false;
    //��������� ������� �� ���
    if (MACD[3] > MACDsignal[3] && MACD[1] < MACDsignal[1] && MACD[3] > MACDmax)
      MACDsell = true;
    else MACDsell = false;
   }