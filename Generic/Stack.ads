with Etc; use Etc;

generic 
   type Item is private;
   Size : Positive;
   
package Stack is
   pragma Assertion_Policy(Check);
   
   type Stack_T is private
     with 
     Type_Invariant => not Has_Dups(Stack_T);
   
   
   function Empty return Stack_T;
   procedure Push(S : in out Stack_T; E : in Item)
     with 
     Pre => not Is_Full(S),
     Post => not Is_Empty(S);
   function Pop(S : in out Stack_T) return Item
     with 
     Pre => not Is_Empty(S),
     Post => not Is_Full(S);
   function Is_Empty(S : in Stack_T) return Boolean;
   function Is_Full(S : in Stack_T) return Boolean;
   function Has_Dups(S : in Stack_T) return Boolean;
   
private
   type Stack_S is array (1..Size) of Item;
   
   type Stack_T is 
      record
	 Top : Positive range 1..Size+1 := 1;
	 Data : Stack_S;
      end record;
   
end Stack;
