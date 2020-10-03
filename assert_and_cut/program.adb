with Ada.Text_IO; use Ada.Text_IO;	
     
procedure Program is	
	  pragma Spark_Mode(On);	
	  X : Integer := 0;			
  	  Y : Integer := 0;
	  C : Character;	
begin	    
	  Put("Inc X? (n/y): ");	
	  Get(C);  
	  if C = 'y' then	
	    X := X + 1;		
	  end if;  
	  pragma Assert(X = 0 or X = 1);	
	  Put("Inc Y? (n/y): ");	
	  Get(C);  
	  if C = 'y' then	
	    Y := Y + 1;		
	  end if;
	  pragma Assert_And_Cut(Y = 0 or Y = 1); -- Forget the Facts about X; with only assert it works
	  pragma Assert(X + y in 0..2);	 
	  X := X + Y;
	  Put_Line(X'Image);
end Program;	  
