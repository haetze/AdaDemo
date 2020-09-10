with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;

procedure Program is
   use My_Float_IO, My_Int_IO, My_Elementary_Functions;
   type Vector is array (Integer range <>) of My_Float;
   
   function Ongoing_Sum(A : Vector) return Vector is
      Sum : My_Float := 0.0;
      Sums : Vector := (A'First .. A'Last+1 => 0.0);
   begin 
      for I in A'Range loop
	Sums(I) := Sum;
	Sum := Sum + A(I);
      end loop;
      Sums(A'Last + 1) := Sum;
      return Sums;
   end Ongoing_Sum;   
   
   Example : Vector := (1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0);
   
   Result : Vector := Ongoing_Sum(Example);
begin
   Put("Example:");
   for I in Example'Range loop
     Put(" ");
     Put(Example(I));
   end loop;
   New_Line;
   
   Put("Result:");
   for I in Result'Range loop
     Put(" ");
     Put(Result(I));
   end loop;
   New_Line;
end Program;
  
   
   
