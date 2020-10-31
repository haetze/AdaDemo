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
		       Rgt => null);
   end New_Node;
   
   function Collect(N : in Node) return Arr
   is
      N_A : Arr(1..1) := (others => N.D);
   begin
      if N.Lft = null and N.Rgt = null then
	 return N_A;
      elsif N.Lft = null then
	 return N_A & Collect(N.Rgt.all);
      elsif N.Rgt = null then
	 declare
	    L_A : Arr := Collect(N.Lft.all);
	    R : Arr(1..L_A'Length + 1) := (others => 0);
	 begin
	    R(1..L_A'Length) := L_A;
	    R(R'Last) := N.D;
	    return R;
	 end;	 
      else
	 declare
	    L_A : Arr := Collect(N.Lft.all);
	    R_A : Arr := Collect(N.Rgt.all);
	    R : Arr(1..L_A'Length + 1 + R_A'Length) := (others => 0);
	 begin
	    R(1..L_A'Length) := L_A;
	    R(L_A'Length + 1) := N.D;
	    R(L_A'Length + 2..R'Last) := R_A;
	    return R;
	 end;	 
      end if;
   end Collect;

   procedure Insert(N : in not null Node_P; E : Int)
   is
   begin
      if N.D < E then
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
	    if N.Lft.C <= N.Rgt.C then
	       N.C := N.C + 1;
	       Insert(N.Rgt, E);
	    else
	       N.C := N.C + 1;
	       Insert(N.Rgt, E);
	    end if;
	 end if;
      else
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
	    if N.Rgt.C <= N.Lft.C then
	       N.C := N.C + 1;
	       Insert(N.Lft, E);
	    else
	       N.C := N.C + 1;
	       Insert(N.Lft, E);
	    end if;
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
   
   
end Tree;
