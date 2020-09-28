package body Prime is
   
   function Smaller_Prime(N : in Positive) return Positive is
      R : Positive := N - 1;
   begin
      while not Is_Prime(R) loop
	R := R - 1;
      end loop;
      return R;
   end Smaller_Prime;
   
end Prime;

