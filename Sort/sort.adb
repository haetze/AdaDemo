package body Sort is
   function Is_Sorted(A : in Int_Array) return Boolean is 
   begin
      return (for all I in A'First .. A'Last - 1  => A(I) < A(I+1));
   end Is_Sorted;
   
   function Merge(A : in Sorted; B : in Sorted) return Sorted
   is 
      Index_Error : exception;
      I : My_Int := A'First;
      J : My_Int := B'First;
      S : Sorted(A'First..B'Last) := (others => 0);
   begin
      for K in S'Range loop
	 if I in A'Range and then J in B'Range then
	    if A(I) < B(J) then
	       S(K) := A(I); --S(K) := B(J);
	       I := I + 1;   --J := J + 1; 
	   else 
	      S(K) := B(J); --S(K) := A(I); 
	      J := J + 1;   --I := I + 1; 
	   end if;
	 elsif I in A'Range and then J not in B'Range then
	    S(K) := A(I);
	    I := I + 1;
	 elsif I not in A'Range and then J in B'Range then
	    S(K) := B(J);
	    J := J + 1;
	 else 
	    raise Index_Error;
	 end if;
      end loop;
      return S;
   end Merge;
   
   function Sort_Array(A : in Int_Array) return Sorted
   is 
      First : My_Int := A'First;
      Last : My_Int := A'Last;
      Middle : My_Int := (First + Last)/2;
      S_1 : Sorted(First..Middle);
      S_2 : Sorted(Middle + 1..Last);
   begin 
      if First = Last  or else First + 1 = Last then 
	 return A;
      else 
	 S_1 := Sort_Array(A(First..Middle));
	 S_2 := Sort_Array(A(Middle + 1..Last));
	 return Merge(S_1, S_2);
      end if;
   end Sort_Array;
   
   procedure Print(A : in Int_Array) is
      use My_Int_IO;
   begin
      for I in A'Range loop
	 Put(A(I));
	 Put(" ");
      end loop;
   end Print;
   
   
end Sort;
