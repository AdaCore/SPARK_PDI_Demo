with Ada.Text_IO; use Ada.Text_IO;
with PDI; use PDI;

procedure Print_PDI is
begin
   Read_PDI ("the.pdi");

   Put_Line ("   The_PDI =");
   Put_Line ("     (The_Sensors            =>");
   Put_Line ("        (Primary             => " & Sensor_Kind'Image (The_PDI.The_Sensors (Primary)) & ",");
   Put_Line ("         Secondary           => " & Sensor_Kind'Image (The_PDI.The_Sensors (Secondary)) & "),");
   Put_Line ("      The_Calibration_Slope  =>" & Float'Image (The_PDI.The_Calibration_Slope) & ",");
   Put_Line ("      The_Calibration_Offset =>" & Float'Image (The_PDI.The_Calibration_Offset) & ",");
   Put_Line ("      The_Calibrations       =>");
   Put_Line ("        (Primary   => (Kind  => " & Sensor_Kind'Image (The_PDI.The_Calibrations (Primary).Kind) & ",");
   Put_Line ("                       X     =>" & Float'Image (The_PDI.The_Calibrations (Primary).X) & ",");
   Put_Line ("                       Y     =>" & Float'Image (The_PDI.The_Calibrations (Primary).Y) & "),");
   Put_Line ("         Secondary => (Kind  => " & Sensor_Kind'Image (The_PDI.The_Calibrations (Secondary).Kind) & ",");
   Put_Line ("                       A     =>" & Float'Image (The_PDI.The_Calibrations (Secondary).A) & ",");
   Put_Line ("                       B     =>" & Float'Image (The_PDI.The_Calibrations (Secondary).B) & ",");
   Put_Line ("                       C     =>" & Float'Image (The_PDI.The_Calibrations (Secondary).C) & ")),");
   Put_Line ("      Zone1                  =>");
   Put_Line ("        (Addr                =>" & Addressable'Image (The_PDI.Zone1.Addr) & ",");
   Put_Line ("         S                   =>" & Size'Image (The_PDI.Zone1.S) & "),");
   Put_Line ("      Zone2                  =>");
   Put_Line ("        (Addr                =>" & Addressable'Image (The_PDI.Zone2.Addr) & ",");
   Put_Line ("         S                   =>" & Size'Image (The_PDI.Zone2.S) & "),");
   Put_Line ("      The_Partitions         =>");
   Put_Line ("        (Num_Task            =>" & Task_Id'Image (The_PDI.The_Partitions.Num_Task) & ",");
   Put_Line ("         RT => (");

   for Id in 1 .. The_PDI.The_Partitions.Num_Task loop
      Put_Line ("               " & Task_Id'Image (Id) & "            => " & Running_Time'Image (The_PDI.The_Partitions.RT (Id)) & ",");
   end loop;
   Put_Line ("               )),");

   Put_Line ("      The_Frame              => " & Frame_Kind'Image (The_PDI.The_Frame) & ",");
   Put_Line ("      The_Coeffs             =>");
   Put_Line ("        (");

   for C in 1 .. 6 loop
      Put_Line ("        " & Integer'Image (C) & "                   => (" & Float'Image (The_PDI.The_Coeffs (C).Roll) & ","& Float'Image (The_PDI.The_Coeffs (C).Pitch) & "),");
   end loop;
   Put_Line ("        ),");

   Put_Line ("      The_Battery            => " & Battery_Kind'Image (The_PDI.The_Battery) & ",");
   Put_Line ("      Failsafe_Threshold     =>" & Float'Image (The_PDI.Failsafe_Threshold) & ",");
   Put_Line ("      The_Weight             =>" & Float'Image (The_PDI.The_Weight) & ",");
   Put_Line ("      The_Thrust             =>" & Float'Image (The_PDI.The_Thrust) & ",");
   Put_Line ("      The_Gravity            =>" & Float'Image (The_PDI.The_Gravity) & ",");
   Put_Line ("      The_Frequency          =>" & Integer'Image (The_PDI.The_Frequency) & ",");
   Put_Line ("      The_Baud_Rate          =>" & Integer'Image (The_PDI.The_Baud_Rate) & ",");
   Put_Line ("      Max_Data               =>" & Integer'Image (The_PDI.Max_Data) & ")");

end Print_PDI;
