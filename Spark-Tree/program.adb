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
   


   
   type Node is record
      S : Boolean := False;
      D : Int := 0;
      L : Element_Idx := 0;
      R : Element_Idx := 0;
   end record;
   
   type Node_Arr is array (Element_Idx) of Node;
   
   type Tree is record
      T : Node_Arr;
      C : Element_Idx := 0;
   end record;
   
   
   function Count(T : Tree) return Natural 
   is (T.C);
   
   procedure Insert(T : in out Tree; N : in Element_Idx; E : in Int) 
   with
     Pre => T.C < Element_Idx'Last,
     Post => T'Old.C = T.C or T'Old.C + 1 = T.C
   is
   begin
      if not T.T(N).S then
	 T.T(N).S := True;
	 T.T(N).D := E;
	 T.C := T.C + 1;
      else
	 if T.T(N).D < E then
	    if T.T(N).R = 0 then
	       T.T(N).R := T.C;
	       Insert(T, T.T(N).R, E);
	    else
	       Insert(T, T.T(N).R, E);
	    end if;
	 else
	    if T.T(N).L = 0 then
	       T.T(N).L := T.C;
	       Insert(T, T.T(N).L, E);
	    else
	       Insert(T, T.T(N).L, E);
	    end if;
	 end if;
      end if;
   end Insert;
   
   A : Arr := (5,4,3,2,1);
   R : Element_Idx := 0;
   
   procedure Insert(T : in out Tree; A : in Arr) 
   with 
     Pre => A'Length + T.C < Element_Idx'Last
   is
      
      C : Element_Idx := T.C;
      C2 : constant Element_Idx := T.C;
      C3 : Natural := 0;
   begin
      for I in A'Range loop
	 pragma Loop_Invariant(C = T.C or C + 1 = T.C);
	 pragma Loop_Invariant(C3 = I - A'First);
	 pragma Loop_Invariant(T.C <= C2 + C3);
	 C := T.C;
	 C3 := C3 + 1;
	 Insert(T, R, A(I));
      end loop;
   end Insert;
   
   procedure Print_In_Order(T : in Tree; N : in Element_Idx) 
   is
   begin
      if not T.T(N).S then
	 return;
      else
	 if T.T(N).L /= 0 then
	    Print_In_Order(T, T.T(N).L);
	 end if;
	 Put(T.T(N).D);
	 New_Line;
	 if T.T(N).R /= 0 then
	    Print_In_Order(T, T.T(N).R);
	 end if;
      end if;
   end Print_In_Order;
   
   procedure Print_In_Order(T : in Tree)
   is
   begin
      Print_In_Order(T, R);
   end Print_In_Order;
   
      
   M_T : Tree;
   
begin
   Insert(M_T,A);
   Print_In_Order(M_T);
   null;
end Program;
