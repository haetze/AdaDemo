with Ada.Text_IO, Etc, Buffer;
use Ada.Text_IO, Etc;

procedure Program is
   use My_Float_IO, My_Int_IO, My_Elementary_Functions;
begin
   Put_Line("Press Enter to Continue.");
   Pause;
   Put_Line("Starting Create_Mem.");
   Buffer.Create_Mem;
   Put_Line("Finished Create_Mem.");
   Put_Line("Press Enter to Continue.");
   Pause;
end Program;
  
   
   
