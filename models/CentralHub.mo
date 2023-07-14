model CentralHub
  Modelica.Blocks.Interfaces.RealInput oximeter_risk_pct annotation(
    Placement(visible = true, transformation(origin = {-109, 81}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-84, -106}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Detect detect annotation(
    Placement(visible = true, transformation(origin = {36, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput oximeter_sig_transfered annotation(
    Placement(visible = true, transformation(origin = {-109, 69}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-98, -106}, extent = {{-6, 6}, {6, -6}}, rotation = 90)));
  Battery battery annotation(
    Placement(visible = true, transformation(origin = {30, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Logical.And and11 annotation(
    Placement(visible = true, transformation(origin = {1, -7}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput recharge annotation(
    Placement(visible = true, transformation(origin = {78, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {62, 8}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_emergency annotation(
    Placement(visible = true, transformation(origin = {86, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 62}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_processed annotation(
    Placement(visible = true, transformation(origin = {86, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {62, -8}, extent = {{6, -6}, {-6, 6}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanInput temperature_sig_transfered annotation(
    Placement(visible = true, transformation(origin = {-109, 39}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {84, -106}, extent = {{-6, 6}, {6, -6}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput temperature_risk_pct annotation(
    Placement(visible = true, transformation(origin = {-109, 51}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {98, -106}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Data_fuse data_fuse annotation(
    Placement(visible = true, transformation(origin = {-48, 6}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {65, -37}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput heartRate_risk_pct annotation(
    Placement(visible = true, transformation(origin = {-109, 9}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {8, -106}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanInput heartRate_sig_transfered annotation(
    Placement(visible = true, transformation(origin = {-109, -3}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-6, -106}, extent = {{-6, 6}, {6, -6}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanInput abps_sig_transfered annotation(
    Placement(visible = true, transformation(origin = {-109, -65}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-98, 106}, extent = {{-6, 6}, {6, -6}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput abps_risk_pct annotation(
    Placement(visible = true, transformation(origin = {-109, -53}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-84, 106}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanInput abpd_sig_transfered annotation(
    Placement(visible = true, transformation(origin = {-109, -35}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {84, 106}, extent = {{-6, 6}, {6, -6}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput abpd_risk_pct annotation(
    Placement(visible = true, transformation(origin = {-109, -23}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {98, 106}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
equation
  sig_emergency = detect.emergency;
  sig_processed = detect.sig_detected;
  connect(recharge, battery.recharge) annotation(
    Line(points = {{78, -100}, {78, -64}, {54, -64}}, color = {255, 0, 255}));
  connect(battery.SIG_BATTERY_ON, and11.u2) annotation(
    Line(points = {{5, -60}, {-12, -60}, {-12, -13}, {-7, -13}}, color = {255, 0, 255}));
  connect(and11.y, detect.signal) annotation(
    Line(points = {{9, -7}, {22, -7}, {22, 1}, {27, 1}}, color = {255, 0, 255}));
  connect(oximeter_risk_pct, data_fuse.oximeter) annotation(
    Line(points = {{-109, 81}, {-76, 81}, {-76, 47}, {-70, 47}}, color = {0, 0, 127}));
  connect(oximeter_sig_transfered, data_fuse.sig_oximeter) annotation(
    Line(points = {{-109, 69}, {-80, 69}, {-80, 42}, {-70, 42}}, color = {255, 0, 255}));
  connect(temperature_risk_pct, data_fuse.temperature) annotation(
    Line(points = {{-109, 51}, {-84, 51}, {-84, 28}, {-70, 28}}, color = {0, 0, 127}));
  connect(temperature_sig_transfered, data_fuse.sig_temperature) annotation(
    Line(points = {{-109, 39}, {-86, 39}, {-86, 23}, {-70, 23}}, color = {255, 0, 255}));
  connect(data_fuse.overall_risk, detect.risk) annotation(
    Line(points = {{-24, 6}, {27, 6}}, color = {0, 0, 127}));
  connect(data_fuse.sig_data_fused, and11.u1) annotation(
    Line(points = {{-24, -23}, {-15.5, -23}, {-15.5, -7}, {-7, -7}}, color = {255, 0, 255}));
  connect(detect.sig_detected, or1.u1) annotation(
    Line(points = {{45, 1}, {65, 1}, {65, -29}}, color = {255, 0, 255}));
  connect(data_fuse.sig_data_fused, or1.u2) annotation(
    Line(points = {{-24, -23}, {59, -23}, {59, -29}}, color = {255, 0, 255}));
  connect(or1.y, battery.u) annotation(
    Line(points = {{65, -45}, {65, -56}, {54, -56}}, color = {255, 0, 255}));
  connect(heartRate_risk_pct, data_fuse.heartRate) annotation(
    Line(points = {{-108, 10}, {-70, 10}, {-70, 8}}, color = {0, 0, 127}));
  connect(heartRate_sig_transfered, data_fuse.sig_heartRate) annotation(
    Line(points = {{-108, -2}, {-80, -2}, {-80, 4}, {-70, 4}}, color = {255, 0, 255}));
  connect(abpd_risk_pct, data_fuse.abpd) annotation(
    Line(points = {{-108, -22}, {-84, -22}, {-84, -10}, {-70, -10}}, color = {0, 0, 127}));
  connect(abpd_sig_transfered, data_fuse.sig_abpd) annotation(
    Line(points = {{-108, -34}, {-80, -34}, {-80, -16}, {-70, -16}}, color = {255, 0, 255}));
  connect(abps_risk_pct, data_fuse.abps) annotation(
    Line(points = {{-109, -53}, {-78, -53}, {-78, -30}, {-70, -30}}, color = {0, 0, 127}));
  connect(abps_sig_transfered, data_fuse.sig_abps) annotation(
    Line(points = {{-109, -65}, {-76, -65}, {-76, -34}, {-70, -34}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Ellipse(lineColor = {255, 255, 255}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-54, 56}, {54, -56}}), Ellipse(origin = {-90, -90}, lineColor = {255, 255, 255}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Ellipse(origin = {0, -90}, lineColor = {255, 255, 255}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Ellipse(origin = {90, -90}, lineColor = {255, 255, 255}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Ellipse(origin = {-90, 90}, lineColor = {255, 255, 255}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Rectangle(origin = {0, -70}, fillColor = {0, 170, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-2, 16}, {2, -16}}), Text(origin = {2, 1}, rotation = 180, lineColor = {255, 255, 255}, extent = {{-48, 27}, {48, -27}}, textString = "%name"), Ellipse(origin = {90, 90}, lineColor = {255, 255, 255}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Polygon(origin = {-57, -58}, fillColor = {0, 170, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{23, 32}, {-17, 4}, {-31, -26}, {-29, -28}, {-9, 0}, {29, 22}, {29, 22}, {23, 32}}), Polygon(origin = {61, -61}, fillColor = {0, 170, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-19, 31}, {11, 9}, {29, -25}, {25, -27}, {5, 5}, {-27, 23}, {-27, 23}, {-19, 27}, {-19, 31}}), Polygon(origin = {-60, 63}, fillColor = {0, 170, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{18, -31}, {-14, -5}, {-30, 23}, {-26, 25}, {-10, 1}, {26, -23}, {26, -23}, {18, -31}}), Polygon(origin = {62, 59}, fillColor = {0, 170, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-22, -27}, {14, -1}, {26, 25}, {24, 27}, {10, 5}, {-28, -19}, {-28, -21}, {-22, -27}})}),
  Diagram,
  version = "");
end CentralHub;
