
package Bsearch 
  with Spark_Mode => On
is
   
   type Int is range -2048..2048;
   
   type Arr is array (Positive range <>) of Int;
   
   function Sorted(A : in Arr) return Boolean
   with Inline;
   
   
   procedure Search(A : in Arr; E : in Int; Found : out Boolean; Idx : out Positive)
   with
     Global => null,
     Depends => (Found => (A, E), Idx => (A, E)),
     Pre => Sorted(A) and A'First in Positive and A'Last in Positive,
     Post => (if Found then A(Idx) = E) 
	     and (if not Found then 
		    (for all I in A'Range => A(I) /= E));
   
   
   
private
   
   function Sorted(A : in Arr) return Boolean is
     (for all I in A'Range =>
	(for all J in A'First .. I => A(J) <= A(I)) and
	(for all J in I .. A'Last => A(I) <= A(J)));
   
   
end Bsearch;

