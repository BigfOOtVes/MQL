
//SMA 26 and EMA 13
double SMA[4], EMA[4];  //�������� ���������� �� ��������� 4 �����
extern int SMAm = 26;   //�������� ��������� ���������� 
extern int EMAb = 13;   //�������� ������� ����������
bool MAbuy = false;     //������ �� ������� 
bool MAsell = false;    //������ �� �������



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