with Etc; use Etc;


package body Stack is
   use My_Int_IO, My_Elementary_Functions;
   
   function Empty return Stack_T is
      S : Stack_T;
   begin
      return S;
   end Empty;

   procedure Push(S : in out Stack_T; E : in Item) is
   begin
      S.Data(S.Top) := E;
      S.Top := S.Top + 1;    -- Comment out to see Post condition in action
   end Push;
   
   function Pop(S : in out Stack_T) return Item is
      New_Top : Positive range 1..Size := S.Top - 1;
      E : Item := S.Data(New_Top);
   begin
      S.Top := New_Top;
      return E;
   end Pop;
   
   function Is_Empty(S : in Stack_T) return Boolean is
   begin
      return S.Top = 1;
   end Is_Empty;
   
   function Is_Full(S : in Stack_T) return Boolean is
   begin
      return S.Top = Size + 1;
   end Is_Full;

   
   function Has_Dups(S : in Stack_T) return Boolean is
      E : Item;
      F : Item;
   begin
      for I in 1..S.Top - 1 loop
	 E := S.Data(I);
	 for J in 1..S.Top - 1 loop
	    F := S.Data(J);
	    if I /= J and E = F then
	       return True;
	    end if;
	 end loop;
      end loop;
      return False;
   end Has_Dups;
   
   
   
end Stack;
