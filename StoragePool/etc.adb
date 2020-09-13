with Ada.Text_IO;
use Ada.Text_IO;

package body Etc is
   procedure Pause is
      N : Character;
   begin
      loop
	 Get_Immediate(N);
	 exit when N = Character'Val(10);
      end loop;
   end Pause;
end Etc;
