package body Pred_List is
   
   
   function Filter(A : in Arr) return Arr is
      B : Arr(1..A'Length) := A;
      C : Natural := 0;
   begin
      for I in A'Range loop
	 pragma Loop_Invariant(C <= I - A'First);
	 pragma Loop_Invariant(for all J in 1..C => P(B(J)));
	 pragma Loop_Invariant(for all J in A'First .. I - 1 =>
				 (for some K in 1..C => A(J) = B(K)) or
				 not P(A(J)));
	 if P(A(I)) then
	    C := C + 1;
	    B(C) := A(I);
	 end if;
      end loop;
      return B(1 .. C);
   end Filter;
   
end Pred_List;
