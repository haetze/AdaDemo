with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;

procedure Program is
   pragma Assertion_Policy(Check);
   use My_Int_IO, My_Elementary_Functions;
   subtype Even is My_Int
     with Dynamic_Predicate => Even mod 2 = 0;
   
   E : Even := 2;
   
   
   subtype Day_Num is My_Int Range 1..7;
   
   type Day is (Mon,Tue,Wed,Thu,Fri,Sat,Sun);
   subtype Weekday is Day
     with Static_Predicate => Weekday in Mon | Tue | Wed | Thu | Fri;
   
   D : Weekday := Mon;
   D2 : Day := Sat;
   
   function Weekend(D : Weekday) return Boolean 
   is
   begin
      return False;
   end Weekend;
   
   function To_Day(N : Day_Num) return Day 
   is
   begin 
      case N is 
	 when 1 => return Mon;
	 when 2 => return Tue;
	 when 3 => return Wed;
	 when 4 => return Thu;
	 when 5 => return Fri;
	 when 6 => return Sat;
	 when 7 => return Sun;
      end case;
   end To_Day;
   
   
   N : Day_Num;
begin
   Put(E);
   New_Line;
   E := E + 2;
   Put(E);
   New_Line;
   --E := E + 1; -- Error not caught. Not at Compile- or Run-time. Pragma introduces runtime check.
   Put("Enter day number: ");
   Get(N);
   D := To_Day(N); -- Fails on some inputs
   Put_Line(Weekend(D)'Image); -- never fails
end Program;
  
   
   
