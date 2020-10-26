with Ada.Text_IO; use Ada.Text_IO;


procedure Program 
  with Spark_Mode => On   
is
   type Int is range -2048..2048;
   type Int_P is not null access Int;
   
   function F(A : Int_P) return Int 
   with 
     Pre => A.all <= 1024 and then A.all >= -1024,
     Post => F'Result = A.all + A.all 
   is
   begin
      return A.all*2;
   end F;
   

   X_P : Int_P := new Int'(10);
   Y : Int := F(X_P);
   pragma Assert(Y = X_P.all * 2);
begin
   Put_Line("Hello, World!");
end Program;
