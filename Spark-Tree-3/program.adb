with Ada.Text_IO; use Ada.Text_IO;
with Tree; use Tree;

procedure Program 
  with Spark_Mode => On   
is
   
   package Int_Io is new Ada.Text_IO.Integer_IO(Int);
   use Int_Io;
   
   
   --  A : Arr := (4,9,100,3,2,43,21,32,56,357);
   --  T : Node_P := Insert(A);
   --  B : Arr := Collect(T.all);
begin
   --  for I in B'Range loop
   --     Put(B(I));
   --     New_Line;
   --  end loop;
   null;
end Program;
