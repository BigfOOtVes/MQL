/*
��������� ������. ���������� �������� ���� � ����� �� ���� ����� ���������
*/
#property copyright "Ves Volk"
#property link      ""

#property indicator_chart_window    //��������� � ���� �������
//#property indicator_buffers 6       //������� � ����������


extern int ������� = 20;
extern int ���������� = 0;
extern int ��������� = 6;
extern color �������� = DimGray;
extern color �������������� = DarkSeaGreen;
extern color ����������������� = DarkSalmon;
extern color ������������� = Maroon;


double �����1������� [10000];
double �����2������� [10000];
datetime �����1�������� [10000];
datetime �����2�������� [10000];
double �����1�������� [10000];
double �����2�������� [10000];
datetime �����1��������� [10000];
datetime �����2��������� [10000];
string ������ = "������";
string ������� = "�������";
string ���� = "����";
double �����1��������, �����2��������;
datetime �����1���������, �����2���������;

double
����_�510.8,
����_�423.6,
����_�361.8,
����_�311,
����_�261.8,
����_�211,
����_�161.8,
����_�138.2,
����_0,
����_23.6,
����_38.2,
����_50,
����_61.8,
����_76.4,
����_100,
����_138.2,
����_161.8,
����_211,
����_261.8,
����_311,
����_361.8,
����_423.6,
����_510.8;

int ���������������, ��������������, ����������;     //����������: 1 - �����, 2 - ����, 3 - ����

int init()
  {
//-----------------------------------------------------------------------------------------
   //������� �������
   for (int a = 0; a < �������; a++)
      {
       //������� ���
       ObjectCreate (������ + a, OBJ_TREND, 0, 0, 0, 0, 0);
       ObjectCreate (������� + a, OBJ_TREND, 0, 0, 0, 0, 0);
       ObjectSet (������ + a, OBJPROP_COLOR, ��������);
       ObjectSet (������� + a, OBJPROP_COLOR, ��������);
       ObjectSet (������ + a, OBJPROP_RAY, false);
       ObjectSet (������� + a, OBJPROP_RAY, false);
       ObjectSet (������ + a, OBJPROP_WIDTH, 3);
       ObjectSet (������� + a, OBJPROP_WIDTH, 3);
     
       //������� ����
       if (a > 0)
          {
              //���� ���� ��� ������
          if (iClose (Symbol (), PERIOD_D1, a) > iOpen (Symbol (), PERIOD_D1, a))
             {
              ObjectCreate (���� + a, OBJ_RECTANGLE, 0, 0, 0, 0, 0);
              ObjectSet (���� + a, OBJPROP_COLOR, ��������������);
             }
           //���� ���� ��� ���������
          else
             {
              ObjectCreate (���� + a, OBJ_RECTANGLE, 0, 0, 0, 0, 0);
              ObjectSet (���� + a, OBJPROP_COLOR, �����������������);
             }
          }
      
      }
//------------------------------------------------------------------------------------------
   //������� ���� �����
   ObjectCreate("fibo",OBJ_FIBO,0,0,0,0,0);
   
   ObjectSet("fibo",OBJPROP_RAY,false);                      //��� ��� �� ���
   ObjectSet("fibo",OBJPROP_LEVELCOLOR,�������������);       //���� ����� �����
   ObjectSet("fibo",OBJPROP_COLOR,Red);                      //���� ����� ����� ������� ���������
   ObjectSet("fibo",OBJPROP_STYLE,STYLE_DOT);                //����� ����������� �����, ������� ��������� ����� ������������
   ObjectSet("fibo",OBJPROP_LEVELSTYLE,STYLE_DASHDOT);       //����� ����������� ���� �������
   ObjectSet("fibo",OBJPROP_FIBOLEVELS,28);                  //���������� ���� �������
   
       //�������
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+0,2.618);
   ObjectSetFiboDescription("fibo",0,"261.8 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+1,2.11);
   ObjectSetFiboDescription("fibo",1,"211.0 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+2,1.618);
   ObjectSetFiboDescription("fibo",2,"161.8 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+3,1.382);
   ObjectSetFiboDescription("fibo",3,"138.2 " + " (%$) ");
        //���������� 
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+4,1.0);
   ObjectSetFiboDescription("fibo",4,"100.0 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+5,0.764);
   ObjectSetFiboDescription("fibo",5,"76.4 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+6,0.618);
   ObjectSetFiboDescription("fibo",6,"61.8 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+7,0.5);
   ObjectSetFiboDescription("fibo",7,"50.0 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+8,0.382);
   ObjectSetFiboDescription("fibo",8,"38.2 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+9,0.236);
   ObjectSetFiboDescription("fibo",9,"23.6 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+10,0.0);
   ObjectSetFiboDescription("fibo",10,"0.0 " + " (%$) ");
          //������
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+11,-0.382);
   ObjectSetFiboDescription("fibo",11,"138.2 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+12,-0.618);
   ObjectSetFiboDescription("fibo",12,"161.8 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+13,-1.11);
   ObjectSetFiboDescription("fibo",13,"211.0 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+14,-1.618);
   ObjectSetFiboDescription("fibo",14,"261.8 " + " (%$) ");
      //��� ��������� �������
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+15,3.11);
   ObjectSetFiboDescription("fibo",15,"311.0 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+16,3.618);
   ObjectSetFiboDescription("fibo",16,"361.8 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+17,-2.11);
   ObjectSetFiboDescription("fibo",17,"311.0 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+18,-2.618);
   ObjectSetFiboDescription("fibo",18,"361.8 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+19,4.236);
   ObjectSetFiboDescription("fibo",19,"423.6 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+20,5.108);
   ObjectSetFiboDescription("fibo",20,"510.8 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+21,-3.236);
   ObjectSetFiboDescription("fibo",21,"423.6 " + " (%$) ");
   ObjectSet("fibo",OBJPROP_FIRSTLEVEL+22,-4.108);
   ObjectSetFiboDescription("fibo",22,"510.8 " + " (%$) ");
    
   return(0);
  }

//------------------------------------------------------------------------------
int start()
  {
   //��������� ����������� �� ������������ ����
      //�����������
   if (Hour () > ���������)
      {
       //��������� �������� ����� ��� ��������� ��������
      int ���������������������������� = ��������� * 60 * 60; 
      for (int x = 0; x < �������; x++)
            {
             if (x == 0)
               {
                �����1�������� [x] = iTime (Symbol (), PERIOD_H1, Hour ());
                �����2�������� [x] = iTime (Symbol (), PERIOD_H1, Hour () - ���������);
             
                ObjectSet (������ + x, OBJPROP_TIME1, �����1�������� [x]);
                ObjectSet (������ + x, OBJPROP_TIME2, �����2�������� [x]);
                ObjectSet (������� + x, OBJPROP_TIME1, �����1�������� [x]);
                ObjectSet (������� + x, OBJPROP_TIME2, �����2�������� [x]);
             
                �����2������� [x] = iLow (Symbol (), 0, iLowest (Symbol (), 0, MODE_LOW, ��������� * 60 / Period (), ObjectGetShiftByValue (������ + x, 0) - ��������� * 60 / Period ()));
                �����1������� [x] = iHigh (Symbol (), 0, iHighest (Symbol (), 0, MODE_HIGH, ��������� * 60 / Period (), ObjectGetShiftByValue (������� + x, 0) - ��������� * 60 / Period ()));
               }
             else
               {
                �����1�������� [x] = iTime (Symbol (), PERIOD_D1, x);
                �����2�������� [x] = iTime (Symbol (), PERIOD_D1, x) + ����������������������������;
             
                ObjectSet (������ + x, OBJPROP_TIME1, �����1�������� [x]);
                ObjectSet (������ + x, OBJPROP_TIME2, �����2�������� [x]);
                ObjectSet (������� + x, OBJPROP_TIME1, �����1�������� [x]);
                ObjectSet (������� + x, OBJPROP_TIME2, �����2�������� [x]);
             
                �����2������� [x] = iLow (Symbol (), 0, iLowest (Symbol (), 0, MODE_LOW, ��������� * 60 / Period (), ObjectGetShiftByValue (������ + x, 0) - ��������� * 60 / Period ()));
                �����1������� [x] = iHigh (Symbol (), 0, iHighest (Symbol (), 0, MODE_HIGH, ��������� * 60 / Period (), ObjectGetShiftByValue (������� + x, 0) - ��������� * 60 / Period ()));
                
                �����1�������� [x] = iLow (Symbol (), PERIOD_D1, x);
                �����1��������� [x] = iTime (Symbol (), PERIOD_D1, x);
                �����2�������� [x] = iHigh (Symbol (), PERIOD_D1, x);
                �����2��������� [x] = iTime (Symbol (), PERIOD_D1, x - 1);
               }
            }
      }
//------------------------------------------------------------------------------------------
      //�� �����������
   if (Hour () < ���������)
      {
       //��������� �������� ����� ��� ��������� ��������
      int ����������������������������2 = ��������� * 60 * 60;
      for (int x2 = 0; x2 < �������; x2++)
            {
             if (x2 == 0)
               {
                �����1�������� [x2] = iTime (Symbol (), PERIOD_D1, 0);
                �����2�������� [x2] = MarketInfo (Symbol (), MODE_TIME);
                
                ObjectSet (������ + x2, OBJPROP_TIME1, �����1�������� [x2]);
                ObjectSet (������ + x2, OBJPROP_TIME2, �����2�������� [x2]);
                ObjectSet (������� + x2, OBJPROP_TIME1, �����1�������� [x2]);
                ObjectSet (������� + x2, OBJPROP_TIME2, �����2�������� [x2]);
                
                �����2������� [x2] = iLow (Symbol (), 0, iLowest (Symbol (), 0, MODE_LOW, ObjectGetShiftByValue (������ + x2, 0), 0));
                �����1������� [x2] = iHigh (Symbol (), 0, iHighest (Symbol (), 0, MODE_HIGH, ObjectGetShiftByValue (������� + x2, 0), 0));
               }
             else
               {
                �����1�������� [x2] = iTime (Symbol (), PERIOD_D1, x2);
                �����2�������� [x2] = iTime (Symbol (), PERIOD_D1, x2) + ����������������������������2;
             
                ObjectSet (������ + x2, OBJPROP_TIME1, �����1�������� [x2]);
                ObjectSet (������ + x2, OBJPROP_TIME2, �����2�������� [x2]);
                ObjectSet (������� + x2, OBJPROP_TIME1, �����1�������� [x2]);
                ObjectSet (������� + x2, OBJPROP_TIME2, �����2�������� [x2]);
             
                �����2������� [x2] = iLow (Symbol (), 0, iLowest (Symbol (), 0, MODE_LOW, ��������� * 60 / Period (), ObjectGetShiftByValue (������ + x2, 0) - ��������� * 60 / Period ()));
                �����1������� [x2] = iHigh (Symbol (), 0, iHighest (Symbol (), 0, MODE_HIGH, ��������� * 60 / Period (), ObjectGetShiftByValue (������� + x2, 0) - ��������� * 60 / Period ()));
                
                �����1�������� [x2] = iLow (Symbol (), PERIOD_D1, x2);
                �����1��������� [x2] = iTime (Symbol (), PERIOD_D1, x2);
                �����2�������� [x2] = iHigh (Symbol (), PERIOD_D1, x2);
                �����2��������� [x2] = iTime (Symbol (), PERIOD_D1, x2 - 1);
               }
            }
      }
//----------------------------------------------------------------------------------------
   //�������� ������� ��� ������� ������� ���� ��� ����������� �������
   ����������������� ();
//----------------------------------------------------------------------------------------
   //������������ �������-----------------------------------------
   for (int bb = 0; bb < �������; bb++)
      {
       //������� ���
       ObjectSet (������ + bb, OBJPROP_PRICE1, �����1������� [bb]);
       ObjectSet (������ + bb, OBJPROP_PRICE2, �����1������� [bb]);
       ObjectSet (������� + bb, OBJPROP_PRICE1, �����2������� [bb]);
       ObjectSet (������� + bb, OBJPROP_PRICE2, �����2������� [bb]);
       //������������ ����---------------------------------------
       if (bb > 0)
          {
              //���� ���� ��� ������------------------------------------------------
          if (iClose (Symbol (), PERIOD_D1, bb) > iOpen (Symbol (), PERIOD_D1, bb))
             {
              ObjectSet (���� + bb, OBJPROP_TIME1, �����1��������� [bb]);
              ObjectSet (���� + bb, OBJPROP_PRICE1, �����1�������� [bb]);
              ObjectSet (���� + bb, OBJPROP_TIME2, �����2��������� [bb]);
              ObjectSet (���� + bb, OBJPROP_PRICE2, �����2�������� [bb]);
              ObjectSet (���� + bb, OBJPROP_COLOR, ��������������);
             }
           //���� ���� ��� ���������----------------------------------------------
          else
             {
              ObjectSet (���� + bb, OBJPROP_TIME1, �����1��������� [bb]);
              ObjectSet (���� + bb, OBJPROP_PRICE1, �����1�������� [bb]);
              ObjectSet (���� + bb, OBJPROP_TIME2, �����2��������� [bb]);
              ObjectSet (���� + bb, OBJPROP_PRICE2, �����2�������� [bb]);
              ObjectSet (���� + bb, OBJPROP_COLOR, �����������������);
             }
          }
      
      }
//---------------------------------------------------------------------------------------
   //������������ ���� �����
   ObjectSet("fibo",OBJPROP_TIME1,�����1�������� [0]);
   ObjectSet("fibo",OBJPROP_PRICE1,�����1������� [0]);
   ObjectSet("fibo",OBJPROP_TIME2,�����2�������� [0]);
   ObjectSet("fibo",OBJPROP_PRICE2,�����2������� [0]);
//----------------------------------------------------------------------------------------
     
   
   return(0);
  }
  
  
int deinit()
  {
   //������� ��� �������
   ObjectsDeleteAll ();  
   return(0);
  }

//--------------------------------------------------------
//������� ��� ������ ������� ���� ��� ����������� �������
void ����������������� ()
   {
    ����_�261.8 = NormalizeDouble (�����1������� [0] - (�����1������� [0] - �����2������� [0]) * 2.618, Digits);
    ����_�211 = NormalizeDouble (�����1������� [0] - (�����1������� [0] - �����2������� [0]) * 2.11, Digits);
    ����_�161.8 = NormalizeDouble (�����1������� [0] - (�����1������� [0] - �����2������� [0]) * 1.618, Digits);
    ����_�138.2 = NormalizeDouble (�����1������� [0] - (�����1������� [0] - �����2������� [0]) * 1.382, Digits);
    ����_0 = NormalizeDouble (�����2������� [0], Digits);
    ����_23.6 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 0.236, Digits);
    ����_38.2 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 0.382, Digits);
    ����_50 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 0.5, Digits);
    ����_61.8 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 0.618, Digits);
    ����_76.4 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 0.764, Digits);
    ����_100 = NormalizeDouble (�����1������� [0], Digits);
    ����_138.2 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 1.382, Digits);
    ����_161.8 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 1.618, Digits);
    ����_211 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 2.11, Digits);
    ����_261.8 = NormalizeDouble (�����2������� [0] + (�����1������� [0] - �����2������� [0]) * 2.618, Digits);
    /*
    ��� �������� ���� �������� � ����������� ��������:
    ���� ������ = ������� + (�������� - �������) * �����������

    ��� �������� ���� ������� ������:
    ���� ������ = �������� - (�������� - �������) * �����������
   */
   }