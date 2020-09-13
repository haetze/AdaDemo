with Ada.Finalization; use Ada.Finalization;

with Etc; use Etc;

with Wrapper;

package body IWrapper is
   
   function Empty return IW is
      I : Inner;
      E : IW;
   begin
      I.Ptr := new My_Int'(0);
      E.D := I;
      E.Filled := False;
      return E;
   end Empty;

   procedure Put(Object : in out IW; Element : in My_Int) is 
   begin
      Object.D.Ptr.all := Element;
      Object.Filled := True;
   end Put;
   
   procedure Get(Object : in out IW; Element : out My_Int) is
   begin
      if Object.Filled then
	 Element := Object.D.Ptr.all;
      else 
	 raise Constraint_Error;
      end if;
   end Get;
   
   function Copy(Ptr : Int_Ptr) return Int_Ptr is
   begin 
      if Ptr = null then
	 return null;
      else 
	 return new My_Int'(Ptr.all);
      end if;
   end Copy;

   
   --  procedure Adjust(Object : in out Inner) is 
   --  begin 
   --     Object.Ptr := Copy(Object.Ptr);
   --  end Adjust;
   procedure Adjust(Object : in out Inner) is null;
   
end IWrapper;
