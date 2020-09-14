with Ada.Text_IO, Etc, Sort;
use Ada.Text_IO, Etc, Sort;

procedure Program is
   pragma Assertion_Policy(Check);
   
   use My_Int_IO;
   
   A_1 : Int_Array := (0,1,2,3,4,5,6);
   A_2 : Int_Array := (0,1,2,3,4,6,5);
   B_1 : Sorted(A_1'Range);
   B_2 : Sorted(A_1'Range);
begin
   Put("A_1: ");
   Print(A_1);
   New_Line;
   Put("A_1 sorted: ");
   Put_Line(Is_Sorted(A_1)'Image);
   
   Put("A_2: ");
   Print(A_2);
   New_Line;
   Put("A_2 sorted: ");
   Put_Line(Is_Sorted(A_2)'Image);

   B_1 := A_1; -- Crashes for A_2 (not sorted)
   Put("B_1: ");
   Print(B_1);
   New_Line;
   Put("B_1 sorted: ");
   Put_Line(Is_Sorted(B_1)'Image);
   
   B_2 := Sort_Array(A_2); -- Flipping the statement in merge triggers the Predicate error early.
   Put("B_2 (Sorted A_2): ");
   Print(B_2);
   New_Line;
   Put("B_2 sorted: ");
   Put_Line(Is_Sorted(B_2)'Image);

   Put_Line("Not Changing A_2");
   Put("A_2: ");
   Print(A_2);
   New_Line;
   Put("A_2 sorted: ");
   Put_Line(Is_Sorted(A_2)'Image);

   
end Program;
  
   
   
