with Ada.Text_IO; use Ada.Text_IO;


procedure Program 
  with Spark_Mode => On   
is
   type Int is range -2048..2048;
   type Int_P is not null access Int;
   
   package Int_Io is new Ada.Text_IO.Integer_IO(Int);
   use Int_Io;
   
   subtype Element_Idx is Natural range 0..2048; 
   
   
   type Arr is array (Element_Idx range <>) of Int;
   
   type Node;
   
   --type Node_P is access all Node;
   

   C : Element_Idx := 0;
   
   type Node is record
      S : Boolean := False;
      D : Int := 0;
      L : Element_Idx := 0;
      R : Element_Idx := 0;
   end record;
   
   type Node_Arr is array (Element_Idx) of Node;
   
   T : Node_Arr;
   
   
   function Count return Natural 
   is (C);
   
   procedure Insert(N : in Element_Idx; E : in Int) 
   with
     Pre => C < Element_Idx'Last,
     Post => C'Old + 1 >= C 
   is
   begin
      if not T(N).S then
	 T(N).S := True;
	 T(N).D := E;
	 C := C + 1;
      else
	 if T(N).D < E then
	    if T(N).R = 0 then
	       T(N).R := C;
	       Insert(T(N).R, E);
	    else
	       Insert(T(N).R, E);
	    end if;
	 else
	    if T(N).L = 0 then
	       T(N).L := C;
	       Insert(T(N).L, E);
	    else
	       Insert(T(N).L, E);
	    end if;
	 end if;
      end if;
   end Insert;
   
   A : Arr := (5,4,3,2,1);
   R : Element_Idx := 0;
   
   procedure Insert(A : in Arr) 
   with 
     Pre => A'Length + C < Element_Idx'Last
   is
   begin
      for I in A'Range loop
	 pragma Assume(C + (I - A'First) < Element_Idx'Last);
	 Insert(R, A(I));
      end loop;
   end Insert;
   
   procedure Print_In_Order(N : in Element_Idx) 
   is
   begin
      if not T(N).S then
	 return;
      else
	 if T(N).L /= 0 then
	    Print_In_Order(T(N).L);
	 end if;
	 Put(T(N).D);
	 New_Line;
	 if T(N).R /= 0 then
	    Print_In_Order(T(N).R);
	 end if;
      end if;
   end Print_In_Order;
   
   procedure Print_In_Order
   is
   begin
      Print_In_Order(R);
   end Print_In_Order;
   
      
   
   
begin
   Insert(A);
   Print_In_Order;
   null;
end Program;
