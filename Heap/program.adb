with Text_IO; use Text_IO;

procedure program is
   Max : constant Integer := 256;
   subtype Idx is Integer range 0..Max;
   type Buffer is
      record
	 Data : String(1..256);
	 Start : Idx := 1;
	 Finish : Idx := 0;
      end record;
   Ptr : access Buffer;
begin
   loop
      Ptr := new Buffer; -- Creates value on the heap; memory keeps growing; no automatic mem management
   end loop; 
end program;
