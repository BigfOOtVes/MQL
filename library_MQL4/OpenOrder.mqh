/*
������� �������� ����� ����� � ����������� �� ������������ ���������� � ���������� ����� ������
������������ ���������:
symb - �������� �����������
lot - ���
stoploss - ������ ��������� � �������
takeprofit - ������� ����������� � �������
type - ��� ������������ ������
       openprice - ������� ���� ����������� ����������� ������ (������ ��� ���������� �������, ��� ��������
       ������� ����� ��������� 0)
*/


int OpenOrder (string symb, double lot, int stoploss, int takeprofit, int type, double openprice)
   {
    string Symb = symb;            //�������� �����������
    double Lot = lot;              //���
    int SL = stoploss;             //��������
    int TP = takeprofit;           //����������
    int Type = type;               //��� ������������ ������
    double OpenPrice = NormalizeDouble(openprice, Digits);  //���� ��������� ����������� ������
    int Tiket;                     //������������ ����� ������ ��������� ������
    double take, stop;
    
    //��������� ����� ���
    if (Type == OP_BUY)
      {
       take = NormalizeDouble (Ask + TP * Point, Digits);
       stop = NormalizeDouble (Ask - SL * Point, Digits);
       Tiket = OrderSend (Symb, Type, Lot, NormalizeDouble (Ask,Digits), 3, stop, take);
       if (Tiket == -1)
         {
          Print ("����� ������ ������ ", GetLastError());
          Comment ("����� ������ ������ ", GetLastError());
          Tiket = 0;
         }
      }
      
   //��������� ����� ���
   if (Type == OP_SELL)
      {
       take = NormalizeDouble (Bid - TP * Point, Digits);
       stop = NormalizeDouble (Bid + SL * Point, Digits);
       Tiket = OrderSend (Symb, Type, Lot, NormalizeDouble (Bid, Digits), 3, stop, take);
       if (Tiket == -1)
         {
          Print ("����� ������ ������ ", GetLastError());
          Comment ("����� ������ ������ ", GetLastError());
          Tiket = 0;
         }
      }      

   //��������� ���������� ����� �������
   if (Type == OP_BUYSTOP)
      {
       take = NormalizeDouble (OpenPrice + TP * Point, Digits);
       stop = NormalizeDouble (OpenPrice - SL * Point, Digits);
       Tiket = OrderSend (Symb, Type, Lot, OpenPrice, 3, stop, take);
       if (Tiket == -1)
           {
            Print ("����� ������ ������ ", GetLastError());
            Comment ("����� ������ ������ ", GetLastError());
            Tiket = 0;
           }
      }
   
   //��������� ���������� ����� �������
   if (Type == OP_SELLSTOP)
      {
       take = NormalizeDouble (OpenPrice - TP * Point, Digits);
       stop = NormalizeDouble (OpenPrice + SL * Point, Digits);
       Tiket = OrderSend (Symb, Type, Lot, OpenPrice, 3, stop, take);
       if (Tiket == -1)
           {
            Print ("����� ������ ������ ", GetLastError());
            Comment ("����� ������ ������ ", GetLastError());
            Tiket = 0;
           }
      }
   
   //�������� ���������� ����� ��������
   if (Type == OP_BUYLIMIT)
      {
       take = NormalizeDouble (OpenPrice + TP * Point, Digits);
       stop = NormalizeDouble (OpenPrice - SL * Point, Digits);
       Tiket = OrderSend (Symb, Type, Lot, OpenPrice, 3, stop, take);
       if (Tiket == -1)
           {
            Print ("����� ������ ������ ", GetLastError());
            Comment ("����� ������ ������ ", GetLastError());
            Tiket = 0;
           }
      }
   
   //�������� ���������� ����� ��������
   if (Type == OP_SELLLIMIT)
      {
       take = NormalizeDouble (OpenPrice - TP * Point, Digits);
       stop = NormalizeDouble (OpenPrice + SL * Point, Digits);
       Tiket = OrderSend (Symb, Type, Lot, OpenPrice, 3, stop, take);
       if (Tiket == -1)
           {
            Print ("����� ������ ������ ", GetLastError());
            Comment ("����� ������ ������ ", GetLastError());
            Tiket = 0;
           }
      }
   
   return (Tiket);
   }
   