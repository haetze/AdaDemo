with Etc; use Etc;

package Wrapper is
   type W is interface;
   
   function Empty return W is abstract;
   procedure Put(Object : in out W; Element : in My_Int) is abstract;
   procedure Get(Object : in out W; Element : out My_Int) is abstract;
   procedure Trans(From : in W'Class; To : out W'Class); 
end Wrapper;
