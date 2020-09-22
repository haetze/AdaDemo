with Ada.Text_IO; use Ada.Text_IO;


procedure Program is
   type Money is delta 0.01 digits 8 range 0.0 .. 999999.99;
   
   Some_Amount : Money := 1000.00;
   
   package Money_IO is new Ada.Text_IO.Decimal_IO(Money);
   
begin 
   Put_Line("Some clean amount:");
   Money_IO.Put(Some_Amount);
   New_Line;
   Put_Line("Rounding to 2 decimal points:");
   Money_IO.Put(Some_Amount/3);
end Program;

