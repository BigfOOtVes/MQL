
//Stach 5,3,3
double Stoch[4], Stochsignal[4];   //�������� ���������� �� ��������� 4 �����
extern int Kperiod = 5;
extern int Dperiod = 3;
extern int slow = 3;
extern int Stochmax = 85;          //������� �� ������� ����� ��������� ������ �� ���
extern int Stochmin = 15;          //������� �� ������� ����� ��������� ������ �� ���
bool Stochbuy = false;             //������ �� ������� 
bool Stochsell = false;            //������ �� �������


void Stochf ()
   {
    //������ �������� ���������� �� ��������� 4 �����
    for (int b = 0; b < 4; b++)
      {
       Stoch[b] = iStochastic (Symbol (), 0, Kperiod, Dperiod, slow, MODE_SMA, PRICE_CLOSE, MODE_MAIN, b);
       Stochsignal[b] = iStochastic (Symbol (), 0, Kperiod, Dperiod, slow, MODE_SMA, PRICE_CLOSE, MODE_SIGNAL, b);
      }
    //��������� ������� �� ���
    if (Stoch[3] < Stochsignal[3] && Stoch[1] > Stochsignal[1] && Stoch[3] < Stochmin)
      Stochbuy = true;
    else Stochbuy = false;
    //��������� ������� �� ���
    if (Stoch[3] > Stochsignal[3] && Stoch[1] < Stochsignal[1] && Stoch[3] > Stochmax)
      Stochsell = true;
    else Stochsell = false;
   }