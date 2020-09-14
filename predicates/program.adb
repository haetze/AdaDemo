with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;

procedure Program is
   pragma Assertion_Policy(Check);
   use My_Int_IO, My_Elementary_Functions;
   subtype Even is My_Int
     with Dynamic_Predicate => Even mod 2 = 0;
   
   E : Even := 2;
   
   type Day is (Mon,Tue,Wed,Thu,Fri,Sat,Sun);
   
   subtype Weekday is Day
     with Static_Predicate => Weekday in Mon | Tue | Wed | Thu | Fri;
   
   D : Weekday := Mon;
begin
   Put(E);
   New_Line;
   E := E + 2;
   Put(E);
   New_Line;
   E := E + 1; -- Error not caught. Not at Compile- or Run-time. Pragma introduces runtime check.
   Put(E);
   New_Line;
   D := Sat;   -- Static predicate is not caught at compile time
end Program;
  
   
   
