with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;

procedure Program is
   use My_Float_IO, My_Int_IO, My_Elementary_Functions;
   X : My_Float;
   R : My_Float;
begin
   Put("Input Number: ");
   Get(X);
   R := Sqrt(X);
   Put("Root of ");
   Put(X);
   Put(" is ");
   Put(R);
   Put(".");
end Program;
  
   
   
