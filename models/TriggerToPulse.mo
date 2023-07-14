block TriggerToPulse
  parameter Modelica.Units.SI.Time Twidth = 0.5;
  Modelica.Blocks.Interfaces.BooleanInput u annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation(
    Placement(visible = true, transformation(origin = {86, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  discrete Modelica.Units.SI.Time pulseStart "Start time of pulse"
    annotation (HideResult=true);
  
equation
  when u then
    pulseStart = time;
  end when;
  y = time >= pulseStart and time < pulseStart + Twidth;
  
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}})}));
end TriggerToPulse;
