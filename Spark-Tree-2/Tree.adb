package body Tree
  with Spark_Mode => On 
is
   
   function New_Node(D : Int) return Node_P 
   with Spark_Mode => Off 
   is 
   begin
      return new Node'(L => 0,
		       D => D,
		       Lft => null,
		       Rgt => null);
   end New_Node;
   
   function Collect(N : in Node) return Arr
   is
      N_A : Arr(1..1) := (others => N.D);
   begin
      pragma Assume(2**N.L <= 2*Level'Last); -- Not sure why Spark can't derive this
      
      if N.Lft = null and N.Rgt = null then
	 return N_A;
      elsif N.Lft = null then
	 pragma Assert(N.Rgt.L < N.L);
	 declare
	    R_A : Arr := Collect(N.Rgt.all);
	 begin
	    pragma Assert(R_A'Length <= 2 ** N.L - 1);
	    pragma Assert(R_A'Length <= 2**Level'Last - 1); 
	    return N_A & R_A;
	 end;	 
      elsif N.Rgt = null then
	 pragma Assert(N.Lft.L < N.L);
	 declare
	    L_A : Arr := Collect(N.Lft.all);
	    R : Arr(1..L_A'Length + 1) := (others => 0);
	 begin
	    pragma Assert(L_A'Length <= 2 ** N.L - 1);
	    pragma Assert(L_A'Length <= 2**Level'Last - 1); 
	    R(1..L_A'Length) := L_A;
	    R(R'Last) := N.D;
	    return R;
	 end;	 
      else
	 pragma Assert(N.Lft.L < N.L);
	 pragma Assert(N.Rgt.L < N.L);
	 pragma Assert((2**N.Lft.L - 1) + (2**N.Rgt.L - 1) < 2 ** (N.L + 1) - 1);
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
	    N.L := N.L + 1;
	    N.Rgt := New_Node(E);
	 elsif N.Lft = null then
	    N.L := N.L + 1;
	    Insert(N.Rgt, E);
	 elsif N.Rgt = null then
	    N.Rgt := New_Node(E);
	 else
	    if N.Lft.L <= N.Rgt.L then
	       N.L := N.L + 1;
	       Insert(N.Rgt, E);
	    else
	       Insert(N.Rgt, E);
	    end if;
	 end if;
      else
	 if N.Lft = null and N.Rgt = null then
	    N.L := N.L + 1;
	    N.lft := New_Node(E);
	 elsif N.Rgt = null then
	    N.L := N.L + 1;
	    Insert(N.Lft, E);
	 elsif N.Lft = null then
	    N.Lft := New_Node(E);
	 else
	    if N.Rgt.L <= N.Lft.L then
	       N.L := N.L + 1;
	       Insert(N.Lft, E);
	    else
	       Insert(N.Lft, E);
	    end if;
	 end if;
      end if;
   end Insert;
   
   
end Tree;
