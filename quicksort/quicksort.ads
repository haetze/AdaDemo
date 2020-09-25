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
      
   function Is_Sorted(A : Arr) return Boolean;
   
   procedure Sort(A : in out Arr) 
     with 
     Pre => A'Last < Integer'Last,
     Post => Is_Sorted(A);-- and A'Length = Sort'Result'Length;
   
   function Insert(A : in Arr; E : in T) return Arr
     with 
     Pre => (for all I in A'Range => 
	       (for all J in A'First .. I => A(J) <= A(I)) and 
	       (for all J in I .. A'Last => A(I) <= A(J))) and 
     A'Last < Positive'Last and A'First in Positive and A'Last in Positive,
     Post => Insert'Result'Length = A'Length + 1 and
     (for all I in Insert'Result'Range => 
     	       (for all J in Insert'Result'First .. I => Insert'Result(J) <= Insert'Result(I)) and 
     	       (for all J in I .. Insert'Result'Last => Insert'Result(I) <= Insert'Result(J)));
   
private
   
end Quicksort;

