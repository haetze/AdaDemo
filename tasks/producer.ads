with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;
use Etc.Objct;


generic 
   Init : Nums;
   Obj : access O;
package Producer is
   task Prod;
end Producer;
