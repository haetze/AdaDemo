with Ada.Text_IO; use Ada.Text_IO;
with Quicksort;

procedure Program 
  with Spark_Mode => On   
is
   type Int is range -2048..2048;
   
   package Qsort is new Quicksort(Int);
   use Qsort;
   
   procedure Print(A : in Arr) is
   begin
      for I in A'Range loop
	 Put(A(I)'Image);
      end loop;
   end Print;
   
   
   Test : Arr := (5,9,8,7,6,5,4,3,2,1,0);
   Test2 : Arr := Insertion_Sort(Test);
--   Splitted : P := Split(Test);
begin
   Print(Test);
   New_Line;
   --Print(Splitted.LE);
   New_Line;
   --Print(Splitted.G);
   New_Line;
   Sort(Test);
   Print(Test);
   New_Line;
   Print(Test2);
   
end Program;
