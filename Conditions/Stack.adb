with Etc; use Etc;


package body Stack is
   use My_Int_IO, My_Elementary_Functions;
   
   function Empty return Stack_T is
      S : Stack_T;
   begin
      return S;
   end Empty;

   procedure Push(S : in out Stack_T; E : in My_Int) is
   begin
      S.Data(S.Top) := E;
      S.Top := S.Top + 1;    -- Comment out to see Post condition in action
   end Push;
   
   function Pop(S : in out Stack_T) return My_Int is
      New_Top : Index := S.Top - 1;
      E : My_Int := S.Data(New_Top);
   begin
      S.Top := New_Top;
      return E;
   end Pop;
   
   function Is_Empty(S : in Stack_T) return Boolean is
   begin
      return S.Top = 0;
   end Is_Empty;
   
   function Is_Full(S : in Stack_T) return Boolean is
   begin
      return S.Top = Index'Last;
   end Is_Full;

   
   function Has_Dups(S : in Stack_T) return Boolean is
      Set : array (My_Int'Range) of Boolean := (others => False);
      E : My_Int;
   begin
      for I in 0..S.Top loop
	 E := S.Data(I);
	 if Set(E) then
	    return True;
	 else 
	    Set(E) := True;
	 end if;
      end loop;
      return False;
   end Has_Dups;
   
   
   
end Stack;
