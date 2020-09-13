with Ada.Finalization; use Ada.Finalization;

with Etc; use Etc;

with Wrapper;

package IWrapper is
   
   type IW is new Wrapper.W with private;
   function Empty return IW;
   procedure Put(Object : in out IW; Element : in My_Int);
   procedure Get(Object : in out IW; Element : out My_Int);
   
private
   type Int_Ptr is access My_Int;
   type Inner is new Controlled with
      record
	 Ptr : Int_Ptr;
      end record;
   
   procedure Adjust(Object : in out Inner);
   
   
   type IW is new Wrapper.W with
      record 
	 D : Inner;
	 Filled : Boolean := False;
      end record;
   
end IWrapper;
