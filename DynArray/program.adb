with Ada.Text_IO, Etc;
use Ada.Text_IO, Etc;

procedure Program is
   use My_Float_IO, My_Int_IO, My_Elementary_Functions;
   N : My_Int;
begin
   Put("Size of Array:");
   Get(N);
   declare
      type Arr_T is array (0..N-1) of My_Int;
      A : Arr_T := (0..N-1 => 0);
   begin
      for I in Arr_T'Range loop
	 A(I) := I;
      end loop;
      Put("A[Index] = Element");
      for I in Arr_T'Range loop
	 New_Line;
	 Put("A[");
	 Put(I);
	 Put("] = ");
	 Put(A(I));
      end loop;
   end;
end Program;
