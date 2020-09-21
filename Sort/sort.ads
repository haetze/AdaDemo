with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;


package Sort is
   type Int_Array Is array (My_Int Range <>) of My_Int;
   subtype Sorted is Int_Array
     with 
     Dynamic_Predicate => Is_Sorted(Sorted);
   
   function Is_Sorted(A : in Int_Array) return Boolean;
   
   function Sort_Array(A : in Int_Array) return Sorted;
   
   function Merge(A : in Sorted; B : in Sorted) return Sorted
     with Post => Merge'Result'Length = A'Length + B'Length;
   
   procedure Print(A : in Int_Array);
   
end Sort;
