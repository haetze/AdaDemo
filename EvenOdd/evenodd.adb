package body Evenodd is
   function Even(N : Pos) return Boolean is
   begin
      if N = 0 then 
	 return True;
      else 
	 if N = 1 then
	    return False;
	 else 
	    return Odd(N-1);
	 end if;
      end if;
   end Even;
   
   function Odd(N : Pos) return Boolean is
   begin
      if N = 1 then 
	 return True;
      else 
	 if N = 0 then
	    return False;
	 else 
	    return Even(N-1);
	 end if;
      end if;
   end Odd;
   
end Evenodd;
