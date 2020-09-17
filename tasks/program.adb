with Ada.Text_IO, Etc, Producer;
use Ada.Text_IO, Etc;


procedure Program is
   use Objct;
   
   Obj : access O := new O;
   
   package Prod_0 is new Producer(0, Obj);
   package Prod_1 is new Producer(1, Obj);
   package Prod_2 is new Producer(2, Obj);
   package Prod_3 is new Producer(3, Obj);
   package Prod_4 is new Producer(4, Obj);
   package Prod_5 is new Producer(5, Obj);
   package Prod_6 is new Producer(6, Obj);
   package Prod_7 is new Producer(7, Obj);
   package Prod_8 is new Producer(8, Obj);
   package Prod_9 is new Producer(9, Obj);
   
   
   
   Get : Nums;
begin
   Put_Line("Started main");
   loop
      Put_Line("Trying to get Number");
      Obj.Get(Get);
      Put("Got Number ");
      Put(Get'Image);
      New_Line;
   end loop;
end Program;
  
   
   
