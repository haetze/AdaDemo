package body Quicksort is
   
   function Is_Sorted(A : Arr) return Boolean is
   begin
      return (for all I in A'Range => 
		(for all J in I .. A'Last => A(I) <= A(J)));
   end Is_Sorted;
   
   function Split(A : in Arr) return P is
      Pivot : T := 0;
      subtype Counter is Natural range 0 .. A'Length;
      CLE : Counter := 0;
      LE : Arr(1..Counter'Last) := (others => 0);
      CG : Counter := 0;
      G : Arr(1..Counter'Last) := (others => 0);
   begin
      if A'Length = 0 then
	 return (L_LE => 0, L_G => 0, LE => (others => 0), G => (others => 0), P => Pivot);
      else
	 Pivot := A(A'First);
	 for I in A'First + 1 .. A'Last loop
	    pragma Loop_Invariant(for all J in 1..CLE => LE(J) <= Pivot);
	    pragma Loop_Invariant(CLE <= I - A'First);
	    pragma Loop_Invariant(for all J in 1..CG => G(J) > Pivot);
	    pragma Loop_Invariant(CG <= I - A'First);
	    pragma Loop_Invariant(CG + CLE + 1 = I - A'First);
	    if A(I) <= Pivot then
	       CLE := CLE + 1;
	       LE(CLE) := A(I);
	    else
	       CG := CG + 1;
	       G(CG) := A(I);
	    end if;
	 end loop;
      end if;
      return (L_LE => CLE, L_G => CG, LE => LE(1..CLE), G => G(1..CG), P => Pivot);
   end Split;
   
   function All_The_Same(A : in Arr) return Boolean 
   with Pre => A'Length > 0 is
      F : T := A(A'First);
   begin
      for I in A'Range loop
	 if F /= A(I) then
	    return False;
	 end if;
      end loop;
      return True;
   end All_The_Same;
   
   
   
   --  function Sort(A : Arr) return Arr is
   --     Splitted : P := Split(A);
   --     LE : Arr := Splitted.LE;
   --     G : Arr := Splitted.G;
   --  begin
   --     if A'Length = 0 or else A'Length = 1 or else All_The_Same(A) then
   --  	 return A;
   --     else
   --  	 if LE'Length > 0 and G'Length > 0 then
   --  	    return Sort(LE) & Splitted.P & Sort(G);
   --  	 elsif LE'Length > 0 then
   --  	    return Sort(LE) & Splitted.P;
   --  	 elsif G'Length > 0 then
   --  	    return Splitted.P & Sort(G);
   --  	 else 
   --  	    raise Program_Error;
   --  	 end if;
   --     end if;
   --  end Sort;
   
   procedure Sort(A : in out Arr) is
      Tmp : T;
   begin
      while not Is_Sorted(A) loop
	 for I in A'Range loop
	    for J in I+1 .. A'Last loop 
	       if A(I) > A(J) then
		  Tmp := A(I);
		  A(I) := A(J);
		  A(J) := Tmp;
	       end if;
	    end loop;
	 end loop;
      end loop;
   end Sort;
   

end Quicksort;
