with Ada.Text_IO; use Ada.Text_IO;

procedure Program 
  with Spark_Mode => On   
is
   type Int is range -2048..2048;
   type Arr is array (Positive range <>) of Int;
   subtype Elements is Natural range 0..2048;
   type Kind is range 0..2;
   
   type Tree;
   
   type Tree_P is not null access Tree;
   for Tree_P'Storage_Size use 2048;
   
   type Tree(K : Kind) is 
      record
	 Number_Of_Elements : Elements;
	 case K is
	    when 0 =>
	       null;
	    when 1 =>
	       D : Int;
	    when 2  =>
	       E : Int;
	       L : Tree_P;
	       R : Tree_P;
	 end case;
      end record
   with Dynamic_Predicate => (if Tree.K = 0 then Tree.Number_Of_Elements = 0) and 
			     (if Tree.K = 1 then Tree.Number_Of_Elements = 1) and 
			     (if Tree.K = 2 
			      then Tree.Number_Of_Elements = 1 + Tree.L.Number_Of_Elements + Tree.R.Number_Of_Elements);
				 
   
   
   function Collect(T : Tree) return Arr 
   with
     Post => Collect'Result'Length = T.Number_Of_Elements
   is
      Empty : Arr(2..1) := (others => 0);
   begin
      case T.K is
	 when 0 => 
	    return Empty;
	 when 1 => 
	    return (1 => T.D);
	 when 2 => 
	    declare
	       A : Arr(1..T.Number_Of_Elements) := (others => 0);
	    begin
	       A(1..T.L.Number_Of_Elements) := Collect(T.L.all);
	       A(T.L.Number_Of_Elements + 1) := T.E;
	       A(T.L.Number_Of_Elements + 2 .. T.Number_Of_Elements) := Collect(T.R.all);
	       return A;
	    end;
      end case;	 
   end Collect;
   
   function All_Smaller(T : in Tree; E : in Int) return Boolean is
     (case T.K is
	 when 0 => True,
	 when 1 => T.D <= E,
	 when 2 => All_Smaller(T.L.all, E) and All_Smaller(T.R.all, E) and T.E <= E);
   
   function All_Bigger(T : in Tree; E : in Int) return Boolean is
     (case T.K is
	 when 0 => True,
	 when 1 => T.D >= E,
	 when 2 => All_Bigger(T.L.all, E) and All_Bigger(T.R.all, E) and T.E >= E);

   
   subtype Stree is Tree
   with Dynamic_Predicate => (if Stree.K = 2 
			      then All_Smaller(Stree.L.all, Stree.E) 
				 and All_Bigger(Stree.R.all, Stree.E) 
				 and Stree.R.all in Stree 
				 and Stree.L.all in Stree);
   
   function Insert(T : in Stree; E : in Int) return Stree
   with 
     Pre => T.Number_Of_Elements < Elements'Last,
     Post => T.Number_Of_Elements + 1 = Insert'Result.Number_Of_Elements 
   is
   begin
      case T.K is
	 when 0 =>
	    return (K => 1,
		    Number_Of_Elements => 1,
		    D => E);
	 when 1 =>
	    if T.D < E then
	       return (K => 2,
		       Number_Of_Elements => 2,
		       E => T.D,
		       L => new Stree'(K => 0,
				       Number_Of_Elements => 0),
		       R => new Stree'(K => 1,
				       Number_Of_Elements => 1,
				       D => E));
	    else
	       return (K => 2,
		       Number_Of_Elements => 2,
		       E => T.D,
		       L => new Stree'(K => 1,
				       Number_Of_Elements => 1,
				       D => E),
		       R => new Stree'(K => 0,
				       Number_Of_Elements => 0));
	    end if;
	 when 2 =>
	    if T.D < E then
	       declare
		  N_R : Stree := Insert(T.R.all, E);
		  N_T : Stree := (K => 2,
				  Number_Of_Elements => T.Number_Of_Elements + 1,
				  E => T.E,
				  L => T.L,
				  R => new Stree'(N_R));
	       begin
		  return N_T;
	       end;
	    else
	       declare
		  N_L : Stree := Insert(T.L.all, E);
		  N_T : Stree := (K => 2,
				  Number_Of_Elements => T.Number_Of_Elements + 1,
				  E => T.E,
				  R => T.R,
				  L => new Stree'(N_L));
	       begin
		  return N_T;
	       end;
	    end if;
      end case;
   end Insert;
   
   
   package Int_Io is new Ada.Text_IO.Integer_IO(Int);
   use Int_Io;
   
   A : Stree := (K => 0,
		 Number_Of_Elements => 0);
   B : Stree := Insert(A, 5);
   C : Stree := Insert(B, 4);
   --  D : Stree := Insert(C, 3);
   --  E : Stree := Insert(D, 2);
   --  F : Stree := Insert(E, 1);
   List : Arr := Collect(C);
begin
   Put(Int(C.K));
   New_Line;
   for I in List'Range loop
      Put(List(I));
      New_Line;
   end loop;
end Program;
