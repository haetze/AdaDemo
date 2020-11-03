package body Tree
  with Spark_Mode => On 
is
   
   function New_Node(D : Int) return Node_P 
   with Spark_Mode => Off 
   is 
   begin
      return new Node'(C => 1,
		       D => D,
		       Lft => null,
		       Rgt => null,
		       Min => D,
		       Max => D);
   end New_Node;
   
   
   function Collect(N : in Node) return Arr
   is
      N_A : Arr(1..1) := (others => N.D);
   begin
      pragma Assert(N.D <= N.Max);
      pragma Assert(N.D >= N.Min);
      if N.Lft = null and N.Rgt = null then
	 return N_A;
      elsif N.Lft = null then
	 declare 
	    R_A : Arr := Collect(N.Rgt.all); 
	    R : Arr := N.D & R_A;
	 begin
	    pragma Assert(for all I in R_A'Range => R_A(I) >= N.D);	    
	    pragma Assert(for all I in R_A'Range => R_A(I) >= N.Rgt.Min);
	    pragma Assert(for all I in R_A'Range => R_A(I) <= N.Rgt.Max);
	    pragma Assert(for all I in R_A'Range => R_A(I) >= N.Min);
	    pragma Assert(for all I in R_A'Range => R_A(I) <= N.Max);
	    
	    pragma Assert(for all I in R'Range => R(I) <= N.Max);
	    pragma Assert(for all I in R'Range => R(I) >= N.Min);
	    
	    pragma Assert(for all I in R_A'Range =>
			    (for all J in R_A'First .. I => R_A(J) <= R_A(I)) and
			    (for all J in I .. R_A'Last => R_A(I) <= R_A(J)));	    
	    
	    pragma Assert(for all I in R'Range => R(I) >= R(R'First));
	    pragma Assert(for all I in R'Range =>
			    (for all J in R'First .. I => R(J) <= R(I)) and
			    (for all J in I .. R'Last => R(I) <= R(J)));
	    return R;
	 end;
      elsif N.Rgt = null then
	 declare
	    L_A : Arr := Collect(N.Lft.all);
	    R : Arr(1..L_A'Length + 1) := (others => 0);
	 begin
	    pragma Assert(for all I in L_A'Range => L_A(I) <= N.D);
	    pragma Assert(for all I in L_A'Range => L_A(I) >= N.Lft.Min);
	    pragma Assert(for all I in L_A'Range => L_A(I) <= N.Lft.Max);
	    pragma Assert(for all I in L_A'Range => L_A(I) >= N.Min);
	    pragma Assert(for all I in L_A'Range => L_A(I) <= N.Max);
	    
	    pragma Assert(for all I in L_A'Range =>
			    (for all J in L_A'First .. I => L_A(J) <= L_A(I)) and
			    (for all J in I .. L_A'Last => L_A(I) <= L_A(J)));	    

	    
	    R(1..L_A'Length) := L_A;
	    R(R'Last) := N.D;
	    
	    pragma Assert(for all I in R'Range => R(I) <= N.Max);
	    pragma Assert(for all I in R'Range => R(I) >= N.Min);
	    
	    pragma Assert(for all I in R'Range => R(I) <= R(R'Last));
	    
	    pragma Assert(for all I in R'Range =>
			    (for all J in R'First .. I => R(J) <= R(I)) and
			    (for all J in I .. R'Last => R(I) <= R(J)));

	    
	    return R;
	 end;	 
      else
	 declare
	    L_A : Arr := Collect(N.Lft.all);
	    R_A : Arr := Collect(N.Rgt.all);
	    R : Arr(1..L_A'Length + 1 + R_A'Length) := (others => 0);
	 begin
	    pragma Assert(for all I in L_A'Range => L_A(I) <= N.D);
	    pragma Assert(for all I in L_A'Range => L_A(I) >= N.Lft.Min);
	    pragma Assert(for all I in L_A'Range => L_A(I) <= N.Lft.Max);
	    pragma Assert(for all I in L_A'Range => L_A(I) >= N.Min);
	    pragma Assert(for all I in L_A'Range => L_A(I) <= N.Max);
	    
	    pragma Assert(for all I in L_A'Range =>
			    (for all J in L_A'First .. I => L_A(J) <= L_A(I)) and
			    (for all J in I .. L_A'Last => L_A(I) <= L_A(J)));	    
	    
	    pragma Assert(for all I in R_A'Range => R_A(I) >= N.D);
	    pragma Assert(for all I in R_A'Range => R_A(I) >= N.Rgt.Min);
	    pragma Assert(for all I in R_A'Range => R_A(I) <= N.Rgt.Max);
	    pragma Assert(for all I in R_A'Range => R_A(I) >= N.Min);
	    pragma Assert(for all I in R_A'Range => R_A(I) <= N.Max);
	    
	    pragma Assert(for all I in R_A'Range =>
			    (for all J in R_A'First .. I => R_A(J) <= R_A(I)) and
			    (for all J in I .. R_A'Last => R_A(I) <= R_A(J)));	    
	    
	    R(1..L_A'Length) := L_A;
	    R(L_A'Length + 1) := N.D;
	    R(L_A'Length + 2..R'Last) := R_A;
	    
	    pragma Assert(for all I in R'Range => R(I) <= N.Max);
	    pragma Assert(for all I in R'Range => R(I) >= N.Min);
	    
	    pragma Assert(for all I in R'First .. L_A'Length => R(I) <= R(L_A'Length + 1));
	    pragma Assert(for all I in L_A'Length + 1 .. R'Last => R(I) >= R(L_A'Length + 1));
	    
	    pragma Assert(for all I in R'Range =>
			    (for all J in R'First .. I => R(J) <= R(I)) and
			    (for all J in I .. R'Last => R(I) <= R(J)));

	    
	    
	    return R;
	 end;	 
      end if;
   end Collect;
   
   function Filter_Left(N : in not null Node_P; A : in Arr) return Arr
     with 
     Pre => (for all I in A'Range => Contained(N, A(I))),
     Post => (for all I in Filter_Left'Result'Range => Contained(N.Lft, Filter_Left'Result(I))) and
	     (for all I in A'Range => (not Contained(N.Lft, A(I)) and (Contained(N.Rgt, A(I)) or N.D = A(I))) or (for some J in Filter_Left'Result'Range => Filter_Left'Result(J) = A(I)))
   is
      B : Arr(1..A'Length) := (others => 0);
      C : Natural := 0;
   begin
      for I in A'Range loop
	 pragma Loop_Invariant(for all J in 1..C => Contained(N.Lft, B(J)));
	 pragma Loop_Invariant(for all J in A'First .. I - 1 => 
				 (not Contained(N.Lft, A(J)) and 
				    (Contained(N.Rgt, A(J)) or N.D = A(J))) or 
				 (for some K in 1..C => B(K) = A(J)));
	 pragma Loop_Invariant(C <= I - A'First);
	 pragma Loop_Invariant(C < B'Last);
	 pragma Assert(Contained(N, A(I)));
	 declare
	    P : Boolean := Contained(N, A(I))
	      with Ghost;
	 begin
	    pragma Assert(P);
	    pragma Assert(N.D = A(I) or Contained(N.Rgt, A(I)) or Contained(N.Lft, A(I)));
	 end;
	 
	 if Contained(N.Lft, A(I)) then
	    C := C + 1;
	    B(C) := A(I);
	 else
	    pragma Assert(Contained(N.Rgt, A(I)) or N.D = A(I));
	    null;
	 end if;
	 pragma Assert((not Contained(N.Lft, A(I)) and 
			  (Contained(N.Rgt, A(I)) or N.D = A(I))) 
			 or (C > 0 and then B(C) = A(I)));
	 
	 pragma Assert(for all J in A'First .. I - 1 => 
			 (not Contained(N.Lft, A(J)) and 
			    (Contained(N.Rgt, A(J)) or N.D = A(J))) or 
			 (for some K in 1..C => B(K) = A(J)));

	 pragma Assert(for all J in A'First .. I => 
			 (not Contained(N.Lft, A(J)) and 
			    (Contained(N.Rgt, A(J)) or N.D = A(J))) or 
			 (for some K in 1..C => B(K) = A(J)));
      end loop;
      return B(1..C);
   end Filter_Left;


   
   function Filter_Right(N : in not null Node_P; A : in Arr) return Arr
     with 
     Pre => (for all I in A'Range => Contained(N, A(I))),
     Post => (for all I in Filter_Right'Result'Range => Contained(N.Rgt, Filter_Right'Result(I))) and
	     (for all I in A'Range => (not Contained(N.Rgt, A(I)) and (Contained(N.Lft, A(I)) or N.D = A(I))) or (for some J in Filter_Right'Result'Range => Filter_Right'Result(J) = A(I)))
   is
      B : Arr(1..A'Length) := (others => 0);
      C : Natural := 0;
   begin
      for I in A'Range loop
	 pragma Loop_Invariant(for all J in 1..C => Contained(N.Rgt, B(J)));
	 pragma Loop_Invariant(for all J in A'First .. I - 1 => 
				 (not Contained(N.Rgt, A(J)) and 
				    (Contained(N.Lft, A(J)) or N.D = A(J))) or 
				 (for some K in 1..C => B(K) = A(J)));
	 pragma Loop_Invariant(C <= I - A'First);
	 pragma Loop_Invariant(C < B'Last);
	 pragma Assert(Contained(N, A(I)));
	 declare
	    P : Boolean := Contained(N, A(I))
	      with Ghost;
	 begin
	    pragma Assert(P);
	    pragma Assert(N.D = A(I) or Contained(N.Lft, A(I)) or Contained(N.Rgt, A(I)));
	 end;
	 
	 if Contained(N.Rgt, A(I)) then
	    C := C + 1;
	    B(C) := A(I);
	 else
	    pragma Assert(Contained(N.Lft, A(I)) or N.D = A(I));
	    null;
	 end if;
	 pragma Assert((not Contained(N.Rgt, A(I)) and 
			  (Contained(N.Lft, A(I)) or N.D = A(I))) 
			 or (C > 0 and then B(C) = A(I)));
	 pragma Assert(for all J in A'First .. I => 
			 (not Contained(N.Rgt, A(J)) and 
			    (Contained(N.Lft, A(J)) or N.D = A(J))) or 
			 (for some K in 1..C => B(K) = A(J)));
      end loop;
      return B(1..C);
   end Filter_Right;

   
   procedure Insert(N : in not null Node_P; E : in Int; A : in Arr)
   is
      Lefts : Arr := Filter_Left(N, A);
      Rights : Arr := Filter_Right(N, A);
   begin
      pragma Assert(for all I in A'Range => 
		      (for some J in Lefts'Range => Lefts(J) = A(I)) or
		      (for some J in Rights'Range => Rights(J) = A(I)) or
		      N.D = A(I));
      pragma Assert(for all I in A'Range => Contained(N, A(I)));
      N.C := N.C + 1;
      pragma Assume(for all I in A'Range => Contained(N, A(I))); -- Don't know how to tell spark Contained doesn't depend on the modified field
      if N.D < E then
	 if N.Max < E then
	    N.Max := E;
	    pragma Assume(for all I in A'Range => Contained(N, A(I))); -- Don't know how to tell spark Contained doesn't depend on the modified field
	 end if;
	 if N.Lft = null and N.Rgt = null then
	    pragma Assert(for all I in A'Range => Contained(N, A(I)));
	    N.Rgt := New_Node(E);
	    pragma Assume(for all I in A'Range => Contained(N, A(I))); -- Don't know how to tell spark Contained doesn't depend on the modified field from null -> something else
	    pragma Assert(Contained(N.Rgt, E));
	 elsif N.Lft = null then
	    pragma Assert(for all I in A'Range => Contained(N, A(I)));
	    Insert(N.Rgt, E, Rights);
	    pragma Assert(for all I in Rights'Range => Contained(N.Rgt, Rights(I)));
	    pragma Assert(for all I in Lefts'Range => Contained(N.Lft, Lefts(I)));
	    pragma Assert(for all I in A'Range => 
			    (for some J in Lefts'Range => Lefts(J) = A(I)) or
			    (for some J in Rights'Range => Rights(J) = A(I)) or
			    N.D = A(I));
	    pragma Assert(for all I in A'Range => 
			    (if (for some J in Rights'Range => Rights(J) = A(I)) then Contained(N.Rgt, A(I))) and
			    (if (for some J in Lefts'Range => Lefts(J) = A(I)) then Contained(N.Lft, A(I))));
	    pragma Assert(for all I in A'Range =>
			    Contained(N.Rgt, A(I)) or
			    Contained(N.Lft, A(I)) or
			    N.D = A(I));
	    declare
	       P : Boolean := (for all I in A'Range =>
				 Contained(N.Rgt, A(I)) or
				 Contained(N.Lft, A(I)) or
				 N.D = A(I))
		 with Ghost;
	       Qs : array (A'Range) of Boolean := (others => False)
		 with Ghost;
	    begin
	       pragma Assert(P);
	       for I in A'Range loop
		  declare 
		     Q : Boolean := Contained(N, A(I))
		       with Ghost;
		  begin
		     pragma Assert(Q = Contained(N.Rgt, A(I)) or Contained(N.Lft, A(I)) or N.D = A(I));
		     pragma Assert(Q);
		     pragma Assert(Q = Contained(N, A(I)));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Qs(J));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Qs(J) = Contained(N, A(J)));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Contained(N, A(J)));
		     Qs(I) := Contained(N, A(I));
		  end;
	       end loop;
	    end;
	    pragma Assert(for all I in A'Range => Contained(N, A(I)));
	    pragma Assert(Contained(N.Rgt, E));
	 elsif N.Rgt = null then
	    N.Rgt := New_Node(E);
	    pragma Assume(for all I in A'Range => Contained(N, A(I))); -- Don't know how to tell spark Contained doesn't depend on the modified field from null -> something else
	    pragma Assert(Contained(N.Rgt, E));
	 else
	    Insert(N.Rgt, E, Rights);
	    pragma Assert(for all I in Rights'Range => Contained(N.Rgt, Rights(I)));
	    pragma Assert(for all I in Lefts'Range => Contained(N.Lft, Lefts(I)));
	    pragma Assert(for all I in A'Range => 
			    (for some J in Lefts'Range => Lefts(J) = A(I)) or
			    (for some J in Rights'Range => Rights(J) = A(I)) or
			    N.D = A(I));
	    pragma Assert(for all I in A'Range => 
			    (if (for some J in Rights'Range => Rights(J) = A(I)) then Contained(N.Rgt, A(I))) and
			    (if (for some J in Lefts'Range => Lefts(J) = A(I)) then Contained(N.Lft, A(I))));
	    pragma Assert(for all I in A'Range =>
			    Contained(N.Rgt, A(I)) or
			    Contained(N.Lft, A(I)) or
			    N.D = A(I));
	    declare
	       P : Boolean := (for all I in A'Range =>
				 Contained(N.Rgt, A(I)) or
				 Contained(N.Lft, A(I)) or
				 N.D = A(I))
		 with Ghost;
	       Qs : array (A'Range) of Boolean := (others => False)
		 with Ghost;
	    begin
	       pragma Assert(P);
	       for I in A'Range loop
		  declare 
		     Q : Boolean := Contained(N, A(I))
		       with Ghost;
		  begin
		     pragma Assert(Q = Contained(N.Rgt, A(I)) or Contained(N.Lft, A(I)) or N.D = A(I));
		     pragma Assert(Q);
		     pragma Assert(Q = Contained(N, A(I)));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Qs(J));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Qs(J) = Contained(N, A(J)));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Contained(N, A(J)));
		     Qs(I) := Contained(N, A(I));
		  end;
	       end loop;
	    end;
	    pragma Assert(for all I in A'Range => Contained(N, A(I)));
	    pragma Assert(Contained(N.Rgt, E));
	 end if;
      else
	 if N.Min > E then
	    N.Min := E;
	    pragma Assume(for all I in A'Range => Contained(N, A(I))); -- Don't know how to tell spark Contained doesn't depend on the modified field
	 end if;
	 if N.Lft = null and N.Rgt = null then
	    N.Lft := New_Node(E);
	    pragma Assume(for all I in A'Range => Contained(N, A(I))); -- Don't know how to tell spark Contained doesn't depend on the modified field from null -> something else
	    pragma Assert(Contained(N.Lft, E));
	 elsif N.Rgt = null then
	    Insert(N.Lft, E, Lefts);
	    pragma Assert(for all I in Rights'Range => Contained(N.Rgt, Rights(I)));
	    pragma Assert(for all I in Lefts'Range => Contained(N.Lft, Lefts(I)));
	    pragma Assert(for all I in A'Range => 
			    (for some J in Lefts'Range => Lefts(J) = A(I)) or
			    (for some J in Rights'Range => Rights(J) = A(I)) or
			    N.D = A(I));
	    pragma Assert(for all I in A'Range => 
			    (if (for some J in Rights'Range => Rights(J) = A(I)) then Contained(N.Rgt, A(I))) and
			    (if (for some J in Lefts'Range => Lefts(J) = A(I)) then Contained(N.Lft, A(I))));
	    pragma Assert(for all I in A'Range =>
			    Contained(N.Rgt, A(I)) or
			    Contained(N.Lft, A(I)) or
			    N.D = A(I));
	    declare
	       P : Boolean := (for all I in A'Range =>
				 Contained(N.Rgt, A(I)) or
				 Contained(N.Lft, A(I)) or
				 N.D = A(I))
		 with Ghost;
	       Qs : array (A'Range) of Boolean := (others => False)
		 with Ghost;
	    begin
	       pragma Assert(P);
	       for I in A'Range loop
		  declare 
		     Q : Boolean := Contained(N, A(I))
		       with Ghost;
		  begin
		     pragma Assert(Q = Contained(N.Rgt, A(I)) or Contained(N.Lft, A(I)) or N.D = A(I));
		     pragma Assert(Q);
		     pragma Assert(Q = Contained(N, A(I)));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Qs(J));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Qs(J) = Contained(N, A(J)));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Contained(N, A(J)));
		     Qs(I) := Contained(N, A(I));
		  end;
	       end loop;
	    end;
	    pragma Assert(for all I in A'Range => Contained(N, A(I)));
	    pragma Assert(Contained(N.Lft, E));
	 elsif N.Lft = null then
	    N.Lft := New_Node(E);
	    pragma Assume(for all I in A'Range => Contained(N, A(I))); -- Don't know how to tell spark Contained doesn't depend on the modified field from null -> something else
	    pragma Assert(Contained(N.Lft, E));
	 else
	    Insert(N.Lft, E, Lefts);
	    pragma Assert(for all I in Rights'Range => Contained(N.Rgt, Rights(I)));
	    pragma Assert(for all I in Lefts'Range => Contained(N.Lft, Lefts(I)));
	    pragma Assert(for all I in A'Range => 
			    (for some J in Lefts'Range => Lefts(J) = A(I)) or
			    (for some J in Rights'Range => Rights(J) = A(I)) or
			    N.D = A(I));
	    pragma Assert(for all I in A'Range => 
			    (if (for some J in Rights'Range => Rights(J) = A(I)) then Contained(N.Rgt, A(I))) and
			    (if (for some J in Lefts'Range => Lefts(J) = A(I)) then Contained(N.Lft, A(I))));
	    pragma Assert(for all I in A'Range =>
			    Contained(N.Rgt, A(I)) or
			    Contained(N.Lft, A(I)) or
			    N.D = A(I));
	    declare
	       P : Boolean := (for all I in A'Range =>
				 Contained(N.Rgt, A(I)) or
				 Contained(N.Lft, A(I)) or
				 N.D = A(I))
		 with Ghost;
	       Qs : array (A'Range) of Boolean := (others => False)
		 with Ghost;
	    begin
	       pragma Assert(P);
	       for I in A'Range loop
		  declare 
		     Q : Boolean := Contained(N, A(I))
		       with Ghost;
		  begin
		     pragma Assert(Q = Contained(N.Rgt, A(I)) or Contained(N.Lft, A(I)) or N.D = A(I));
		     pragma Assert(Q);
		     pragma Assert(Q = Contained(N, A(I)));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Qs(J));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Qs(J) = Contained(N, A(J)));
		     pragma Loop_Invariant(for all J in A'First .. I - 1 => Contained(N, A(J)));
		     Qs(I) := Contained(N, A(I));
		  end;
	       end loop;
	    end;
	    pragma Assert(for all I in A'Range => Contained(N, A(I)));
	    pragma Assert(Contained(N.Lft, E));
	 end if;
      end if;
      pragma Assert(Contained(N.Lft, E) or Contained(N.Rgt, E));
      declare
	 P : Boolean := Contained(N,E)
	   with Ghost => True;
      begin
	 pragma Assert((if N /= null then N.D = E or Contained(N.Lft, E) or Contained(N.Rgt, E) else False) = P);
      end;
   end Insert;
   
   function Insert(A : in Arr) return Node_P
   is
      N : Node_P;
   begin
      if A'Length = 0 then
	 return null;
      elsif A'Length = 1 then
	 N := New_Node(A(A'First));
	 return N;
      else
	 N := New_Node(A(A'First));
	 for I in A'First + 1 .. A'Last loop
	    pragma Loop_Invariant(I - A'First = N.C);
	    pragma Loop_Invariant(I - A'First < Count'Last);
	    pragma Loop_Invariant(for all J in A'First .. I - 1 => Contained(N, A(J)));
	    Insert(N, A(I), A(A'First .. I - 1));
	 end loop;
	 return N;
      end if;      
   end Insert;
   
end Tree;
