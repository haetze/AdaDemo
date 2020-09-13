with Ada.Text_IO, Etc, DWrapper, IWrapper;
use Ada.Text_IO, Etc, DWrapper, IWrapper;


procedure Program is
   use My_Int_IO;
   DW1 : DW;
   DW2 : DW;
   IW1 : IW;
   IW2 : IW;
   Getter : My_Int;
begin
   Put_Line("DW has all data in line.");
   Put_Line("A Copy via assignemnt therefore fully copies the information.");
   Put_Line("IW stores data via pointer, to the heap in this case.");
   Put_Line("A Copy via assignment referes to the same data because the pointer is copied.");
   Put_Line("This behaviour is illustrated in the following.");
   Put_Line("Changin one wrapper influences then the other.");
   Put_Line("You can influence the assignment in Ada via Finalization.");
   Put_Line("The assignemnt is edited via the adjust method.");
   Put_Line("A implementation is in IWrapper.adb commented out.");
   Put_Line("It creates a copy so that it is not influenced.");
   Put_Line("Initialize and Finalize are run after initial creation and Finalize before over written, respectively.");
   Put_Line("============================");
   
   Put_Line("Creating DWrapper DW1 with Value 10.");
   DW1 := Empty;
   Put(DW1, 10);
   Get(DW1, Getter);
   Put("Value in DW1: ");
   Put(Getter);
   New_Line;
   Put_Line("Copy DW1 to DW2 via assignment.");
   DW2 := DW1;
   Get(DW2, Getter);
   Put("Value in DW2: ");
   Put(Getter);
   New_Line;
   Put_Line("Changing DWrapper DW1 to 20.");
   Put(DW1, 20);
   Get(DW1, Getter);
   Put("Value in DW1: ");
   Put(Getter);
   New_Line;
   Get(DW2, Getter);
   Put("Value in DW2: ");
   Put(Getter);
   New_Line;
   
   Put_Line("============================");
   
   Put_Line("Creating IWrapper IW1 with Value 10.");
   IW1 := Empty;
   Put(IW1, 10);
   Get(IW1, Getter);
   Put("Value in IW1: ");
   Put(Getter);
   New_Line;
   Put_Line("Copy IW1 to IW2 via assignment.");
   IW2 := IW1;
   Get(IW2, Getter);
   Put("Value in IW2: ");
   Put(Getter);
   New_Line;
   Put_Line("Changing IWrapper IW1 to 20.");
   Put(IW1, 20);
   Get(IW1, Getter);
   Put("Value in IW1: ");
   Put(Getter);
   New_Line;
   Get(IW2, Getter);
   Put("Value in IW2: ");
   Put(Getter);
   New_Line;

end Program;
  
   
   
