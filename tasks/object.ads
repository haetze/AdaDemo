
generic 
   type Item is private;
package Object is
   protected type O is
      entry Put(X : in Item);
      entry Get(X : out Item);
   private
      Filled : Boolean := False;
      Obj : Item;
   end O;
end Object;
