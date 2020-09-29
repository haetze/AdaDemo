package body Rev is
   function Reversed(A : in Arr; B : in Arr) return Boolean is
      AF : Positive := A'First;
      AL : Positive := A'Last;
      BF : Positive := B'First;
      BL : Positive := B'Last;
   begin
      if A'Length = B'Length and A'Length <= 1 then
	 return True;
      end if;
      return AF < AL 
	and then BF < BL 
	and then (A'Length = B'Length) 
	and then A(AF) = B(BL) 
	and then Reversed(A(AF + 1 .. AL), B(BF .. BL - 1));
   end Reversed;
   
   function Reverser(A : in Arr) return Arr is
      B : Arr := A;
      F : Positive := A'First;
      L : Positive := A'Last;
   begin
      if A'Length <= 1 then 
	 return B;
      end if;
      B(F + 1 .. L) := Reverser(A(F..L-1));
      B(F) := A(L);
      return B;
   end Reverser;
   
		   
   
end Rev;
