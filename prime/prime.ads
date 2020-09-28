package Prime is
   
   function Is_Prime(N : in Positive) return Boolean 
     with 
     Inline;
   
   function Smaller_Prime(N : in Positive) return Positive
     with 
     Pre => not Is_Prime(N) and N > 1,
     Post => Is_Prime(Smaller_Prime'Result) 
     and Smaller_Prime'Result < N;
   
   
private
   
   function Is_Prime(N : in Positive) return Boolean is
      (N > 1 and then (for all I in 2..N - 1 => N rem I /= 0));
      
   
end Prime;

