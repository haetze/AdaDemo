with Etc; use Etc;

package P is
   type A is tagged 
      record 
	 D : My_Int := 0;
      end record;
   
   function F(X : A) return Character;
   
   type B is new A with
      record
	 null;
      end record;
   
   function F(X : B) return Character;
end P;
