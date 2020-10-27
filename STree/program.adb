with Ada.Text_IO; use Ada.Text_IO;

procedure Program 
  with Spark_Mode => On   
is
   type Int is range -2048..2048;
   type Arr is array (Positive range <>) of Int;
   subtype Elements is Natural range 0..2048;
   
   type Tree;
   
   type Tree_P is not null access Tree;
   
   type Tree(Number_Of_Elements : Elements) is 
      record
	 case Number_Of_Elements is
	    when 0 =>
	       null;
	    when 1 =>
	       D : Int;
	    when 2..Elements'Last =>
	       E : Int;
	       L : Tree_P;
	       R : Tree_P;
	 end case;
      end record
   with Dynamic_Predicate => (if Tree.Number_Of_Elements > 1 
			      then Tree.Number_Of_Elements = 1 + Tree.L.Number_Of_Elements + Tree.R.Number_Of_Elements);
				 
   
   
   function Collect(T : Tree) return Arr 
   with
     Post => Collect'Result'Length = T.Number_Of_Elements
   is
      Empty : Arr(2..1) := (others => 0);
   begin
      if T.Number_Of_Elements = 0 then
	 return Empty;
      elsif T.Number_Of_Elements = 1 then
	 return (1 => T.D);
      else
	 declare
	    A : Arr(1..T.Number_Of_Elements) := (others => 0);
	 begin
	    A(1..T.L.Number_Of_Elements) := Collect(T.L.all);
	    A(T.L.Number_Of_Elements + 1) := T.E;
	    A(T.L.Number_Of_Elements + 2 .. T.Number_Of_Elements) := Collect(T.R.all);
	    return A;
	 end;
      end if;	 
   end Collect;
      
   
begin
   Put_Line("Hello, World!");
end Program;
