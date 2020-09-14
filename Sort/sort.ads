with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;


package Sort is
   type Int_Array Is array (My_Int Range <>) of My_Int;
   subtype Sorted is Int_Array
     with 
     Dynamic_Predicate => Is_Sorted(Sorted);
   
   function Is_Sorted(A : in Int_Array) return Boolean;
   
   function Sort_Array(A : in Int_Array) return Sorted;
   
   procedure Print(A : in Int_Array);
   
end Sort;
