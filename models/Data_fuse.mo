block Data_fuse
  Modelica.Blocks.Interfaces.RealInput oximeter annotation(
    Placement(visible = true, transformation(origin = {-111, 87}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput temperature annotation(
    Placement(visible = true, transformation(origin = {-111, 49}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, 45}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput overall_risk annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler trigg_ox annotation(
    Placement(visible = true, transformation(origin = {-49, 87}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_oximeter annotation(
    Placement(visible = true, transformation(origin = {-111, 71}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, 75}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_temperature annotation(
    Placement(visible = true, transformation(origin = {-111, 33}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler trigg_temp annotation(
    Placement(visible = true, transformation(origin = {-49, 49}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_data_fused annotation(
    Placement(visible = true, transformation(origin = {110, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {4, 22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_heartRate annotation(
    Placement(visible = true, transformation(origin = {-111, -7}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, -5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput heartRate annotation(
    Placement(visible = true, transformation(origin = {-111, 9}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, 5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or11 annotation(
    Placement(visible = true, transformation(origin = {27, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler trigg_hr annotation(
    Placement(visible = true, transformation(origin = {-49, 9}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput abpd annotation(
    Placement(visible = true, transformation(origin = {-111, -33}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, -35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_abpd annotation(
    Placement(visible = true, transformation(origin = {-111, -49}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, -45}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput abps annotation(
    Placement(visible = true, transformation(origin = {-111, -73}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, -75}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_abps annotation(
    Placement(visible = true, transformation(origin = {-111, -89}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-45, -85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler trigg_abpd annotation(
    Placement(visible = true, transformation(origin = {-49, -33}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler trigg_abps annotation(
    Placement(visible = true, transformation(origin = {-47, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or12 annotation(
    Placement(visible = true, transformation(origin = {27, -27}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or13 annotation(
    Placement(visible = true, transformation(origin = {70, -44}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
equation
  when or1.y then
    overall_risk = DataFuse(oximeter, temperature, heartRate, abpd, abps);
  end when;
  connect(oximeter, trigg_ox.u) annotation(
    Line(points = {{-111, 87}, {-57, 87}}, color = {0, 0, 127}));
  connect(sig_oximeter, trigg_ox.trigger) annotation(
    Line(points = {{-111, 71}, {-49, 71}, {-49, 79}}, color = {255, 0, 255}));
  connect(temperature, trigg_temp.u) annotation(
    Line(points = {{-111, 49}, {-57, 49}}, color = {0, 0, 127}));
  connect(sig_temperature, trigg_temp.trigger) annotation(
    Line(points = {{-111, 33}, {-49, 33}, {-49, 41}}, color = {255, 0, 255}));
  connect(sig_heartRate, or11.u2) annotation(
    Line(points = {{-111, -7}, {19, -7}}, color = {255, 0, 255}));
  connect(sig_oximeter, or1.u1) annotation(
    Line(points = {{-111, 71}, {-18, 71}, {-18, 22}, {-4, 22}}, color = {255, 0, 255}));
  connect(sig_temperature, or1.u2) annotation(
    Line(points = {{-111, 33}, {-18, 33}, {-18, 18}, {-4, 18}}, color = {255, 0, 255}));
  connect(heartRate, trigg_hr.u) annotation(
    Line(points = {{-111, 9}, {-57, 9}}, color = {0, 0, 127}));
  connect(or1.y, or11.u1) annotation(
    Line(points = {{10, 22}, {16, 22}, {16, -1}, {19, -1}}, color = {255, 0, 255}));
  connect(sig_heartRate, trigg_hr.trigger) annotation(
    Line(points = {{-111, -7}, {-49, -7}, {-49, 1}}, color = {255, 0, 255}));
  connect(abpd, trigg_abpd.u) annotation(
    Line(points = {{-110, -32}, {-58, -32}}, color = {0, 0, 127}));
  connect(abps, trigg_abps.u) annotation(
    Line(points = {{-110, -72}, {-84, -72}, {-84, -73}, {-55, -73}}, color = {0, 0, 127}));
  connect(sig_abps, trigg_abps.trigger) annotation(
    Line(points = {{-110, -88}, {-47, -88}, {-47, -81}}, color = {255, 0, 255}));
  connect(sig_abpd, trigg_abpd.trigger) annotation(
    Line(points = {{-111, -49}, {-49, -49}, {-49, -41}}, color = {255, 0, 255}));
  connect(sig_abpd, or12.u1) annotation(
    Line(points = {{-111, -49}, {4, -49}, {4, -26}, {18, -26}}, color = {255, 0, 255}));
  connect(sig_abps, or12.u2) annotation(
    Line(points = {{-110, -88}, {4, -88}, {4, -32}, {18, -32}}, color = {255, 0, 255}));
  connect(or13.y, sig_data_fused) annotation(
    Line(points = {{79, -44}, {110, -44}}, color = {255, 0, 255}));
  connect(or11.y, or13.u1) annotation(
    Line(points = {{34, 0}, {52, 0}, {52, -44}, {60, -44}}, color = {255, 0, 255}));
  connect(or12.y, or13.u2) annotation(
    Line(points = {{34, -26}, {48, -26}, {48, -50}, {60, -50}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(fillColor = {230, 243, 201}, fillPattern = FillPattern.Solid, extent = {{-40, 100}, {40, -100}}), Line(origin = {17.6705, 26.8019}, points = {{-58.198, 53.1981}, {-38.1981, 53.1981}, {-12.1981, -26.8019}, {21.8019, -26.8019}, {21.8019, -26.8019}}), Line(origin = {-48.66, 39.7538}, points = {{9, 0}, {41, 0}, {41, 0}, {41, 0}}), Line(origin = {-48.66, 39.7538}, points = {{9, 0}, {41, 0}, {41, 0}, {41, 0}}), Line(origin = {-35.2133, -0.222753}, points = {{9, 0}, {41, 0}, {41, 0}, {41, 0}}), Line(origin = {-35.2133, -0.222753}, points = {{-5, 0}, {41, 0}, {41, 0}, {41, 0}})}));
end Data_fuse;
