with Ada.Text_Io, Pred_List;
use Ada.Text_Io;

procedure Program 
with Spark_Mode => On
is
   type Int is range 0..100;
   type Arr is array (Positive range <>) of Int;
   
   function Bin(T : in Int) return Boolean
   is (T = 0 or T = 1);
   
   package Filter is new Pred_List(Int, Arr, Bin);
   
   A : Arr := (3,2,1,3,0,2,1,0,2);
   B : Arr := Filter.Filter(A);
begin
   for I in B'Range loop
      Put(Integer(B(I))'Image);
      New_Line;
   end loop;
end Program;
  
   
   
