with Ada.Text_IO; use Ada.Text_IO;

procedure Program is
   type ABC is (A,B,C);
   
   Var : ABC := A;
begin
   Put_Line(Var'Image);
   Var := ABC'Succ(Var);
   Put_Line(Var'Image);
   Var := ABC'Pred(Var);
   Put_Line(Var'Image);
   Var := ABC'Succ(Var);
   Put_Line(Var'Image);
   Var := ABC'Succ(Var);
   Put_Line(Var'Image);
   --Var := ABC'Succ(Var); Put_Line(Var'Image); -- Uncommenting this line causes a contraint exception
end Program;

