package body Bsearch 
  with Spark_Mode => On
is
   procedure Search(A : in Arr; E : in Int; Found : out Boolean; Idx : out Positive) is
      Low : Positive := A'First;
      High : Positive := A'Last;
      Middle : Positive;
   begin
      Found := False;
      Idx := 1;
      if A'Length < 1 or else E < A(Low) or else A(High) < E then
	 return;
      end if;
      
      pragma Assert(E in A(Low) .. A(High));
      
      while 1 < High - Low  loop
	 pragma Loop_Invariant(Low in A'Range);
	 pragma Loop_Invariant(High in A'Range);
	 pragma Loop_Invariant(E in A(Low) .. A(High));
	 pragma Loop_Variant(Decreases => High - Low);
	 
	 Middle := Low + (High - Low) / 2;
	 pragma Assert(Low < Middle);
	 pragma Assert(Middle < High);
	 
	 
	 if A(Middle) <= E then
	    Low := Middle;
	 else
	    High := Middle;
	 end if;
      end loop;
      
      if A(Low) = E then
	 Found := True;
	 Idx := Low;
      elsif A(High) = E then
	 Found := True;
	 Idx := High;
      end if;
   end Search;
   
end Bsearch;
