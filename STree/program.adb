with Ada.Text_IO; use Ada.Text_IO;

procedure Program 
  with Spark_Mode => On   
is
   type Int is range -2048..2048;
   
   package Int_Io is new Ada.Text_IO.Integer_IO(Int);
   use Int_Io;
   
   type Arr is array (Positive range <>) of Int;
   
   type Element_Idx is range 0..2048;
   subtype Element_Idx_In_Set is Element_Idx range 1..2048;
   subtype Element_Count is Element_Idx;
   
   type Node is record
      Set : Boolean := False;
      D : Int;
      C : Element_Idx := 0;
      L : Element_Idx;
      R : Element_Idx;
   end record;
   --with Dynamic_Predicate => (if not Node.Set then C = 0);
   
   type Node_Set is array (Element_Idx) of Node;
   
   type Tree is record
      Data : Node_Set := (others => (Set => False, L => 0, R => 0, D => 0, C => 0));
   end record
   with Dynamic_Predicate => Tree.Data(0) = (Set => False, L => 0, R => 0, D => 0, C => 0) and 
			     (for all I in Tree.Data'Range =>
				(Tree.Data(I).L = 0 or Tree.Data(I).L > I) and 
				(Tree.Data(I).R = 0 or Tree.Data(I).R > I) and
				(Tree.Data(I).C = Tree.Data(Tree.Data(I).L).C + 1 + Tree.Data(Tree.Data(I).R).C));
   
   function Count(T : in Tree) return Element_Count is
      C : Element_Count := 0;
   begin
      for I in 1..T.Data'Last loop
	 pragma Loop_Invariant(C < I);
	 if T.Data(I).Set then
	    C := C + 1;
	 end if;
      end loop;
      return C;
   end Count;
   
   function Collect(T : in Tree; Idx : in Element_Idx_In_Set) return Arr 
   with Post => Collect'Result'Length = T.Data(Idx).C
   is
      R : Node := T.Data(Idx);
      A : Arr(1..1) := (others => R.D);
      Empty : Arr(2..1) := (others => 0);
   begin
      if R.Set then
	 if R.L = 0 and R.R = 0 then -- Leaf
	    return A;
	 elsif R.L = 0 then -- only bigger children
	    return A & Collect(T, R.R);
	 elsif R.R = 0 then -- only smaller children
	    return Collect(T, R.L) & A;
	 else -- both smaller and bigger children
	    return Collect(T, R.L) & A & Collect(T, R.R);
	 end if;
      else
	 return Empty;
      end if;
   end Collect;
   
   
     
   
   
begin
   --  Put(Int(C.K));
   --  New_Line;
   --  for I in List'Range loop
   --     Put(List(I));
   --     New_Line;
   --  end loop;
   null;
end Program;
