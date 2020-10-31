package Tree
  with Spark_Mode => On 
is
   type Int is range -2048..2048;
   type Int_P is not null access Int;
   
   type Arr is array (Positive range <>) of Int;
   subtype Level is Natural range 0..10;
   
   type Node;
   
   type Node_P is access Node;
   
   type Node is record
      L : Level := 0;
      D : Int := 0;
      Lft : Node_P := null;
      Rgt : Node_P := null;
   end record
   with Dynamic_Predicate => (if Node.Lft /= null then Node.Lft.L < Node.L) and
			     (if Node.Rgt /= null then Node.Rgt.L < Node.L);
   
   function Collect(N : in Node) return Arr
   with
     Post =>  Collect'Result'Length <= 2 ** (N.L + 1) - 1;
   
   procedure Insert(N : in not null Node_P; E : Int)
   with 
     Pre => N.L < Level'Last,
     Post => N.L'Old + 1 >= N.L;

   
   
   function New_Node(D : Int) return Node_P
   with 
     Post => New_Node'Result.D = D and 
	     New_Node'Result.L = 0 and
	     New_Node'Result.Lft = null and
	     New_Node'Result.Rgt = null;
   
end Tree;

