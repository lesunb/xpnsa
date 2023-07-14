block dynamic_clock
  Modelica.Clocked.ClockSignals.Interfaces.ClockOutput y annotation(
    Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput frequency annotation(
    Placement(visible = true, transformation(origin = {-42, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-72, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  //SI.Time period
  //"Period of clock (defined as Real number)" annotation(Evaluate=true);
equation
  y = Clock(frequency);
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(fillColor = {0, 0, 255}, fillPattern = FillPattern.Forward, extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 72}, extent = {{34, -20}, {-34, 20}}, textString = "Dynamic Clock")}));
end dynamic_clock;
