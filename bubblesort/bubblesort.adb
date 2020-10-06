package body Bubblesort is
   
   function Is_Sorted(A : Arr) return Boolean 
   is (for all I in A'Range => 
	 (for all J in A'First .. I => A(J) <= A(I)) and 
	 (for all J in I .. A'Last => A(I) <= A(J)));
   
   procedure Min_To_Idx(A : in out Arr; Idx : in Positive)
   with 
     Pre => A'First in Positive and
	    A'Last in Positive and
	    Idx in A'Range and
	    (if Idx - 1 in A'Range then Is_Sorted(A(A'First .. Idx - 1))) and
	    (if Idx - 1 in A'Range then (for all I in A'First .. Idx - 1 =>
					   (for all J in Idx .. A'Last => A(I) <= A(J)))),
     Post => Is_Sorted(A(A'First .. Idx)) and
	     (for all I in A'First .. Idx =>
		(for all J in Idx .. A'Last => A(I) <= A(J)))
   is 
      Tmp : T;
   begin
      for J in Idx .. A'Last loop
	 pragma Loop_Invariant(for all I in Idx .. J - 1 => A(Idx) <= A(I));
	 pragma Loop_Invariant(for all I in A'First .. Idx - 1 => A(I) <= A(Idx));
	 if A(J) < A(Idx) then
	    Tmp := A(J);
	    A(J) := A(Idx);
	    A(Idx) := Tmp;
	 end if;
      end loop;
   end Min_To_Idx;
   
   
   procedure Sort(A : in out Arr) is
   begin
      for I in A'Range loop
	 pragma Loop_Invariant(Is_Sorted(A(A'First .. I - 1)));
	 pragma Loop_Invariant(for all J in A'First .. I - 1 => 
				 (for all K in I .. A'Last => A(J) <= A(K)));
	 Min_To_Idx(A, I);
      end loop;
   end Sort;
   

end Bubblesort;
