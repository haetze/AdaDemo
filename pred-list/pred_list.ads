

generic
   type T is private;
   type Arr is array(Positive range <>) of T;
   with function P(E : in T) return Boolean;
package Pred_List is
   
   
   function Filter(A : in Arr) return Arr
   with
     Pre => A'First in Positive and A'Last in Positive,
     Post => (for all I in Filter'Result'Range => P(Filter'Result(I))) and
	     (Filter'Result'Length <= A'Length) and
	     (for all I in A'Range =>
		(for some J in Filter'Result'Range => A(I) = Filter'Result(J)) or
		not P(A(I)));
   
end Pred_List;
