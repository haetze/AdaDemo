with Etc; use Etc;

package Stack is
   pragma Assertion_Policy(Check);
   
   type Stack_T is private
     with 
     Type_Invariant => not Has_Dups(Stack_T);
   
   
   function Empty return Stack_T;
   procedure Push(S : in out Stack_T; E : in My_Int)
     with 
     Pre => not Is_Full(S),
     Post => not Is_Empty(S);
   function Pop(S : in out Stack_T) return My_Int
     with 
     Pre => not Is_Empty(S),
     Post => not Is_Full(S);
   function Is_Empty(S : in Stack_T) return Boolean;
   function Is_Full(S : in Stack_T) return Boolean;
   function Has_Dups(S : in Stack_T) return Boolean;
   
private
   Size : constant My_Int := 10;
   type Index is range 0..Size-1;
   type Stack_S is array (Index) of My_Int;
   
   type Stack_T is 
      record
	 Top : Index := 0;
	 Data : Stack_S := (others => 0);
      end record;
   
end Stack;
