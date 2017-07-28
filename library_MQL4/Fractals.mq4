
/*   
��� ��� ������ ���� ��������� ��������� ������� � ������ 
*/ 
   
   
   
   int nU;               //������� �������� ��������
   double FracUp [5];    //�������� � 1-�� �������� �� 5-� �������
   int BarFracUp [5];    //����� ���� ��� ������� � 1 �� 5 �������
   int nD;               //������� ������� ��������
   double FracD [5];     //�������� � 1-�� �������� �� 5-� ������
   int BarFracD [5];     //����� ���� ��� ������� � 1 �� 5 ������
       
       
       //���� ���������� �������� ��������
    for ( int i = 0; i < Bars; i++)
      {    
       double fU = iFractals (Symbol(),0,MODE_UPPER,i);
       if (fU != 0 && fU != EMPTY_VALUE)
         {
          FracUp[nU] = fU;
          BarFracUp[nU] = i;
          nU ++;
          if ( nU >= 5) break;
         }
      }
        
        
        //���� ���������� ������� ��������
    for ( int a = 0; a < Bars; a++)
      {
       double fD = iFractals (Symbol(),0,MODE_LOWER,a);
       if (fD != 0 && fD != EMPTY_VALUE)
         {
          FracD[nD] = fD;
          BarFracD[nD] = a;
          nD ++;
          if ( nD >= 5) break;
         }
      }  