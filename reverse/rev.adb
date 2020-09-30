package body Rev is
   function Reversed(A : in Arr; B : in Arr) return Boolean is
      (for all I in 0..A'Length - 1 => A(A'First + I) = B(B'Last - I));
   
   function Reverser(A : in Arr) return Arr is
      B : Arr := A;
      F : Positive := A'First;
      L : Positive := A'Last;
   begin
      pragma Assert(B'First = A'First);
      pragma Assert(B'Last = A'Last);
      for I in 0..A'Length - 1 loop
	 -- Proof for index access
	 pragma Loop_Invariant(F + I <= L);
	 pragma Loop_Invariant(L - I >= F);
	 -- Previous swaps
	 pragma Loop_Invariant(if I >= 1 then A(F + I - 1) = B(L - (I - 1))); 
	 pragma Loop_Invariant(if I >= 2 then A(F + I - 2) = B(L - (I - 2))); 
	 pragma Loop_Invariant(for all J in 1..I => A(F + I - J) = B(L - (I - J))); 
	 
	 B(L - I) := A(F + I);
      end loop;
      pragma Assert(for all J in 0..A'Length - 1 => A(F + J) = B(L - J));
      return B;
   end Reverser;
   
		   
   
end Rev;
