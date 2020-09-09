with Ada.Text_IO; use Ada.Text_IO;
with P; use P;

procedure Program is
   
   function G(X : A) return String is
   begin
      return 'G' & F(X);
   end G;
   
   function H(X : A'Class) return String is
   begin 
      return 'H' & F(X);
   end H;
   
   E : B;
   E2 : A;
		
begin
   Put(G(A(E))); -- requires conversion and statically decides to use F(X : in A)
   Put(H(E)); -- no conversion and dinamically decides to use the function
   Put(H(E2)); -- no conversion and dinamically decides to use the function
end Program;
