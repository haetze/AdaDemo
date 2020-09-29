package Prime 
  with Spark_Mode => On
is
   
   type Prime_Arr is array (Positive range <>) of Positive
     with Dynamic_Predicate => (for all I in Prime_Arr'Range =>
				  Is_Prime(Prime_Arr(I)));
   
   function Is_Prime(N : in Positive) return Boolean 
     with 
     Inline;
   
   function Smaller_Prime(N : in Positive) return Positive
     with 
     Pre => not Is_Prime(N) and N > 1,
     Post => Is_Prime(Smaller_Prime'Result) 
     and Smaller_Prime'Result < N;
   
   function Number_Of_Primes(N : in Positive) return Natural
     with Post => Number_Of_Primes'Result < N;
   
   function Primes_Til(N : in Positive) return Prime_Arr
     with Post => Primes_Til'Result'Length < N;
   
private
   
   function Is_Prime(N : in Positive) return Boolean is
      (N > 1 and then (for all I in 2..N - 1 => N rem I /= 0));
      
   
end Prime;

