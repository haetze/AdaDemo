with Ada.Text_IO; use Ada.Text_IO;
with Tree; use Tree;

procedure Program 
  with Spark_Mode => On   
is
   
   package Int_Io is new Ada.Text_IO.Integer_IO(Int);
   use Int_Io;
   
   
   -- Create Tree with 8,4,9,100,3,2
   T : not null Node_P := New_Node(8);   
begin
   Insert(T, 4);
   Insert(T, 9);
   Insert(T, 100);
   Insert(T, 3);
   Insert(T, 2);
   declare
      A : Arr := Collect(T.all);
   begin
      for I in A'Range loop
	 Put(A(I));
	 New_Line;
      end loop;
   end;
   
end Program;
