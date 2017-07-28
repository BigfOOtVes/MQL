/*
��������� ���������� 3 ���������� ������� ���� �������� ���. ������ ������� ��� 
����������� ���������� �� ���� ��������������� �������� ����.
*/
#property copyright "Ves Volk"
#property link      ""

#property indicator_separate_window
#property  indicator_buffers 3        

extern int ���������� = 100;
 
double �����GBPUSD [10000000];
double �����EURUSD [10000000];
double �����EURGBP [10000000];

double ����GBPUSD [10000000];
double ����EURUSD [10000000];
double ����EURGBP [10000000];

double ����GBPUSD���������� [10000000];
double ����EURUSD���������� [10000000];
double ����EURGBP���������� [10000000];

double GBPUSD������� [10000000];
double EURUSD������� [10000000];
double EURGBP������� [10000000];

int ��� = 0;

int tt;
int tt2;
double �����;
int tt3, i2, i;


int init()
  {
   SetIndexBuffer(0,�����GBPUSD);       
   SetIndexStyle(0,DRAW_LINE, EMPTY, 2, Green);
   SetIndexBuffer(1,�����EURUSD);       
   SetIndexStyle(1,DRAW_LINE, EMPTY, 2, Red);
   SetIndexBuffer(2,�����EURGBP);       
   SetIndexStyle(2,DRAW_LINE, EMPTY, 2, Blue); 
   return(0);
  }
  
  
int deinit ()
   {
    ObjectsDeleteAll ();
    return (0);
   }
  
  
int start()
  {
   if (ObjectFind ("GBPUSD") == -1)
      {
       ObjectCreate ("GBPUSD", OBJ_LABEL, 1, 0, 0);
       ObjectSet ("GBPUSD", OBJPROP_FONTSIZE, 10);
       ObjectSet ("GBPUSD", OBJPROP_COLOR, Green);
       ObjectSet ("GBPUSD", OBJPROP_XDISTANCE, 1340);
       ObjectSet ("GBPUSD", OBJPROP_YDISTANCE, 3);
       ObjectSetText ("GBPUSD", "GBPUSD");
      } 
    if (ObjectFind ("EURUSD") == -1)
      {
       ObjectCreate ("EURUSD", OBJ_LABEL, 1, 0, 0);
       ObjectSet ("EURUSD", OBJPROP_FONTSIZE, 10);
       ObjectSet ("EURUSD", OBJPROP_COLOR, Red);
       ObjectSet ("EURUSD", OBJPROP_XDISTANCE, 1405);
       ObjectSet ("EURUSD", OBJPROP_YDISTANCE, 3);
       ObjectSetText ("EURUSD", "EURUSD");
      } 
    if (ObjectFind ("EURGBP") == -1)
      {
       ObjectCreate ("EURGBP", OBJ_LABEL, 1, 0, 0);
       ObjectSet ("EURGBP", OBJPROP_FONTSIZE, 10);
       ObjectSet ("EURGBP", OBJPROP_COLOR, Blue);
       ObjectSet ("EURGBP", OBJPROP_XDISTANCE, 1470);
       ObjectSet ("EURGBP", OBJPROP_YDISTANCE, 3);
       ObjectSetText ("EURGBP", "EURGBP");
      } 
   
   
   //������� ��� �������� ���
   ����GBPUSD [���] = MarketInfo ("GBPUSD_m", MODE_BID);
   ����EURUSD [���] = MarketInfo ("EURUSD_m", MODE_BID);
   ����EURGBP [���] = MarketInfo ("EURGBP_m", MODE_BID);
   
   
   
   
   //�������� ������ � ����� ����������
   i2 = 0;
   for (i = ���; i >= 0 && i2 <= ���; i--)
      {
       ����GBPUSD����������[i] = ����GBPUSD[i2];
       i2 ++;
      }
   i2 = 0;
   for (i = ���; i >= 0 && i2 <= ���; i--)
      {
       ����EURUSD����������[i] = ����EURUSD[i2];
       i2 ++;
      }
   i2 = 0;
   for (i = ���; i >= 0 && i2 <= ���; i--)
      {
       ����EURGBP����������[i] = ����EURGBP[i2];
       i2 ++;
      }
      
   
   
   //�������� ������ � ������ ����������� ������� �����������
   if (��� > ����������)
      {
       for (tt = 0; tt < ��� - ����������; tt++)
         {
          ����� = 0;
          tt3 = 0;
          for (tt2 = tt; tt3 < ����������; tt2++, tt3++)
            {
             ����� = ����GBPUSD����������[tt2] + �����;
            }
          GBPUSD������� [tt] = ����� / ����������;
         }
      }
   if (��� > ����������)
      {
       for (tt = 0; tt < ��� - ����������; tt++)
         {
          ����� = 0;
          tt3 = 0;
          for (tt2 = tt; tt3 < ����������; tt2++, tt3++)
            {
             ����� = ����EURUSD����������[tt2] + �����;
            }
          EURUSD������� [tt] = ����� / ����������;
         }
      }
   if (��� > ����������)
      {
       for (tt = 0; tt < ��� - ����������; tt++)
         {
          ����� = 0;
          tt3 = 0;
          for (tt2 = tt; tt3 < ����������; tt2++, tt3++)
            {
             ����� = ����EURGBP����������[tt2] + �����;
            }
          EURGBP������� [tt] = ����� / ����������;
         }
      }
   
   
   
   //����������� �������� �����������
   if (��� > ����������)
      {
       for (tt = 0; tt < ��� - ����������; tt++)
         {
          �����GBPUSD [tt] = ����GBPUSD����������[tt] - GBPUSD������� [tt];
         }
      }
   if (��� > ����������)
      {
       for (tt = 0; tt < ��� - ����������; tt++)
         {
          �����EURUSD [tt] = ����EURUSD����������[tt] - EURUSD������� [tt];
         }
      }
   if (��� > ����������)
      {
       for (tt = 0; tt < ��� - ����������; tt++)
         {
          �����EURGBP [tt] = ����EURGBP����������[tt] - EURGBP������� [tt];
         }
      }
      
   Comment ("\n  ���������� ����������� ����� = ", ���);
   ��� ++;
   return(0);
  }

