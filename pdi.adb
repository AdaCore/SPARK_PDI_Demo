with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package body PDI
  with SPARK_Mode => Off
is

   function Sum_Over (R : Running_Times) return Running_Time is
      Sum : Running_Time := 0.0;
   begin
      for Id in R'Range loop
         Sum := Sum + R(Id);
      end loop;
      return Sum;
   end Sum_Over;

   procedure Check_PDI is
   begin
      pragma Assert (Check_Sensors (The_PDI.The_Sensors));
      pragma Assert (Check_Calibration (The_PDI.The_Calibration_Slope,
                                        The_PDI.The_Calibration_Offset));
      pragma Assert (Check_Calibrations (The_PDI.The_Sensors,
                                         The_PDI.The_Calibrations));
      pragma Assert (Check_Memory_Zones (The_PDI.Zone1, The_PDI.Zone2));
      pragma Assert (Check_Frame_And_Coeffs (The_PDI.The_Frame,
                                             The_PDI.The_Coeffs));
      pragma Assert (Check_Failsafe (The_PDI.The_Battery,
                                     The_PDI.Failsafe_Threshold));
      pragma Assert (Check_Kind_Weight_Thrust (The_PDI.The_Frame,
                                               The_PDI.The_Weight,
                                               The_PDI.The_Thrust,
                                               The_PDI.The_Gravity));
      pragma Assert (Check_Frequency (The_PDI.The_Frequency,
                                      The_PDI.The_Baud_Rate,
                                      The_PDI.Max_Data));
   end Check_PDI;

   procedure Write_PDI (Filename : String) is
      F : File_Type;
      S : Stream_Access;
   begin
      Create (File => F,
              Mode => Out_File,
              Name => Filename);
      S := Stream (F);

      PDI'Output (S, The_PDI);

      Close (F);
   end Write_PDI;

   procedure Read_PDI  (Filename : String) is
      F : File_Type;
      S : Stream_Access;
   begin
      Open (File => F,
            Mode => In_File,
            Name => Filename);
      S := Stream (F);

      The_PDI := PDI'Input (S);

      Close (F);
   end Read_PDI;

end PDI;
