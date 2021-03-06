with Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;
with Object;

package Etc is 
   type My_Float is digits 7;
   type My_Int is range -2048..2048; -- 2^11
   type Nums is mod 1024;   
   
   package My_Float_IO is new Ada.Text_IO.Float_IO(My_Float);
   package My_Int_IO is new Ada.Text_IO.Integer_IO(My_Int);
   
   package My_Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions(My_Float);
   
   package Objct is new Object(Nums);
end Etc; 
