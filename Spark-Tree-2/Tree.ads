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
      Lft : Node_P := null;
      Rgt : Node_P := null;
   end record
   with Dynamic_Predicate => (if Node.Lft /= null then Node.Lft.C + 1 <= Node.C) and
			     (if Node.Rgt /= null then Node.Rgt.C + 1 <= Node.C) and 
			     (if Node.Rgt /= null and Node.Lft /= null then Node.Rgt.C + Node.Lft.C + 1 <= Node.C);
   
   function Collect(N : in Node) return Arr
   with
     Post =>  Collect'Result'Length <= N.C;
   
   procedure Insert(N : in not null Node_P; E : in Int)
   with 
     Pre => N.C < Count'Last,
     Post => N.C'Old + 1 = N.C;
   
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
	     New_Node'Result /= null;
   
end Tree;

