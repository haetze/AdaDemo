with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use  Ada.Integer_Text_IO;

procedure program is
   subtype RNG is Integer range 0..10;
   X : RNG;
   Y : RNG;
begin
   Put("Y : "); -- crashes on number out of range; no warning given
   Get(Y);
   X := Y + 6;
   Put("Y + 6 = ");
   Put(X);
end program;
