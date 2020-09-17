package body Producer is
   task body Prod is
      I : Nums := Init;
   begin
      loop
	 Put("Trying to put number from Producer ");
	 Put_Line(Init'Image);
	 Obj.Put(I);
	 Put("Number was put from Producer ");
	 Put_Line(Init'Image);
	 I := I + 10;
      end loop;
   end Prod;
end Producer;
