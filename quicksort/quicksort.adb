package body Quicksort is
   
   function Is_Sorted(A : Arr) return Boolean is
   begin
      return (for all I in A'Range => 
		(for all J in A'First .. I => A(J) <= A(I)) and (for all J in I .. A'Last => A(I) <= A(J)));
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
	    pragma Loop_Invariant(for all J in LE'Range => (if J > CLE then LE(J) = 0));
	    pragma Loop_Invariant(for all J in G'Range => (if J > CG then G(J) = 0));
	    pragma Loop_Invariant(A(I-1) = Pivot or (CLE /= 0 and then A(I-1) = LE(CLE)) or (CG /= 0 and then A(I-1) = G(CG)));
	    pragma Loop_Invariant(if A(I-1) < Pivot then A(I-1) = LE(CLE));
	    pragma Loop_Invariant(if A(I-1) > Pivot then A(I-1) = G(CG));
	    pragma Loop_Invariant(if A(I-1) = Pivot and I-1 > A'First then A(I-1) = LE(CLE));
	    pragma Loop_Invariant(if I > A'First + 1 then 
	      (for Some J in 1..CLE => A(I-1) = LE(J)) or 
	      (for Some J in 1..CG => A(I-1) = G(J)));
	    pragma Loop_Invariant(A(A'First) = Pivot);
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
   
   function Insertion_Sort(A : in Arr) return Arr is
      R : Arr(A'First + 1 .. A'Last);
      F : T;
   begin
      if A'Length <= 1 then
	 return A;
      else
	 F := A(A'First);
	 R := Insertion_Sort(A(A'First + 1 .. A'Last));
	 return Insert(R, F);
      end if;
   end Insertion_Sort;
      
   
   function Insert(A : in Arr; E : in T) return Arr is
      I : Positive;
      B : Arr(A'First..A'Last+1) := (others => 0);
   begin
      if A'Length = 0 or else A(A'First) >= E then
	 return E & A;
      else
	 I := A'First;
	 while I in A'Range and then A(I) < E loop
	    pragma Loop_Invariant(for all J in A'First .. I => A(J) < E);
	    I := I + 1;
	 end loop;
	 pragma Assert(for all J in A'First .. I-1 => A(J) < E);
	 pragma Assert(for all J in I .. A'Last => A(J) >= E);

	 pragma Assert(A(I-1) < E);
	 pragma Assert(A'Last < I or else E <= A(I));
	 B(A'First..I-1) := A(A'First .. I - 1);
	 B(I) := E;
	 pragma Assert(if I = Positive'Last then A'Last < I);
	 pragma Assert(if I = Positive'Last then I = B'Last);
	 if I < B'Last then 
	    B(I+1..B'Last) := A(I .. A'Last);
	 end if;
	 pragma Assert(B(I) = E);
	 pragma Assert(for all J in B'First .. I => B(J) <= B(I));
	 pragma Assert(I = Positive'Last or else (for all J in I+1 .. B'Last => B(J) >= B(I)));
	 
	 pragma Assert(for all J in A'First..I-1 => (for all K in A'First..J => A(K) <= A(J)));
	 pragma Assert(for all J in B'First..I-1 => (for all K in B'First..J => B(K) <= B(J)));
	 
	 pragma Assert(for all J in I..A'Last => (for all K in J..A'Last => A(J) <= A(K)));
	 pragma Assert(I = Positive'Last or else (for all J in I+1..B'Last => (for all K in J..B'Last => B(J) <= B(K))));
	 
	 pragma Assert(for all J in I..A'Last => (for all K in I..J => A(K) <= A(J)));
	 pragma Assert(I = Positive'Last or else (for all J in I+1..B'Last => (for all K in I+1..J => B(K) <= B(J))));
	 
	 pragma Assert(for all J in A'First..I-1 => (for all K in J..I-1 => A(J) <= A(K)));
	 pragma Assert(for all J in B'First..I-1 => (for all K in J..I-1 => B(J) <= B(K)));
	 
	 pragma Assert(B(I-1) < B(I));
	 pragma Assert(A'Last < I or else B(I) <= B(I+1));
	 
	 pragma Assert(for all J in B'First .. I  => (for all K in J..I-1 => B(J) <= B(K) and then B(J) <= B(I)));
	 pragma Assert(for all J in B'First .. I  => (for all K in J..I => B(J) <= B(K)));
	 return B;
      end if;
   end Insert;
   
   

end Quicksort;
