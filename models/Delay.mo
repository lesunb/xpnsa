block Delay
  Modelica.Blocks.Interfaces.BooleanInput u annotation(
    Placement(visible = true, transformation(origin = {-92, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-118, 1.9984e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation(
    Placement(visible = true, transformation(origin = {92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real delayTime;
  
protected
  Real value_input = if u then 1 else 0;
equation
  y = delay(value_input, delayTime) >= 0.5; 
  
  
  y = if u > 0 then u else 0;
  

  annotation(
    Diagram(graphics = {Rectangle(origin = {5, 0}, extent = {{-77, 60}, {77, -60}})}),
    uses(Modelica(version = "4.0.0")),
  Icon(graphics = {Ellipse(lineColor = {255, 0, 255}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-10, 90}, {10, 70}}), Ellipse(lineColor = {255, 0, 255}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{30, 50}, {50, 30}}), Line(origin = {-0.318181, (-0) - 7}, points = {{-80, -60}, {-80, 0}, {-106, 0}}, color = {255, 0, 255}), Ellipse(lineColor = {255, 0, 255}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{70, 10}, {90, -10}}), Ellipse(lineColor = {255, 0, 255}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 10}, {-30, -10}}), Line(origin = {0, -0.318178}, points = {{-80, -60}, {-40, -60}, {-40, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 80}, {40, 80}, {40, 40}, {80, 40}, {80, 0}, {80, 0}, {80, 0}, {100, 0}}, color = {255, 0, 255}), Ellipse(lineColor = {255, 0, 255}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-90, -50}, {-70, -70}}), Text(lineColor = {0, 0, 255}, extent = {{-150, 130}, {150, 90}}, textString = "%name")}));
end Delay;
