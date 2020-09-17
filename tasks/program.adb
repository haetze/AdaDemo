with Ada.Text_IO, Ada.Calendar, Etc, Producer;
use Ada.Text_IO, Ada.Calendar, Etc;


procedure Program is
   use Objct;
   
   Obj : access O := new O;
   N : Nums range 0..9 := 2;
   
   task type Producer(Init : Nums);   
   task body Producer is
      I : Nums := Init;
   begin
      loop
	 Put("Trying to put number from Producer ");
	 Put_Line(Init'Image);
	 Obj.Put(I);
	 Put("Number was put from Producer ");
	 Put_Line(Init'Image);
	 I := I + 10;
	 delay 10.0;
      end loop;
   end Producer;
   
   type Producer_Arr is array (0..N) of access Producer;
   
   function Prod_A return Producer_Arr is
      A : Producer_Arr;
   begin
      for I in Producer_Arr'Range loop
	 A(I) := new Producer(I);
      end loop;
      return A;
   end Prod_A;
   
   Ps : Producer_Arr := Prod_A;
   
      
   
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
  
   
   
