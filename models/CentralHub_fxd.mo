model CentralHub_fxd
  Modelica.Blocks.Interfaces.RealInput oximeter_risk_pct annotation(
    Placement(visible = true, transformation(origin = {-109, 81}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-84, -106}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Detect detect annotation(
    Placement(visible = true, transformation(origin = {53, 11}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput oximeter_sig_transfered annotation(
    Placement(visible = true, transformation(origin = {-109, 69}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-98, -106}, extent = {{-6, 6}, {6, -6}}, rotation = 90)));
  Battery battery annotation(
    Placement(visible = true, transformation(origin = {46, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Logical.And and11 annotation(
    Placement(visible = true, transformation(origin = {23, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput recharge annotation(
    Placement(visible = true, transformation(origin = {78, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {-14, 66}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_emergency annotation(
    Placement(visible = true, transformation(origin = {86, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {4, 72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_processed annotation(
    Placement(visible = true, transformation(origin = {86, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {26, 66}, extent = {{6, -6}, {-6, 6}}, rotation = 270)));
  Modelica.Blocks.Interfaces.BooleanInput temperature_sig_transfered annotation(
    Placement(visible = true, transformation(origin = {-109, 39}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {84, -106}, extent = {{-6, 6}, {6, -6}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput temperature_risk_pct annotation(
    Placement(visible = true, transformation(origin = {-109, 51}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {98, -106}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Data_fuse_fxd data_fuse annotation(
    Placement(visible = true, transformation(origin = {-38, 6}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {81, -37}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
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
  Modelica.Blocks.Interfaces.BooleanOutput sig_abps_processed annotation(
    Placement(visible = true, transformation(origin = {-12, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-66, 10}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_abpd_processed annotation(
    Placement(visible = true, transformation(origin = {8, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {66, 14}, extent = {{6, -6}, {-6, 6}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_oximeter_processed annotation(
    Placement(visible = true, transformation(origin = {-16, 100}, extent = {{10, -10}, {-10, 10}}, rotation = -90), iconTransformation(origin = {-66, -12}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_temperature_processed annotation(
    Placement(visible = true, transformation(origin = {2, 100}, extent = {{10, -10}, {-10, 10}}, rotation = -90), iconTransformation(origin = {66, 0}, extent = {{6, -6}, {-6, 6}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_heartrate_processed annotation(
    Placement(visible = true, transformation(origin = {22, 100}, extent = {{10, -10}, {-10, 10}}, rotation = -90), iconTransformation(origin = {66, -14}, extent = {{6, -6}, {-6, 6}}, rotation = 180)));
  Transfer oximeter_receive_data(delayMax = 1)  annotation(
    Placement(visible = true, transformation(origin = {-86, 74}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Transfer temperature_receive_data(delayMax = 1)  annotation(
    Placement(visible = true, transformation(origin = {-86, 44}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Transfer heartrate_receive_data(delayMax = 1)  annotation(
    Placement(visible = true, transformation(origin = {-86, 8}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Transfer abpd_receive_data(delayMax = 1)  annotation(
    Placement(visible = true, transformation(origin = {-86, -22}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Transfer abps_receive_data(delayMax = 1)  annotation(
    Placement(visible = true, transformation(origin = {-86, -52}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_detected annotation(
    Placement(visible = true, transformation(origin = {86, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-28, 66}, extent = {{6, -6}, {-6, 6}}, rotation = 270)));
equation
  sig_emergency = detect.emergency;
  sig_processed = data_fuse.sig_data_fused;
  sig_detected = detect.sig_detected;
  connect(recharge, battery.recharge) annotation(
    Line(points = {{78, -100}, {78, -64}, {70, -64}}, color = {255, 0, 255}));
  connect(battery.SIG_BATTERY_ON, and11.u2) annotation(
    Line(points = {{21.2, -60}, {4.2, -60}, {4.2, -19}, {15.2, -19}}, color = {255, 0, 255}));
  connect(and11.y, detect.signal) annotation(
    Line(points = {{30.7, -13}, {37.7, -13}, {37.7, 6}, {42.7, 6}}, color = {255, 0, 255}));
  connect(data_fuse.overall_risk, detect.risk) annotation(
    Line(points = {{-14, 11}, {43, 11}}, color = {0, 0, 127}));
  connect(data_fuse.sig_data_fused, and11.u1) annotation(
    Line(points = {{-14, 1}, {4.5, 1}, {4.5, -13}, {15, -13}}, color = {255, 0, 255}));
  connect(detect.sig_detected, or1.u1) annotation(
    Line(points = {{62.9, 5.5}, {80.9, 5.5}, {80.9, -28.5}}, color = {255, 0, 255}));
  connect(data_fuse.sig_data_fused, or1.u2) annotation(
    Line(points = {{-14, 1}, {75, 1}, {75, -29}}, color = {255, 0, 255}));
  connect(or1.y, battery.u) annotation(
    Line(points = {{81, -44.7}, {81, -55.7}, {70, -55.7}}, color = {255, 0, 255}));
  connect(data_fuse.sig_abps_processed, sig_abps_processed) annotation(
    Line(points = {{-16, -40}, {-12.4, -40}, {-12.4, -99.6}}, color = {255, 0, 255}));
  connect(data_fuse.sig_abpd_processed, sig_abpd_processed) annotation(
    Line(points = {{-16, -35}, {-6.4, -35}, {-6.4, -80.8}, {7.6, -80.8}, {7.6, -100.8}}, color = {255, 0, 255}));
  connect(data_fuse.sig_oximeter_processed, sig_oximeter_processed) annotation(
    Line(points = {{-16, 52}, {-16, 100}}, color = {255, 0, 255}));
  connect(data_fuse.sig_temperature_processed, sig_temperature_processed) annotation(
    Line(points = {{-16, 47}, {2, 47}, {2, 100}}, color = {255, 0, 255}));
  connect(data_fuse.sig_heartrate_processed, sig_heartrate_processed) annotation(
    Line(points = {{-16, 42}, {22, 42}, {22, 100}}, color = {255, 0, 255}));
  connect(oximeter_risk_pct, oximeter_receive_data.u) annotation(
    Line(points = {{-108, 82}, {-96, 82}, {-96, 78}, {-92, 78}, {-92, 74}}, color = {0, 0, 127}));
  connect(oximeter_sig_transfered, oximeter_receive_data.sig_processed) annotation(
    Line(points = {{-108, 70}, {-92, 70}}, color = {255, 0, 255}));
  connect(oximeter_receive_data.sig_transfered, data_fuse.sig_oximeter) annotation(
    Line(points = {{-80, 70}, {-70, 70}, {-70, 42}, {-60, 42}}, color = {255, 0, 255}));
  connect(oximeter_receive_data.y, data_fuse.oximeter) annotation(
    Line(points = {{-80, 74}, {-66, 74}, {-66, 46}, {-60, 46}}, color = {0, 0, 127}));
  connect(temperature_risk_pct, temperature_receive_data.u) annotation(
    Line(points = {{-108, 52}, {-96, 52}, {-96, 44}, {-92, 44}}, color = {0, 0, 127}));
  connect(temperature_sig_transfered, temperature_receive_data.sig_processed) annotation(
    Line(points = {{-108, 40}, {-92, 40}}, color = {255, 0, 255}));
  connect(temperature_receive_data.y, data_fuse.temperature) annotation(
    Line(points = {{-80, 44}, {-72, 44}, {-72, 28}, {-60, 28}}, color = {0, 0, 127}));
  connect(temperature_receive_data.sig_transfered, data_fuse.sig_temperature) annotation(
    Line(points = {{-80, 40}, {-74, 40}, {-74, 22}, {-60, 22}}, color = {255, 0, 255}));
  connect(heartRate_risk_pct, heartrate_receive_data.u) annotation(
    Line(points = {{-109, 9}, {-101, 9}, {-101, 8}, {-92, 8}}, color = {0, 0, 127}));
  connect(heartRate_sig_transfered, heartrate_receive_data.sig_processed) annotation(
    Line(points = {{-109, -3}, {-98, -3}, {-98, 4}, {-92, 4}}, color = {255, 0, 255}));
  connect(heartrate_receive_data.y, data_fuse.heartRate) annotation(
    Line(points = {{-80, 8}, {-60, 8}}, color = {0, 0, 127}));
  connect(heartrate_receive_data.sig_transfered, data_fuse.sig_heartRate) annotation(
    Line(points = {{-80, 4}, {-60, 4}}, color = {255, 0, 255}));
  connect(abpd_risk_pct, abpd_receive_data.u) annotation(
    Line(points = {{-108, -22}, {-92, -22}}, color = {0, 0, 127}));
  connect(abpd_sig_transfered, abpd_receive_data.sig_processed) annotation(
    Line(points = {{-108, -34}, {-98, -34}, {-98, -26}, {-92, -26}}, color = {255, 0, 255}));
  connect(abpd_receive_data.y, data_fuse.abpd) annotation(
    Line(points = {{-80, -22}, {-78, -22}, {-78, -10}, {-60, -10}}, color = {0, 0, 127}));
  connect(abpd_receive_data.sig_transfered, data_fuse.sig_abpd) annotation(
    Line(points = {{-80, -26}, {-74, -26}, {-74, -16}, {-60, -16}}, color = {255, 0, 255}));
  connect(abps_risk_pct, abps_receive_data.u) annotation(
    Line(points = {{-108, -52}, {-92, -52}}, color = {0, 0, 127}));
  connect(abps_sig_transfered, abps_receive_data.sig_processed) annotation(
    Line(points = {{-108, -64}, {-96, -64}, {-96, -56}, {-92, -56}}, color = {255, 0, 255}));
  connect(abps_receive_data.y, data_fuse.abps) annotation(
    Line(points = {{-80, -52}, {-72, -52}, {-72, -30}, {-60, -30}}, color = {0, 0, 127}));
  connect(abps_receive_data.sig_transfered, data_fuse.sig_abps) annotation(
    Line(points = {{-80, -56}, {-68, -56}, {-68, -34}, {-60, -34}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Ellipse(lineColor = {255, 255, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-54, 56}, {54, -56}}), Ellipse(origin = {-90, -90}, lineColor = {255, 255, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Ellipse(origin = {0, -90}, lineColor = {255, 255, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Ellipse(origin = {90, -90}, lineColor = {255, 255, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Ellipse(origin = {-90, 90}, lineColor = {255, 255, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Rectangle(origin = {0, -70}, fillColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-2, 16}, {2, -16}}), Text(origin = {2, 1}, rotation = 180, textColor = {255, 255, 255}, extent = {{-48, 27}, {48, -27}}, textString = "%name"), Ellipse(origin = {90, 90}, lineColor = {255, 255, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}), Polygon(origin = {-57, -58}, fillColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{23, 32}, {-17, 4}, {-31, -26}, {-29, -28}, {-9, 0}, {29, 22}, {29, 22}, {23, 32}}), Polygon(origin = {61, -61}, fillColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-19, 31}, {11, 9}, {29, -25}, {25, -27}, {5, 5}, {-27, 23}, {-27, 23}, {-19, 27}, {-19, 31}}), Polygon(origin = {-60, 63}, fillColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{18, -31}, {-14, -5}, {-30, 23}, {-26, 25}, {-10, 1}, {26, -23}, {26, -23}, {18, -31}}), Polygon(origin = {62, 59}, fillColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-22, -27}, {14, -1}, {26, 25}, {24, 27}, {10, 5}, {-28, -19}, {-28, -21}, {-22, -27}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram,
    version = "");
end CentralHub_fxd;
