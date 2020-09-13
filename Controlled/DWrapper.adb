with Etc; use Etc;

with Wrapper;

package body DWrapper is
   
   function Empty return DW is
   begin
      return (D => 0, Filled => False);
   end Empty;

   procedure Put(Object : in out DW; Element : in My_Int) is 
   begin
      Object.D := Element;
      Object.Filled := True;
   end Put;
   
   procedure Get(Object : in out DW; Element : out My_Int) is
   begin
      if Object.Filled then
	 Element := Object.D;
      else 
	 raise Constraint_Error;
      end if;
   end Get;

   
end DWrapper;
