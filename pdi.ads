package PDI
  with SPARK_Mode
is
   ---------------------

   type Sensor_Kind is (Type_1, Type_2, Type_3);
   type Sensor_Id is (Primary, Secondary);
   type Sensors is array (Sensor_Id) of Sensor_Kind;

   --  Secondary sensor should be of a different kind than primary sensor
   function Check_Sensors (The_Sensors : Sensors) return Boolean is
      (The_Sensors(Secondary) /= The_Sensors(Primary));

   ---------------------

   subtype Calibration_Slope is Float range 0.2 .. 1.5;
   subtype Calibration_Offset is Float range -2.0 .. 2.0;

   --  The calibration slope should not exceed one fifth of the calibration
   --  offset
   function Check_Calibration
     (The_Calibration_Slope  : Calibration_Slope;
      The_Calibration_Offset : Calibration_Offset)
      return Boolean
   is
      (The_Calibration_Slope <= The_Calibration_Offset / 5.0);

   ---------------------

   type Calibration (Kind : Sensor_Kind := Type_1) is record
      case Kind is
         when Type_1 =>
            X, Y : Float;
         when Type_2 =>
            A, B, C : Float;
         when Type_3 =>
            Switched : Boolean;
      end case;
   end record;

   type Calibrations is array (Sensor_Id) of Calibration;

   --  The calibration of every sensor should match its kind
   function Check_Calibrations
     (The_Sensors      : Sensors;
      The_Calibrations : Calibrations) return Boolean
   is
      (for all Sensor in Sensor_Id =>
         The_Calibrations(Sensor).Kind = The_Sensors(Sensor));

   ---------------------

   type Memory is mod 2**32;
   subtype Addressable is Memory range 16#FFFF0000# .. 16#FFFFABCD#;
   subtype Size is Memory range 0 .. 2**16;

   type Memory_Zone is record
      Addr : Addressable;
      S    : Size;
   end record
     --  Objects of a given size at a given address should fit in addressable
     --  memory
     with Predicate => Addr + S - 1 in Addr .. Addressable'Last;

   function Before (A, B : Memory_Zone) return Boolean is
      (A.Addr + A.S - 1 < B.Addr);

   --  Objects of a given size at a given address should not overlap
   function Check_Memory_Zones
        (Zone1 : Memory_Zone;
         Zone2 : Memory_Zone)
         return Boolean
    is
      (Before (Zone1, Zone2) or Before (Zone2, Zone1));

   ---------------------

   type Task_Id is range 1 .. 10;
   Period : constant := 345.0;
   subtype Running_Time is Float range 0.0 .. Period;
   type Running_Times is array (Task_Id range <>) of Running_Time;

   function Sum_Over (R : Running_Times) return Running_Time;

   type Partitions (Num_Task : Task_Id := 1) is record
      RT : Running_Times (1 .. Num_Task);
   end record
     --  The sum of running times allocated to each task does not exceed the period
     with Predicate => (Sum_Over (RT) <= Period);

   ---------------------

   type Frame_Kind is (Quadri, Hexa);

   type Coeff is record
      Roll, Pitch : Float;
   end record;

   type Coeffs is array (Positive range 1 .. 6) of Coeff;

   --  Coefficient are constrainted depending on the kind of frame
   function Check_Frame_And_Coeffs
     (The_Frame : Frame_Kind;
      The_Coeffs : Coeffs)
      return Boolean
   is
      (case The_Frame is
         when Quadri => The_Coeffs(1).Roll = The_Coeffs(2).Roll
                          and The_Coeffs(5).Roll = 0.0
                          and The_Coeffs(6).Roll = 0.0,
         when Hexa   => The_Coeffs(1).Roll = The_Coeffs(3).Roll
                          and The_Coeffs(1).Pitch = The_Coeffs(6).Pitch);

   ---------------------

   type Battery_Kind is (B3S, B4S);

   function Max_Failsafe_Threshold (The_Battery : Battery_Kind) return Float is
      (case The_Battery is when B3S => 12.0, when B4S => 16.0);

   --  Failsafe threshold is constrained by the battery kind
   function Check_Failsafe
     (The_Battery : Battery_Kind;
      Failsafe_Threshold : Float)
      return Boolean
   is
      (Failsafe_Threshold <= Max_Failsafe_Threshold (The_Battery));

   ---------------------

   --  Frame kind, weight and thrust are constrained by gravity for smooth flights
   function Check_Kind_Weight_Thrust
     (The_Frame   : Frame_Kind;
      The_Weight  : Float;
      The_Thrust  : Float;
      The_Gravity : Float)
      return Boolean
   is
      (case The_Frame is
         when Quadri => 4.0 * The_Thrust / The_Weight > The_Gravity,
         when Hexa   => 6.0 * The_Thrust / The_Weight > 1.5 * The_Gravity);

   ---------------------

   --  We cannot transmit Max_Data at a given frequency if this exceeds the baud rate
   function Check_Frequency
     (The_Frequency : Positive;
      The_Baud_Rate : Positive;
      Max_Data      : Positive)
      return Boolean
   is
      (The_Frequency * Max_Data <= The_Baud_Rate);

   ---------------------

   type PDI is record
      The_Sensors            : Sensors;
      The_Calibration_Slope  : Calibration_Slope;
      The_Calibration_Offset : Calibration_Offset;
      The_Calibrations       : Calibrations;
      Zone1                  : Memory_Zone;
      Zone2                  : Memory_Zone;
      The_Partitions         : Partitions;
      The_Frame              : Frame_Kind;
      The_Coeffs             : Coeffs;
      The_Battery            : Battery_Kind;
      Failsafe_Threshold     : Float;
      The_Weight             : Float;
      The_Thrust             : Float;
      The_Gravity            : Float;
      The_Frequency          : Positive;
      The_Baud_Rate          : Positive;
      Max_Data               : Positive;
   end record;

   The_PDI : PDI;

   procedure Check_PDI;
   procedure Write_PDI (Filename : String);
   procedure Read_PDI  (Filename : String);

end PDI;
