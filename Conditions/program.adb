with Ada.Text_IO, Etc, Stack;
use Ada.Text_IO, Etc, Stack;

procedure Program is
   use My_Int_IO, My_Elementary_Functions;
   S : Stack_T := Empty;
begin
   Put("Has dups ");
   Put(Has_Dups(S)'Image);
   New_Line;
   Put_Line("Push 10");
   Push(S, 10);
   Put("Has dups ");
   Put(Has_Dups(S)'Image);
   New_Line;
   Put_Line("Push 20");   -- change to 10 to look at Type_Invariant
   Push(S, 20);           -- change to 10 to look at Type_Invariant
   Put("Has dups ");
   Put(Has_Dups(S)'Image);
   New_Line;
   Put("Triple Top causes error. Commented out.");
   --  E := Pop(S);
   --  E := Pop(S);
   --  E := Pop(S);
end Program;
  
   
   
