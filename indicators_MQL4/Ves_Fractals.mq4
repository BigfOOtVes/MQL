/*
��������� ������������ �� 5 �������� ������� �������� � �������� � 15 ��������� ��������.
�� 5 �������� ������ � ���������� � ����� ���������� ����� �������� ������� ����������� ���������
*/
#property copyright "Ves Volk"
#property link      ""

#property indicator_chart_window    //��������� � ���� �������
#property indicator_buffers 6       //������� � ����������

extern color ����1���  = Black;   //���� 1 ������� ���������
extern color ����15��� = Red;//���� 15 �������� ���������

//�������� ���� ���������
double ������1�������  [100];
double ������1������   [100];
double ������15������� [100];
double ������15������  [100];

//�������� ������� ���������
datetime ������1������������  [100];
datetime ������1�����������   [100];
datetime ������15������������ [100];
datetime ������15�����������  [100];


int init()
  {
   //������� ������� ��� �������� ��������
   ObjectCreate ("�������0", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("�������1", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("�������2", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("�������3", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("�������4", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("�������5", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("�������6", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("�������7", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("������0", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("������1", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("������2", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("������3", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("������4", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("������5", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("������6", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("������7", OBJ_ARROW, 0, 0, 0);
   //������������� ���� ��� �������� ��������
   ObjectSet ("�������0", OBJPROP_COLOR, ����1���);
   ObjectSet ("�������1", OBJPROP_COLOR, ����1���);
   ObjectSet ("�������2", OBJPROP_COLOR, ����1���);
   ObjectSet ("�������3", OBJPROP_COLOR, ����1���);
   ObjectSet ("�������4", OBJPROP_COLOR, ����1���);
   ObjectSet ("�������5", OBJPROP_COLOR, ����1���);
   ObjectSet ("�������6", OBJPROP_COLOR, ����1���);
   ObjectSet ("�������7", OBJPROP_COLOR, ����1���);
   ObjectSet ("������0", OBJPROP_COLOR, ����1���);
   ObjectSet ("������1", OBJPROP_COLOR, ����1���);
   ObjectSet ("������2", OBJPROP_COLOR, ����1���);
   ObjectSet ("������3", OBJPROP_COLOR, ����1���);
   ObjectSet ("������4", OBJPROP_COLOR, ����1���);
   ObjectSet ("������5", OBJPROP_COLOR, ����1���);
   ObjectSet ("������6", OBJPROP_COLOR, ����1���);
   ObjectSet ("������7", OBJPROP_COLOR, ����1���);
   //������������� ������ ��� �������� ��������
   ObjectSet ("�������0", OBJPROP_WIDTH, 7);
   ObjectSet ("�������1", OBJPROP_WIDTH, 7);
   ObjectSet ("�������2", OBJPROP_WIDTH, 7);
   ObjectSet ("�������3", OBJPROP_WIDTH, 7);
   ObjectSet ("�������4", OBJPROP_WIDTH, 7);
   ObjectSet ("�������5", OBJPROP_WIDTH, 7);
   ObjectSet ("�������6", OBJPROP_WIDTH, 7);
   ObjectSet ("�������7", OBJPROP_WIDTH, 7);
   ObjectSet ("������0", OBJPROP_WIDTH, 7);
   ObjectSet ("������1", OBJPROP_WIDTH, 7);
   ObjectSet ("������2", OBJPROP_WIDTH, 7);
   ObjectSet ("������3", OBJPROP_WIDTH, 7);
   ObjectSet ("������4", OBJPROP_WIDTH, 7);
   ObjectSet ("������5", OBJPROP_WIDTH, 7);
   ObjectSet ("������6", OBJPROP_WIDTH, 7);
   ObjectSet ("������7", OBJPROP_WIDTH, 7);
   //������������� ��� ��� �������� ��������
   ObjectSet ("�������0", OBJPROP_ARROWCODE, 242);
   ObjectSet ("�������1", OBJPROP_ARROWCODE, 242);
   ObjectSet ("�������2", OBJPROP_ARROWCODE, 242);
   ObjectSet ("�������3", OBJPROP_ARROWCODE, 242);
   ObjectSet ("�������4", OBJPROP_ARROWCODE, 242);
   ObjectSet ("�������5", OBJPROP_ARROWCODE, 242);
   ObjectSet ("�������6", OBJPROP_ARROWCODE, 242);
   ObjectSet ("�������7", OBJPROP_ARROWCODE, 242);
   ObjectSet ("������0", OBJPROP_ARROWCODE, 241);
   ObjectSet ("������1", OBJPROP_ARROWCODE, 241);
   ObjectSet ("������2", OBJPROP_ARROWCODE, 241);
   ObjectSet ("������3", OBJPROP_ARROWCODE, 241);
   ObjectSet ("������4", OBJPROP_ARROWCODE, 241);
   ObjectSet ("������5", OBJPROP_ARROWCODE, 241);
   ObjectSet ("������6", OBJPROP_ARROWCODE, 241);
   ObjectSet ("������7", OBJPROP_ARROWCODE, 241);
//----------------------------------------------------------
   //������� ������� ��� 15 ��������� ��������
   ObjectCreate ("����15���0", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("����15���1", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("����15���2", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("����15���3", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("����15���4", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("����15���5", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("����15���6", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("����15���7", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("���15���0", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("���15���1", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("���15���2", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("���15���3", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("���15���4", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("���15���5", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("���15���6", OBJ_ARROW, 0, 0, 0);
   ObjectCreate ("���15���7", OBJ_ARROW, 0, 0, 0);
   //������������� ���� ��� �������� ��������
   ObjectSet ("����15���0", OBJPROP_COLOR, ����15���);
   ObjectSet ("����15���1", OBJPROP_COLOR, ����15���);
   ObjectSet ("����15���2", OBJPROP_COLOR, ����15���);
   ObjectSet ("����15���3", OBJPROP_COLOR, ����15���);
   ObjectSet ("����15���4", OBJPROP_COLOR, ����15���);
   ObjectSet ("����15���5", OBJPROP_COLOR, ����15���);
   ObjectSet ("����15���6", OBJPROP_COLOR, ����15���);
   ObjectSet ("����15���7", OBJPROP_COLOR, ����15���);
   ObjectSet ("���15���0", OBJPROP_COLOR, ����15���);
   ObjectSet ("���15���1", OBJPROP_COLOR, ����15���);
   ObjectSet ("���15���2", OBJPROP_COLOR, ����15���);
   ObjectSet ("���15���3", OBJPROP_COLOR, ����15���);
   ObjectSet ("���15���4", OBJPROP_COLOR, ����15���);
   ObjectSet ("���15���5", OBJPROP_COLOR, ����15���);
   ObjectSet ("���15���6", OBJPROP_COLOR, ����15���);
   ObjectSet ("���15���7", OBJPROP_COLOR, ����15���);
   //������������� ������ ��� �������� ��������
   ObjectSet ("����15���0", OBJPROP_WIDTH, 4);
   ObjectSet ("����15���1", OBJPROP_WIDTH, 4);
   ObjectSet ("����15���2", OBJPROP_WIDTH, 4);
   ObjectSet ("����15���3", OBJPROP_WIDTH, 4);
   ObjectSet ("����15���4", OBJPROP_WIDTH, 4);
   ObjectSet ("����15���5", OBJPROP_WIDTH, 4);
   ObjectSet ("����15���6", OBJPROP_WIDTH, 4);
   ObjectSet ("����15���7", OBJPROP_WIDTH, 4);
   ObjectSet ("���15���0", OBJPROP_WIDTH, 4);
   ObjectSet ("���15���1", OBJPROP_WIDTH, 4);
   ObjectSet ("���15���2", OBJPROP_WIDTH, 4);
   ObjectSet ("���15���3", OBJPROP_WIDTH, 4);
   ObjectSet ("���15���4", OBJPROP_WIDTH, 4);
   ObjectSet ("���15���5", OBJPROP_WIDTH, 4);
   ObjectSet ("���15���6", OBJPROP_WIDTH, 4);
   ObjectSet ("���15���7", OBJPROP_WIDTH, 4);
   //������������� ��� ��� �������� ��������
   ObjectSet ("����15���0", OBJPROP_ARROWCODE, 242);
   ObjectSet ("����15���1", OBJPROP_ARROWCODE, 242);
   ObjectSet ("����15���2", OBJPROP_ARROWCODE, 242);
   ObjectSet ("����15���3", OBJPROP_ARROWCODE, 242);
   ObjectSet ("����15���4", OBJPROP_ARROWCODE, 242);
   ObjectSet ("����15���5", OBJPROP_ARROWCODE, 242);
   ObjectSet ("����15���6", OBJPROP_ARROWCODE, 242);
   ObjectSet ("����15���7", OBJPROP_ARROWCODE, 242);
   ObjectSet ("���15���0", OBJPROP_ARROWCODE, 241);
   ObjectSet ("���15���1", OBJPROP_ARROWCODE, 241);
   ObjectSet ("���15���2", OBJPROP_ARROWCODE, 241);
   ObjectSet ("���15���3", OBJPROP_ARROWCODE, 241);
   ObjectSet ("���15���4", OBJPROP_ARROWCODE, 241);
   ObjectSet ("���15���5", OBJPROP_ARROWCODE, 241);
   ObjectSet ("���15���6", OBJPROP_ARROWCODE, 241);
   ObjectSet ("���15���7", OBJPROP_ARROWCODE, 241);
   return(0);
  }

int deinit()
  {
   ObjectsDeleteAll ();
   return(0);
  }


int start()
  {
   int ������������� = 0;
   double ���������������� [1000];
//--------------------------------------------------------------------------------------
   //��������� ������� �������
   for (int x = 0; ������������� < 8; x++)
      {
       ���������������� [x] = iFractals (Symbol (), PERIOD_H1, MODE_UPPER, x);
       if (���������������� [x] != 0)
         {
          ������1������� [�������������] = ���������������� [x] + 100 * Point;
          ������1������������ [�������������] = iTime (Symbol (), PERIOD_H1, x);
          �������������++;
         } 
      }
   //��������� ������ �������
   ������������� = 0;
   for (int x1 = 0; ������������� < 8; x1++)
      {
       ���������������� [x1] = iFractals (Symbol (), PERIOD_H1, MODE_LOWER, x1);
       if (���������������� [x1] != 0)
         {
          ������1������ [�������������] = ���������������� [x1];
          ������1����������� [�������������] = iTime (Symbol (), PERIOD_H1, x1);
          �������������++;
         } 
      }
//-----------------------------------------------------------------------------------------
   //��������� ������� 15 ��������
   ������������� = 0;
   for (int x2 = 0; ������������� < 8; x2++)
      {
       ���������������� [x2] = iFractals (Symbol (), PERIOD_M15, MODE_UPPER, x2);
       if (���������������� [x2] != 0)
         {
          ������15������� [�������������] = ���������������� [x2] + 50 * Point;
          ������15������������ [�������������] = iTime (Symbol (), PERIOD_M15, x2);
          �������������++;
         } 
      }
   //��������� ������ 15 ��������
   ������������� = 0;
   for (int x3 = 0; ������������� < 8; x3++)
      {
       ���������������� [x3] = iFractals (Symbol (), PERIOD_M15, MODE_LOWER, x3);
       if (���������������� [x3] != 0)
         {
          ������15������ [�������������] = ���������������� [x3];
          ������15����������� [�������������] = iTime (Symbol (), PERIOD_M15, x3);
          �������������++;
         } 
      }
   //������������ ��������
   //������� ��������
   ObjectSet ("�������0", OBJPROP_TIME1, ������1������������ [0]); 
   ObjectSet ("�������0", OBJPROP_PRICE1, ������1������� [0]);
   ObjectSet ("�������1", OBJPROP_TIME1, ������1������������ [1]); 
   ObjectSet ("�������1", OBJPROP_PRICE1, ������1������� [1]);
   ObjectSet ("�������2", OBJPROP_TIME1, ������1������������ [2]); 
   ObjectSet ("�������2", OBJPROP_PRICE1, ������1������� [2]);
   ObjectSet ("�������3", OBJPROP_TIME1, ������1������������ [3]); 
   ObjectSet ("�������3", OBJPROP_PRICE1, ������1������� [3]);
   ObjectSet ("�������4", OBJPROP_TIME1, ������1������������ [4]); 
   ObjectSet ("�������4", OBJPROP_PRICE1, ������1������� [4]);
   ObjectSet ("�������5", OBJPROP_TIME1, ������1������������ [5]); 
   ObjectSet ("�������5", OBJPROP_PRICE1, ������1������� [5]);
   ObjectSet ("�������6", OBJPROP_TIME1, ������1������������ [6]); 
   ObjectSet ("�������6", OBJPROP_PRICE1, ������1������� [6]);
   ObjectSet ("�������7", OBJPROP_TIME1, ������1������������ [7]); 
   ObjectSet ("�������7", OBJPROP_PRICE1, ������1������� [7]);
   
   ObjectSet ("������0", OBJPROP_TIME1, ������1����������� [0]); 
   ObjectSet ("������0", OBJPROP_PRICE1, ������1������ [0]);
   ObjectSet ("������1", OBJPROP_TIME1, ������1����������� [1]); 
   ObjectSet ("������1", OBJPROP_PRICE1, ������1������ [1]);
   ObjectSet ("������2", OBJPROP_TIME1, ������1����������� [2]); 
   ObjectSet ("������2", OBJPROP_PRICE1, ������1������ [2]);
   ObjectSet ("������3", OBJPROP_TIME1, ������1����������� [3]); 
   ObjectSet ("������3", OBJPROP_PRICE1, ������1������ [3]);
   ObjectSet ("������4", OBJPROP_TIME1, ������1����������� [4]); 
   ObjectSet ("������4", OBJPROP_PRICE1, ������1������ [4]);
   ObjectSet ("������5", OBJPROP_TIME1, ������1����������� [5]); 
   ObjectSet ("������5", OBJPROP_PRICE1, ������1������ [5]);
   ObjectSet ("������6", OBJPROP_TIME1, ������1����������� [6]); 
   ObjectSet ("������6", OBJPROP_PRICE1, ������1������ [6]);
   ObjectSet ("������7", OBJPROP_TIME1, ������1����������� [7]); 
   ObjectSet ("������7", OBJPROP_PRICE1, ������1������ [7]);
   
   //15 �������� ��������
   ObjectSet ("����15���0", OBJPROP_TIME1, ������15������������ [0]); 
   ObjectSet ("����15���0", OBJPROP_PRICE1, ������15������� [0]);
   ObjectSet ("����15���1", OBJPROP_TIME1, ������15������������ [1]); 
   ObjectSet ("����15���1", OBJPROP_PRICE1, ������15������� [1]);
   ObjectSet ("����15���2", OBJPROP_TIME1, ������15������������ [2]); 
   ObjectSet ("����15���2", OBJPROP_PRICE1, ������15������� [2]);
   ObjectSet ("����15���3", OBJPROP_TIME1, ������15������������ [3]); 
   ObjectSet ("����15���3", OBJPROP_PRICE1, ������15������� [3]);
   ObjectSet ("����15���4", OBJPROP_TIME1, ������15������������ [4]); 
   ObjectSet ("����15���4", OBJPROP_PRICE1, ������15������� [4]);
   ObjectSet ("����15���5", OBJPROP_TIME1, ������15������������ [5]); 
   ObjectSet ("����15���5", OBJPROP_PRICE1, ������15������� [5]);
   ObjectSet ("����15���6", OBJPROP_TIME1, ������15������������ [6]); 
   ObjectSet ("����15���6", OBJPROP_PRICE1, ������15������� [6]);
   ObjectSet ("����15���7", OBJPROP_TIME1, ������15������������ [7]); 
   ObjectSet ("����15���7", OBJPROP_PRICE1, ������15������� [7]);
   
   ObjectSet ("���15���0", OBJPROP_TIME1, ������15����������� [0]); 
   ObjectSet ("���15���0", OBJPROP_PRICE1, ������15������ [0]);
   ObjectSet ("���15���1", OBJPROP_TIME1, ������15����������� [1]); 
   ObjectSet ("���15���1", OBJPROP_PRICE1, ������15������ [1]);
   ObjectSet ("���15���2", OBJPROP_TIME1, ������15����������� [2]); 
   ObjectSet ("���15���2", OBJPROP_PRICE1, ������15������ [2]);
   ObjectSet ("���15���3", OBJPROP_TIME1, ������15����������� [3]); 
   ObjectSet ("���15���3", OBJPROP_PRICE1, ������15������ [3]);
   ObjectSet ("���15���4", OBJPROP_TIME1, ������15����������� [4]); 
   ObjectSet ("���15���4", OBJPROP_PRICE1, ������15������ [4]);
   ObjectSet ("���15���5", OBJPROP_TIME1, ������15����������� [5]); 
   ObjectSet ("���15���5", OBJPROP_PRICE1, ������15������ [5]);
   ObjectSet ("���15���6", OBJPROP_TIME1, ������15����������� [6]); 
   ObjectSet ("���15���6", OBJPROP_PRICE1, ������15������ [6]);
   ObjectSet ("���15���7", OBJPROP_TIME1, ������15����������� [7]); 
   ObjectSet ("���15���7", OBJPROP_PRICE1, ������15������ [7]);
   
   return(0);
  }

