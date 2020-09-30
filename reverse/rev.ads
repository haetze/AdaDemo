generic
   type T is private;
   type Arr is array (Positive range <>) of T;
package Rev is
   
   function Reversed(A : in Arr; B : in Arr) return Boolean
     with 
     Inline,
     Pre => A'First in Positive 
     and A'Last in Positive 
     and B'Last in Positive
     and B'First in Positive
     and A'Length = B'Length;
   
   function Reverser(A : in Arr) return Arr
     with 
     Pre => A'First in Positive 
     and A'Last in Positive,
     Post => Reverser'Result'First = A'First
     and Reverser'Result'Last = A'Last
     and Reversed(A, Reverser'Result);
   
private 
   
end Rev;
