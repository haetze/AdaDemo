
package body Object is
   protected body O is
      
      entry Put(X : in Item) when not Filled is
      begin
	 Obj := X;
	 Filled := True;
      end Put;
      
      entry Get(X : out Item) when Filled is
      begin
	 X := Obj;
	 Filled := False;
      end Get;
      
   end O;
end Object;
