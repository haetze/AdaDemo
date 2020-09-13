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
   Put_Line(G(A(E))); -- requires conversion and statically decides to use F(X : in A)
   Put_Line(G(E2)); -- requires conversion and statically decides to use F(X : in A)
   Put_Line(H(E)); -- no conversion and dynamically decides to use the function
   Put_Line(H(E2)); -- no conversion and dynamically decides to use the function
end Program;
