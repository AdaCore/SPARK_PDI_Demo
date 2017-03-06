with PDI; use PDI;

procedure Define_PDI
  with SPARK_Mode,
       Global => (Output => The_PDI)
is
begin

   ----------------------------------------------------------------------------
   --           START OF EDITING ZONE TO CHANGE THE VALUE OF PDI             --
   ----------------------------------------------------------------------------

   The_PDI :=
     (The_Sensors            =>
        (Primary             => Type_1,
         Secondary           => Type_2),
      The_Calibration_Slope  => 0.3,
      The_Calibration_Offset => 1.5,
      The_Calibrations       =>
        (Primary   => (Kind  => Type_1,
                       X     => 0.0,
                       Y     => 1.0),
         Secondary => (Kind  => Type_2,
                       A     => 0.0,
                       B     => 1.0,
                       C     => 5.0)),
      Zone1                  =>
        (Addr                => 16#FFFF0040#,
         S                   => 5432),
      Zone2                  =>
        (Addr                => 16#FFFF7040#,
         S                   => 32),
      The_Partitions         =>
        (Num_Task            => 4,
         RT => (1            => 4.0,
                2            => 45.4,
                3            => 42.0,
                4            => 3.14)),
      The_Frame              => Quadri,
      The_Coeffs             =>
        (1                   => (-0.8, 0.3),
         2                   => (-0.8, 0.3),
         3                   => (0.0, 1.8),
         4                   => (0.0, 0.3),
         5                   => (0.0, 0.3),
         6                   => (0.0, 1.8)),
      The_Battery            => B4S,
      Failsafe_Threshold     => 4.5,
      The_Weight             => 5.6,
      The_Thrust             => 40.3,
      The_Gravity            => 9.81,
      The_Frequency          => 10,
      The_Baud_Rate          => 50_000,
      Max_Data               => 1500);

   ----------------------------------------------------------------------------
   --            END OF EDITING ZONE TO CHANGE THE VALUE OF PDI              --
   ----------------------------------------------------------------------------

   declare
      Local_PDI : constant PDI.PDI := The_PDI;

   begin
      --  Check PDI values
      Check_PDI;

      --  Write PDI to file "the.pdi"
      Write_PDI ("the.pdi");

      --  Reload PDI from file "the.pdi" and check the value is the same as
      --  before
      Read_PDI ("the.pdi");

      pragma Assert (Local_PDI = The_PDI);
   end;
end Define_PDI;
