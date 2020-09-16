with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;

procedure Program is
   use My_Float_IO;
   type V_Arr is array (Positive range <>) of My_Float;
   type Vec(N : Positive) is 
      record
	 Data : V_Arr(1..N) := (others => 0.0);
      end record;
   
   type Vec_5 is new Vec(5);
   
   -- can't use Vec(5)
   function Sum(V : Vec_5) return My_Float Is
      S : My_Float := 0.0;
   begin
      for I in 1..V.N loop
	 S := S + V.Data(I);
      end loop;
      return S;
   end Sum;
   
   
   Example : Vec(5) := (5, (others => 1.0));
begin
   -- Have to cast
   Put(Sum(Vec_5(Example)));
end Program;
  
   
   
