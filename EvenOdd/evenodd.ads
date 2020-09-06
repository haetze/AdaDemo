with Etc; use Etc;

package Evenodd is
   subtype Pos is My_Int range 0..My_Int'Last;
   function Even(N : Pos) return Boolean;
   function Odd(N : Pos) return Boolean;
end Evenodd;


