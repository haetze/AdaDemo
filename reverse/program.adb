with Ada.Text_IO; use Ada.Text_IO;
with Rev;

-- Prove with: gnatprove -P prime.gpr -U --prover=all
procedure Program is
   pragma Spark_Mode(On);
   
   type Int is new Integer range -2048 .. 2048;
   
   package Int_IO is new Ada.Text_IO.Integer_IO(Int); 
   use Int_IO;
   
   type Arr is array (Positive range <>) of Int;
   
   package M_Rev is new Rev(Int, Arr);
   use M_Rev;
   
   procedure Print(A : in Arr) is
   begin
      for I in A'Range loop
	 Put(A(I));
      end loop;
   end Print;
   
   
   Test1 : Arr(1..10) := (1,2,3,4,5,6,7,8,9,0);
   Test2 : Arr(1..10) := (0,9,8,7,6,5,4,3,2,1);
   Test3 : Arr(1..10) := (1,1,1,1,1,1,1,1,1,1);
   Test4 : Arr(1..10) := Reverser(Test1);
begin
   Put_Line("Arrays:");
   Put("Test1:");
   Print(Test1);
   New_Line;
   Put("Test2:");
   Print(Test2);
   New_Line;
   Put("Test3:");
   Print(Test3);
   New_Line;
   Put("Test4 (calculated):");
   Print(Test4);
   New_Line;
   Put("Test1 = reversed(Test2): "); Put(Reversed(Test1, Test2)'Image); New_Line;
   Put("Test4 = reversed(Test1): "); Put(Reversed(Test4, Test1)'Image); New_Line;
   Put("Test1 = reversed(Test3): "); Put(Reversed(Test1, Test3)'Image); New_Line;
end Program;
