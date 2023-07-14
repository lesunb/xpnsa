block FrequencyTrigger
  Modelica.Blocks.Interfaces.RealInput frequency annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput trigger annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

protected
  Real newEvent(start=0.0, fixed=false);
  
equation
  newEvent = if time >= (newEvent + 1e-10) then time + frequency else newEvent;
  trigger = if time >= newEvent then true else false;
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Line(points = {{-60, -70}, {-60, 70}}), Line(points = {{60, -70}, {60, 70}}), Line(points = {{-20, -70}, {-20, 70}}), Polygon(lineColor = {255, 0, 255}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}), Line(points = {{20, -70}, {20, 70}}), Line(points = {{-90, -70}, {72, -70}}, color = {255, 0, 255}), Line(points = {{-80, 66}, {-80, -82}}, color = {255, 0, 255}), Polygon(lineColor = {255, 0, 255}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, points = {{-80, 88}, {-88, 66}, {-72, 66}, {-80, 88}}), Ellipse(lineColor = {235, 235, 235}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, extent = {{71, 7}, {85, -7}}), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end FrequencyTrigger;
