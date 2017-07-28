
/*
���� ����� ������������ �� ��� ���������� ���������� � �������. 

��� �������� ���� �������� � ����������� ��������:
���� ������ = ������� + (�������� - �������) * �����������

��� �������� ���� ������� ������:
���� ������ = �������� - (�������� - �������) * �����������
*/

void fibo(double money1,double money2,int bar1,int bar2)
  {
   double to4ka1;
   datetime tim1;
   double to4ka2;
   datetime tim2;
   
   if (money1 > money2)
      {
       to4ka1 = money2;
       tim1 = Time[bar2];
       to4ka2 = money1;
       tim2 = Time[bar1];
      }
   else
      {
       to4ka1 = money1;
       tim1 = Time[bar1];
       to4ka2 = money2;
       tim2 = Time[bar2];
      }
   
   if (ObjectFind("fibo") == -1)
      ObjectCreate("fibo",OBJ_FIBO,0,tim1,to4ka1,tim2,to4ka2);  //���������� �� ������� ���������� ����� � �������� �����
   else
      {
       ObjectSet("fibo",OBJPROP_TIME1,tim1);
       ObjectSet("fibo",OBJPROP_PRICE1,to4ka1);
       ObjectSet("fibo",OBJPROP_TIME2,tim2);
       ObjectSet("fibo",OBJPROP_PRICE2,to4ka2);
      }
   ObjectSet("fibo",OBJPROP_RAY,false);                      //��� ��� �� ���
   ObjectSet("fibo",OBJPROP_LEVELCOLOR,DarkSlateGray);       //���� ����� �����
   ObjectSet("fibo",OBJPROP_COLOR,Red);                      //���� ����� ����� ������� ���������
   ObjectSet("fibo",OBJPROP_STYLE,STYLE_DOT);                //����� ����������� �����, ������� ��������� ����� ������������
   ObjectSet("fibo",OBJPROP_LEVELSTYLE,STYLE_DASHDOT);       //����� ����������� ���� �������
   ObjectSet("fibo",OBJPROP_FIBOLEVELS,16);                  //���������� ���� �������
   
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
  }