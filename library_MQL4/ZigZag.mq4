
/*
��� ������� ��������� ��� ���������� ����� ���������� ZigZag 
� ������� ������ ����� �� ������� ��� ����� ���������
*/

//� ����� ������ ������� ���������� ���������� ZigZag
extern int ExtDepth=12;
extern int ExtDeviation=5;
extern int ExtBackstep=3;

int start()
  {
   //� �������
   int n;
   int Zbar[4]; //����� ���� � ���������
   double Zval[4]; //�������� ������� � ����� �������� Zval[1] - � ����� 1 � ��. 
 
   for(int i=0;i<Bars;i++)
      {
       double zz=iCustom(NULL,0,"ZigZag",ExtDepth,ExtDeviation,ExtBackstep,0,i);
         if(zz!=0 && zz!=EMPTY_VALUE)
            {
             Zbar[n]=i;
             Zval[n]=zz;
             n++;
                if(n>=4)break;
            }
      }
   
   return(0);
  }