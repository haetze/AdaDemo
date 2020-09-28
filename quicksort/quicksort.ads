generic 
   type T is range <>;
package Quicksort 
is
   
   type Arr is array (Positive range <>) of T;
   
   type P(L_LE : Natural; L_G : Natural) is record
      LE : Arr(1..L_LE);
      P : T;
      G : Arr(1..L_G);
   end record;
   
   function Split(A : in Arr) return P
     with 
     Global => null,
     Depends => (Split'Result => A),
     Pre => A'First < Integer'Last,
     Post => (for all I in Split'Result.LE'Range => Split'Result.LE(I) <= Split'Result.P) 
     and then (for all I in Split'Result.G'Range => Split'Result.G(I) > Split'Result.P)
     and then A'Length >= Split'Result.LE'Length and then A'Length >= Split'Result.G'Length 
     and then (A'Length = Split'Result.LE'Length + Split'Result.G'Length + 1
		 or else A'Length = 0)
     and then (Split'Result.LE'Length = 0 or else Split'Result.LE'First in Positive)
     and then (Split'Result.G'Length = 0 or else Split'Result.G'First in Positive);
     --  and then (for all I in A'Range => (Split'Result.P = A(I)) or else
     --  		 (for Some K in Split'Result.LE'Range => A(I) = Split'Result.LE(K)) or else
     --  		 (for Some K in Split'Result.G'Range => A(I) = Split'Result.G(K)));
   
      
   function Is_Sorted(A : Arr) return Boolean
     with Inline;
   
   procedure Sort(A : in out Arr) 
     with 
     Pre => A'Last < Integer'Last,
     Post => Is_Sorted(A);-- and A'Length = Sort'Result'Length;
   
   function Insert(A : in Arr; E : in T) return Arr
     with 
     Pre => Is_Sorted(A) and
     A'Last < Positive'Last and 
     A'First in Positive and 
     A'Last in Positive,
     Post => Insert'Result'Length = A'Length + 1 and
     Is_Sorted(Insert'Result);
   
   function Insertion_Sort(A : in Arr) return Arr
     with
     Pre => A'First < Positive'Last 
     and A'Last < Positive'Last 
     and A'First in Positive 
     and A'Last in Positive,
     Post => Insertion_Sort'Result'Length = A'Length 
     and Is_Sorted(Insertion_Sort'Result);

private
   
end Quicksort;

