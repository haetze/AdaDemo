package body Prime 
   with Spark_Mode => On
is
   function Smaller_Prime(N : in Positive) return Positive is
   begin
      for I in reverse 2..N-1 loop
	 if Is_Prime(I) then
	    return I;
	 end if;
      end loop;
      return 2;
   end Smaller_Prime;
   
   function Number_Of_Primes(N : in Positive) return Natural is
      C : Natural := 0;
   begin
      for I in 2..N loop
	 pragma Loop_Invariant(C < I-1);
	 if Is_Prime(I) then
	    C := C + 1;
	 end if;
      end loop;
      return C;
   end Number_Of_Primes;
   
   
   function Primes_Til(N : in Positive) return Prime_Arr is
      R : Prime_Arr(1..N) := (others => 2);
      C : Natural := 0;
   begin
      for I in 2..N loop
	 pragma Loop_Invariant(C < I-1);
      	 pragma Loop_Invariant(for all I in 1..C => Is_Prime(R(I)));
      	 if Is_Prime(I) then
      	    C := C + 1;
      	    R(C) := I;
      	 end if;
      end loop;
      return R(1..C);
   end Primes_Til;
   
   
end Prime;

