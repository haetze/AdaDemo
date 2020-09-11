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
   Result2 : Vector := Ongoing_Sum(Result);
   
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
   Put("Result2:");
   for I in Result2'Range loop
     Put(" ");
     Put(Result2(I));
   end loop;
   New_Line;
   
   declare
      pragma Assertion_Policy(Check);
      function Add(A, B : Vector) return Vector 
	with Pre  => A'First = B'First and then A'Last = B'Last is
	 C : Vector := (A'First .. A'Last => 0.0);
      begin
	 for I in A'Range loop
	    C(I) := A(I) + B(I);
	 end loop;
	 return C;
      end Add;
   
      Example2 : Vector := (1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0);
   
      Result3 : Vector := Add(Example, Example2);
      --Result4 : Vector := Add(Result, Example); -- crashes before function is run
   
   begin
   
      Put("Result3:");
      for I in Example2'Range loop
	 Put(" ");
	 Put(Result3(I));
      end loop;
      New_Line;
   end;
end Program;
  
   
   
