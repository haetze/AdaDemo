with Ada.Text_Io; use Ada.Text_Io;
with Bsearch; use Bsearch;


procedure Program is
   A : Arr := (0,1,2,3,4,5,6,7,99);
   S : Boolean := Sorted(A);
   F : Boolean;
   I : Positive;
begin
   Put("A is sorted: "); Put(S'Image); New_Line;
   Search(A, 7, F, I);
   Put("Found 7 in A: "); Put(F'Image); New_Line;
   Put("Index is: "); Put(I'Image); New_Line;
end Program;
