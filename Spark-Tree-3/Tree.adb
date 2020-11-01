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

   procedure Insert(N : in not null Node_P; E : Int)
   is
   begin
      if N.D < E then
	 if N.Max < E then
	    N.Max := E;
	 end if;
	 if N.Lft = null and N.Rgt = null then
	    N.C := N.C + 1;
	    N.Rgt := New_Node(E);
	 elsif N.Lft = null then
	    N.C := N.C + 1;
	    Insert(N.Rgt, E);
	 elsif N.Rgt = null then
	    N.C := N.C + 1;
	    N.Rgt := New_Node(E);
	 else
	    N.C := N.C + 1;
	    Insert(N.Rgt, E);
	 end if;
      else
	 if N.Min > E then
	       N.Min := E;
	 end if;
	 if N.Lft = null and N.Rgt = null then
	    N.C := N.C + 1;
	    N.Lft := New_Node(E);
	 elsif N.Rgt = null then
	    N.C := N.C + 1;
	    Insert(N.Lft, E);
	 elsif N.Lft = null then
	    N.C := N.C + 1;
	    N.Lft := New_Node(E);
	 else
	    N.C := N.C + 1;
	    Insert(N.Lft, E);
	 end if;
      end if;
   end Insert;
   
   procedure Insert(N : in not null Node_P; A : in Arr)
   is
      C : Count := N.C;
   begin
      for I in A'Range loop
	 pragma Loop_Invariant(I - A'First + C = N.C);
	 pragma Loop_Invariant(I - A'First + C < Count'Last);
	 Insert(N, A(I));
      end loop;
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
	 Insert(N, A(A'First + 1 .. A'Last));
	 return N;
      end if;      
   end Insert;
   
end Tree;
