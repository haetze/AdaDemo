with Ada.Text_IO, Etc, System.Pool_Local;
use Ada.Text_IO, Etc;

package body Buffer is
   
   procedure Create_Mem is
      Pool : System.Pool_Local.Unbounded_Reclaim_Pool; -- This pool reclaims it memory when it leaves the scope
						       -- So after exiting this procedure the memory is reclaimed
      type Buffer is array (-2048..2048) of My_Int;
      type Buffer_Ptr is access Buffer;
      for Buffer_Ptr'Storage_pool use Pool; 

      C : My_Int := -2048;
      Ptr : Buffer_Ptr;
   begin
      loop
	 C := C + 1;
	 Ptr := new Buffer'(-2048..2048 => 0);
	 exit when C = 2048;
      end loop;
      Put_Line("Press Enter to Continue.");
      Pause;
   end Create_Mem;
   
end Buffer;
