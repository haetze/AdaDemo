with Ada.Text_IO, Etc, Evenodd;
use Ada.Text_IO, Etc, Evenodd;

procedure Program is
   use My_Float_IO, My_Int_IO, My_Elementary_Functions,Evenodd;
   X : Pos;
   B : Boolean;
begin
   Put("Input Number: ");
   Get(X);
   B := Even(X);
   Put(X);
   Put(" is ");
   if B then
      Put("even.");
   else 
      Put("odd.");
   end if;
end Program;
  
   
   
