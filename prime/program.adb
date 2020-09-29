with Ada.Text_IO; use Ada.Text_IO;
with Prime; use Prime;

-- Prove with: gnatprove -P prime.gpr -U --prover=all
procedure Program is
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
   New_Line;
   Put_Line("All smaller primes:");
   for I in Primes_Til(N)'Range loop
      Put(Primes_Til(N)(I));
      New_Line;
   end loop;
   
   
end Program;
