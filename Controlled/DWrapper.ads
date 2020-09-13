with Etc; use Etc;

with Wrapper;

package DWrapper is
   
   type DW is new Wrapper.W with private;
   function Empty return DW;
   procedure Put(Object : in out DW; Element : in My_Int);
   procedure Get(Object : in out DW; Element : out My_Int);
   
private
   type DW is new Wrapper.W with
      record 
	 D : My_Int;
	 Filled : Boolean := False;
      end record;
end DWrapper;
