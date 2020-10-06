with Ada.Text_IO; use Ada.Text_IO;
with Bubblesort;

procedure Program 
  with Spark_Mode => On   
is
   type Int is range -2048..2048;
   
   package Bsort is new Bubblesort(Int);
   use Bsort;
   
   procedure Print(A : in Arr) is
   begin
      for I in A'Range loop
	 Put(A(I)'Image);
      end loop;
   end Print;
   
   
   Test : Arr := (5,9,8,7,6,5,4,3,2,1,0);
begin
   Print(Test);
   New_Line;
   Sort(Test);
   Print(Test);
end Program;
