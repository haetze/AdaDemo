generic 
   type T is range <>;
package Bubblesort 
is
   
   type Arr is array (Positive range <>) of T;
   
   function Is_Sorted(A : in Arr) return Boolean
   with Inline;
   
   procedure Sort(A : in out Arr) 
     with 
     Pre => A'Last in Positive and
	    A'First in Positive,
     Post => Is_Sorted(A);
   
   
private
   
end Bubblesort;

