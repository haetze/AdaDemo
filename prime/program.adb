with Ada.Text_IO; use Ada.Text_IO;
with Prime; use Prime;

-- Prove with: gnatprove -P prime.gpr -U --prover=all
procedure Program is
   pragma Spark_Mode(On);
   
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
   declare
      Primes : Prime_Arr := Primes_Til(N);
   begin
      Put_Line("All smaller primes:");
      for I in Primes'Range loop
	 Put(Primes(I));
	 New_Line;
      end loop;
   end;
   
   
end Program;
