package Tree
  with Spark_Mode => On 
is
   type Int is range -2048..2048;
   type Int_P is not null access Int;
   
   type Arr is array (Positive range <>) of Int;
   subtype Count is Natural range 1..2048;
   
   type Node;
   
   type Node_P is access Node;
   
   
   type Node is record
      C : Count := 1;
      D : Int := 0;
      Max : Int := 0;
      Min : Int := 0;
      Lft : Node_P := null;
      Rgt : Node_P := null;
   end record
   with Dynamic_Predicate => (if Node.Lft /= null then Node.Lft.C + 1 <= Node.C) and
			     (if Node.Rgt /= null then Node.Rgt.C + 1 <= Node.C) and 
			     (if Node.Rgt /= null and Node.Lft /= null then Node.Rgt.C + Node.Lft.C + 1 <= Node.C) and
			     Node.D <= Node.Max and
			     Node.D >= Node.Min and
			     (if Node.Rgt /= null then Node.Rgt.Max <= Node.Max) and
			     (if Node.Rgt /= null then Node.Rgt.Min >= Node.Min) and
			     (if Node.Lft /= null then Node.Lft.Max <= Node.Max) and
			     (if Node.Lft /= null then Node.Lft.Min >= Node.Min) and
			     (if Node.Rgt /= null then Node.Rgt.Min >= Node.D) and
			     (if Node.Lft /= null then Node.Lft.Max <= Node.D);
   
   function Contained(N : in Node_P; E : in Int) return Boolean
   is (if N /= null then N.D = E or Contained(N.Lft, E) or Contained(N.Rgt, E) else False)
     with
       Inline;

   
   function Collect(N : in Node) return Arr
   with
     Post =>  Collect'Result'Length <= N.C and
	      (for all I in Collect'Result'Range => Collect'Result(I) <= N.Max) and
	      (for all I in Collect'Result'Range => Collect'Result(I) >= N.Min) and
	      (for all I in Collect'Result'Range =>
		 (for all J in Collect'Result'First .. I => Collect'Result(J) <= Collect'Result(I)) and
		 (for all J in I .. Collect'Result'Last => Collect'Result(I) <= Collect'Result(J)));
   
   procedure Insert(N : in not null Node_P; E : in Int)
   with 
     Pre => N.C < Count'Last,
     Post => N.C'Old + 1 = N.C and 
	     (N.Min'Old = N.Min or (if N.Min'Old > E then E = N.Min else False)) and
	     (N.Max'Old = N.Max or (if N.Max'Old < E then E = N.Max else False)) and
	     Contained(N, E);
   
   procedure Insert(N : in not null Node_P; A : in Arr)
   with
     Pre => A'Length <= Count'Last - N.C,
     Post => N.C'Old + A'Length = N.C;
   
   function Insert(A : in Arr) return Node_P
   with
     Pre => A'Length <= Count'Last,
     Post => (if Insert'Result /= null then Insert'Result.C = A'Length);


   function New_Node(D : Int) return Node_P
   with 
     Post => New_Node'Result.D = D and 
	     New_Node'Result.C = 1 and
	     New_Node'Result.Lft = null and
	     New_Node'Result.Rgt = null and
	     New_Node'Result.Max = D and
	     New_Node'Result.Min = D and
	     Contained(New_Node'Result, D) and
	     New_Node'Result /= null;
   
end Tree;

