with Ada.Text_IO; use Ada.Text_IO;
with Prime; use Prime;

procedure Program 
  with Spark_Mode => On   
is
   package Int_IO is new Ada.Text_IO.Integer_IO(Positive); 
   use Int_IO;
   
   N : Positive;
   Prime : Boolean;
begin
   Put("Input Number to check: "); Get(N);
   Prime := Is_Prime(N);
   Put(N); Put(" is prime: "); Put(Prime'Image);
   New_Line;
   if not Prime and N > 1 then
      Put("The next smaller prime is "); Put(Smaller_Prime(N));
   end if;
end Program;
